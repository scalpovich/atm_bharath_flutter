import 'dart:convert';
import 'package:atm_flutter_app/model/bbps/mobile_recharge.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';
import '../../../../constants/database_constants.dart';
import '../../../../helper/prefManager.dart';
import '../../../../model/bbps/bbps_report.dart';
import '../../../../resources/app_drawables.dart';
import '../../../../retrofit/api_service.dart';
import '../../../../retrofit/apis.dart';
import '../../../../retrofit/body/bbps_body.dart';
import '../../../../retrofit/headers.dart';
import '../../../../utils/aes_encryption.dart';
import '../../../../utils/api_req_res_format.dart';
import '../../../../utils/utils.dart';
import '../../payment_history/report_details/bbps_payment_details_binding.dart';
import '../../payment_history/report_details/bbps_payment_details_page.dart';

class MobileRechargeController extends MainController {
  dynamic arguments = Get.arguments;

  RxBool payBtnClicked = false.obs;
  RxString operatorImg = ''.obs;
  late String mobileNo,
      name,
      circle,
      amount,
      cusMobile,
      planName,
      operatorIdValue,
      planId,
      planDescription,
      operator;
  RxString latLng = ''.obs;
  RxString postalCode = ''.obs;
  RxString macAddress = ''.obs;
  RxString ipAddress = ''.obs;
  WifiInfoWrapper? _wifiObject;
  RxList<BBPSReport> reportList = <BBPSReport>[].obs;
  late Position currentPosition;
  RxString planValue = ''.obs;
  RxBool btnClicked = false.obs;
  String traceId = Utils().getSaltString();

  @override
  void onInit() {
    super.onInit();
    mobileNo = arguments[AppStrings.txtMobileNo];
    name = arguments[AppStrings.txtSenderName];
    cusMobile = arguments[AppStrings.txtSenderMobile];
    planName = arguments[AppStrings.txtOperator];
    circle = arguments[AppStrings.txtCircle];
    planId = arguments[AppStrings.txtPlanId];
    planDescription = arguments[AppStrings.txtPlanDescription];
    amount = arguments[AppStrings.txtAmount];
    operatorIdValue = arguments[AppStrings.txtOperatorId];
    operator = arguments[AppStrings.txtOperator];
    setOperatorImage();
    getUserCurrentLocation();
    initPlatformState();
  }

  ///mobile recharge api
  void mobileRechargePayment() async {
    List<String> authenticatorsList = [];
    dynamic authenticators = {
      'parameter_name': 'Mobile Number',
      'value': mobileNo
    };
    dynamic addValidation = await checkOperatorsServices(planName);
    final jsonAuth = jsonEncode(authenticators);
    authenticatorsList.add(jsonAuth);
    await savePaymentDetailsToDB();
    dynamic body = await bbpsPaymentValidationBody(
        billerId: operatorIdValue,
        senderName: name,
        circleName: circle,
        additionalValidation: addValidation,
        authenticators: authenticatorsList,
        paymentAmount: amount,
        mobileNo: mobileNo,
        geocode: latLng.value,
        postalCode: postalCode.value,
        mac: macAddress.value,
        ip: ipAddress.value,
        isBBPS: 'N',
        billerCategory: AppStrings.txtMobileRecharge);
    final jsonBody = json.encode(body);
    String jsonBodyEncode = jsonBody.replaceAll(r'\', '');
    String requestBody = jsonBodyEncode.replaceAll('["', '[');
    String bodyReq = requestBody.replaceAll('"]', ']');
    String encryptedBody = await AesEncryption().encrypt(
        bodyReq,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    Map<String, String> header = await bbpsCommonHeader();
    final plansResponse = await ApiService().postMethod(
        reqBody,
        header,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.MOBILE_RECHARGE);
    btnClicked.value = false;
    if (plansResponse != null) {
      if (plansResponse.status!) {
        dynamic dataResult = plansResponse.data;
        final encode = json.encode(dataResult);
        final decode = json.decode(encode);
        final result = MobileRecharge.fromJson(decode);
        convertToBBPSReport(result);
      } else {
        payBtnClicked.value = false;
        snackBar(plansResponse.message.toString());
      }
    } else {
      payBtnClicked.value = false;
      snackBar('error_network_timeout'.tr);
    }
  }

  ///convert mobile recharge details to bbps
  void convertToBBPSReport(MobileRecharge report) async {
    String endCusMobile = await AesEncryption()
        .encrypt(cusMobile, PrefManager().getCustomerCode.toString());
    String mobile = await AesEncryption().encrypt(
        report.authenticators![0].value.toString(),
        PrefManager().getCustomerCode.toString());
    String txnDate = report.txnDateTime.toString();
    List<String> splitTime = txnDate.split(' ');
    List<String> splitDate = splitTime[0].split('-');
    String mergeDate =
        '${splitDate[2]}-${splitDate[1]}-${splitDate[0]}T${splitTime[1]}+00';
    String id = report.transactionId.toString();
    List<String> transIdList = id.split('.');
    String txnId = transIdList[0];
    int transId = int.parse(txnId);
    BBPSReport bbpsReport = BBPSReport(
      transactionId: transId,
      transactionDate: mergeDate,
      commissionAmount: '',
      status: report.billerStatus,
      type: '',
      cess: '',
      sgst: '',
      cgst: '',
      benefAccName: '',
      transferMode: '',
      amount: report.paymentAmount,
      endCstmrName: name,
      endCstmrMob: endCusMobile,
      benefAccNo: '',
      benfIfsc: '',
      billerLogo: '',
      statusDescription: '',
      tranType: 'bbps',
      parameterName: report.parameterName,
      parameterValue: mobile,
      bbpsRefNo: '',
      billerName: report.billerName,
      billerId: report.billerid,
      convFee: '0.0',
      isBillerBbps: 'N',
      paymentChannel: 'AGENT',
      referenceNo: '',
      billerCategory: report.billerCategory,
      authCount: '2',
      paymentId: report.paymentid,
      traceId: traceId,
    );
    if (bbpsReport.status == 'SUCCESS') {
      String money =
          PrefManager().getWalletMoney.toString().replaceAll(',', '');
      List<String> wallet = money.split('.');
      String walletMoney = wallet[0];
      double finalAmount = double.parse(walletMoney) -
          double.parse(bbpsReport.amount.toString());
      String? userWallet = Utils().convertDecimal(finalAmount);
      PrefManager().setWalletMoney(userWallet.toString());
    }
    await updatePaymentDetailsToDB(bbpsReport);
    payBtnClicked.value = false;
    goToRechargeSummaryPage(bbpsReport);
  }

  /// error snackbar
  void snackBar(String message) {
    Get.snackbar(
      '',
      '',
      messageText: Center(
        child: Text(
          message,
          style: TextStyle(
            color: Theme.of(Get.context!).textTheme.bodyText1!.color!,
          ),
        ),
      ),
      backgroundColor: Theme.of(Get.context!).primaryColor,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10),
    );
  }

  ///save mobile recharge details to database
  Future<void> savePaymentDetailsToDB() async {
    String endCusMobile = await AesEncryption()
        .encrypt(cusMobile, PrefManager().getCustomerCode.toString());
    String params = await AesEncryption()
        .encrypt(mobileNo, PrefManager().getCustomerCode.toString());
    BBPSReport bbpsReport = BBPSReport(
      transactionId: 0,
      transactionDate:
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()).toString(),
      commissionAmount: '',
      status: 'PENDING',
      type: '',
      cess: '',
      sgst: '',
      cgst: '',
      benefAccName: '',
      transferMode: 'CASH',
      amount: amount,
      endCstmrName: name,
      endCstmrMob: endCusMobile,
      benefAccNo: '',
      benfIfsc: '',
      billerLogo: '',
      statusDescription: '',
      tranType: 'bbps',
      parameterName: 'Mobile Number',
      parameterValue: params,
      bbpsRefNo: '',
      billerName: operator,
      billerId: operatorIdValue,
      convFee: '0.0',
      isBillerBbps: 'N',
      paymentChannel: 'AGENT',
      referenceNo: '',
      billerCategory: 'Mobile Recharge',
      authCount: '2',
      paymentId: '',
      traceId: traceId,
    );
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool isTableNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbBBPSReports);
    if (isTableNotEmpty) {
      List<BBPSReport> bbpsList =
          box.get(DatabaseConstants.dbBBPSReports).toList().cast<BBPSReport>();
      bbpsList.add(bbpsReport);
      box.put(DatabaseConstants.dbBBPSReports, bbpsList);
    } else {
      box.put(DatabaseConstants.dbBBPSReports, bbpsReport);
    }
  }

  ///update recharge details in db after getting api response
  Future<void> updatePaymentDetailsToDB(BBPSReport bbpsReport) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<BBPSReport> listReport =
        box.get(DatabaseConstants.dbBBPSReports).toList().cast<BBPSReport>();
    final index =
        listReport.indexWhere((element) => element.transactionId == 0);
    reportList.clear();
    reportList.value = listReport;
    reportList.insert(index, bbpsReport);
    reportList.removeAt(index + 1);
    box.put(DatabaseConstants.dbBBPSReports, reportList.toList());
  }

  ///go to next page after getting the result from api
  goToRechargeSummaryPage(BBPSReport report) {
    Get.to(() => const BBPSPaymentDetailsPage(),
        binding: BBPSPaymentDetailsBinding(),
        arguments: {
          AppStrings.txtParameterName: report.parameterName,
          AppStrings.txtParameterValue: report.parameterValue,
          AppStrings.txtBillAmount: report.amount,
          AppStrings.txtSenderName: report.endCstmrName,
          AppStrings.txtStatus: report.status,
          AppStrings.txtSenderMobile: report.endCstmrMob,
          AppStrings.txtBillerName: report.billerName,
          AppStrings.txtBillerId: report.billerId,
          AppStrings.txtBBPSRefNo: report.bbpsRefNo,
          AppStrings.txtBillDate: report.transactionDate,
          AppStrings.txtPaymentId: report.paymentId,
          AppStrings.txtPaymentChannel: report.paymentChannel,
          AppStrings.txtPaymentMode: report.transferMode,
          AppStrings.txtTraceId: report.traceId,
          'home': true,
        });
  }

  ///checking operators available services
  dynamic checkOperatorsServices(String planName) async {
    dynamic additionalValidation;
    if (operator == "BSNLPRE") {
      if (planName == "Topup") {
        planValue.value = "1";
      } else {
        planValue.value = "3";
      }
      additionalValidation = {
        'parameter_name': 'Recharge Type',
        'value': planValue.value
      };
    }
    if (operatorIdValue == 'JIOPRE') {
      additionalValidation = {
        'parameter_name': 'Recharge Planid',
        'value': planId
      };
    }
    return additionalValidation;
  }

  ///setting operator image
  void setOperatorImage() {
    switch (operatorIdValue) {
      case 'AIRTELPRE':
        operatorImg.value = AppDrawable.airtelIcon;
        break;
      case 'BSNLPRE':
        operatorImg.value = AppDrawable.bsnlIcon;
        break;
      case 'VODAFONPRE':
        operatorImg.value = AppDrawable.viIcon;
        break;
      case 'JIOPRE':
        operatorImg.value = AppDrawable.jioIcon;
        break;
      case 'MTNLDELPRE':
        operatorImg.value = AppDrawable.mtnlIcon;
        break;
      case 'MTNLMUMPRE':
        operatorImg.value = AppDrawable.mtnlIcon;
        break;
    }
  }

  ///getting current location
  void getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latLng.value = '${currentPosition.latitude},${currentPosition.longitude}';
    getPostalCodeFromLocation();
  }

  ///getting postal code from location
  void getPostalCodeFromLocation() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      postalCode.value = place.postalCode.toString();
    } catch (e) {
      print(e);
    }
  }

  ///getting ip and mac
  Future<void> initPlatformState() async {
    WifiInfoWrapper? wifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}

    _wifiObject = wifiObject;
    ipAddress.value =
        _wifiObject != null ? _wifiObject!.ipAddress.toString() : "...";

    macAddress.value =
        _wifiObject != null ? _wifiObject!.macAddress.toString() : '...';
  }

  ///pay button click function
  void onPayTap() {
    payBtnClicked.value = true;
    btnClicked.value = true;
    mobileRechargePayment();
  }
}
