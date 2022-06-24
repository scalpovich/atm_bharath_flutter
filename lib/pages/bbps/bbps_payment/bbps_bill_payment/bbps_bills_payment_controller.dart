import 'dart:convert';
import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/model/bbps/bbps_category.dart';
import 'package:atm_flutter_app/pages/bbps/payment_history/report_details/bbps_payment_details_binding.dart';
import 'package:atm_flutter_app/pages/bbps/payment_history/report_details/bbps_payment_details_page.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../constants/database_constants.dart';
import '../../../../helper/prefManager.dart';
import '../../../../model/bbps/bbps_report.dart';
import '../../../../resources/app_strings.dart';
import '../../../../retrofit/api_service.dart';
import '../../../../retrofit/apis.dart';
import '../../../../retrofit/body/bbps_body.dart';
import '../../../../retrofit/headers.dart';
import '../../../../utils/aes_encryption.dart';
import '../../../../utils/api_req_res_format.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/dialog_box_widget/snack_bar.dart';

class BBPSBillsPaymentController extends MainController {
  dynamic arguments = Get.arguments;
  RxString planDescription = ''.obs;
  RxBool payBtnClicked = false.obs;
  RxString operatorImage = ''.obs;
  RxString operator = ''.obs;
  RxString amount = ''.obs;
  RxString billerName = ''.obs;
  RxString billerId = ''.obs;
  RxString senderName = ''.obs;
  RxString senderMobile = ''.obs;
  RxString latLng = ''.obs;
  RxString status = ''.obs;
  RxString postalCode = ''.obs;
  RxString macAddress = ''.obs;
  RxString ipAddress = ''.obs;
  RxString category = ''.obs;
  RxString partialPay = ''.obs;
  RxString fetchBill = ''.obs;
  RxString onlineVal = ''.obs;
  String currentDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  RxList<TextEditingController> requiredFieldList = RxList();
  RxList<Authenticator> parametersList = <Authenticator>[].obs;
  RxList<String> paramsNameList = RxList();
  RxList<String> paramsValueList = RxList();
  RxInt authCount = 0.obs;
  TextEditingController amountController = TextEditingController();
  RxBool btnClicked = false.obs;

  @override
  void onInit() {
    super.onInit();
    paramsNameList.value = arguments[AppStrings.txtParameterName];
    paramsValueList.value = arguments[AppStrings.txtParameterValue];
    authCount.value = arguments[AppStrings.txtAuthCount];
    operatorImage.value = arguments[AppStrings.txtOperatorImage];
    billerName.value = arguments[AppStrings.txtBillerName];
    billerId.value = arguments[AppStrings.txtBillerId];
    senderName.value = arguments[AppStrings.txtSenderName];
    senderMobile.value = arguments[AppStrings.txtSenderMobile];
    latLng.value = arguments[AppStrings.txtLatLng];
    postalCode.value = arguments[AppStrings.txtPostalCode];
    macAddress.value = arguments[AppStrings.txtMacAddress];
    ipAddress.value = arguments[AppStrings.txtIpAddress];
    category.value = arguments[AppStrings.txtCategory];
    partialPay.value = arguments[AppStrings.txtPartialPay];
    fetchBill.value = arguments[AppStrings.txtFetchBill];
    onlineVal.value = arguments[AppStrings.txtOnlineValidation];
  }

  ///checking payment validation whether online Validation, fetch bill and partial pay available or not
  void checkValidation(
      String fetchBill, String onlineValidation, String partialPay) async {
    if (onlineValidation == 'Y') {
      if (fetchBill == 'Y') {
        bool validated = false;
        dynamic result = await validateBiller();
        validated = result!.status!;
        if (validated) {
          makePayment();
        } else {
          btnClicked.value = false;
          commonSnackBar('error_network_timeout'.tr);
        }
      } else {
        billerRecharge();
      }
    } else {
      makePayment();
    }
  }

  // ///setting parameter value list
  // List<String> paramsValueList() {
  //   List<String> parameterValueList = [];
  //   for (int i = 0; i < requiredFieldList.length; i++) {
  //     parameterValueList.add(requiredFieldList[i].text);
  //   }
  //   return parameterValueList;
  // }
  //
  // ///setting parameter name list
  // List<String> paramsNameList() {
  //   List<String> parameterNameList = [];
  //   for (int i = 0; i < parametersList.length; i++) {
  //     parameterNameList.add(parametersList[i].parameterName.toString());
  //   }
  //   return parameterNameList;
  // }

  /// setting parameter name and parameter value list
  Future<List<String>> getAuth() async {
    List<String> authList = [];
    for (int i = 0; i < authCount.value; i++) {
      dynamic params = {
        'parameter_name': paramsNameList[i].toString(),
        'value': paramsValueList[i].toString()
      };
      final jsonAuth = json.encode(params);
      authList.add(jsonAuth);
    }
    return authList;
  }

  ///payment without validation
  void makePayment() async {
    dynamic authenticators = await getAuth();
    dynamic header = await bbpsCommonHeader();
    dynamic body = await bbpsValidatePay(
        billerId: billerId.value,
        senderName: senderName.value,
        authenticators: authenticators,
        paymentAmount: amountController.text,
        mobileNo: senderMobile.value,
        geocode: latLng.value,
        postalCode: postalCode.value,
        mac: macAddress.value,
        ip: ipAddress.value,
        isBBPS: 'Y',
        billerCategory: category.value);
    String endCusMobile = await AesEncryption()
        .encrypt(senderMobile.value, PrefManager().getCustomerCode.toString());
    String traceId = Utils().getSaltString();
    String mobile = await AesEncryption().encrypt(paramsValueList[0].toString(),
        PrefManager().getCustomerCode.toString());
    final bbpsReport = BBPSReport(
        transactionId: null,
        transactionDate: currentDate,
        commissionAmount: '',
        status: 'PENDING',
        type: '',
        cess: '',
        sgst: '',
        cgst: '',
        fromName: '',
        transferMode: 'CASH',
        amount: amountController.text,
        endCstmrName: senderName.value,
        endCstmrMob: endCusMobile,
        benefAccNo: '',
        benfIfsc: '',
        billerLogo: '',
        statusDescription: '',
        tranType: 'bbps',
        parameterName: paramsNameList[0].toString(),
        parameterValue: mobile,
        bbpsRefNo: '',
        billerName: billerName.value,
        billerId: billerId.value,
        convFee: '0.00',
        isBillerBbps: AppStrings.txtYes,
        paymentChannel: AppStrings.txtAgent,
        referenceNo: '',
        billerCategory: category.value,
        authCount: authCount.value.toString(),
        paymentId: '',
        traceId: traceId);
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
    await saveToDB(bbpsReport, traceId);
    final jsonBody = json.encode(body);
    String jsonBodyEncode = jsonBody.replaceAll(r'\', '');
    String requestBody = jsonBodyEncode.replaceAll('["', '[');
    String bodyReq = requestBody.replaceAll('"]', ']');
    String encryptedBody = await AesEncryption().encrypt(
        bodyReq,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        header,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.VALIDATE_PAY);
    if (result != null) {
      if (result.status!) {
        final jsonEncode = json.encode(result.data);
        final jsonDecode = json.decode(jsonEncode);
        final bbpsReport = BBPSReport.fromJson(jsonDecode);
        await saveToDB(bbpsReport, traceId);
        btnClicked.value = false;
        goToSummaryPage(bbpsReport);
      } else {
        btnClicked.value = false;
        goToSummaryPage(bbpsReport);
        commonSnackBar(result.message!);
      }
    } else {
      btnClicked.value = false;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///payment after verified by the biller
  void billerRecharge() async {
    dynamic authenticators = await getAuth();
    dynamic header = await bbpsCommonHeader();
    dynamic body = await bbpsValidatePay(
        billerId: billerId.value,
        senderName: senderName.value,
        authenticators: authenticators,
        paymentAmount: amountController.text,
        mobileNo: senderMobile.value,
        geocode: latLng.value,
        postalCode: postalCode.value,
        mac: macAddress.value,
        ip: ipAddress.value,
        isBBPS: AppStrings.txtYes,
        billerCategory: category.value);
    String endCusMobile = await AesEncryption()
        .encrypt(senderMobile.value, PrefManager().getCustomerCode.toString());
    String traceId = Utils().getSaltString();
    String mobile = await AesEncryption().encrypt(paramsValueList[0].toString(),
        PrefManager().getCustomerCode.toString());
    final bbpsReport = BBPSReport(
        transactionId: null,
        transactionDate: currentDate,
        commissionAmount: '',
        status: 'PENDING',
        type: '',
        cess: '',
        sgst: '',
        cgst: '',
        fromName: '',
        transferMode: 'CASH',
        amount: amountController.text,
        endCstmrName: senderName.value,
        endCstmrMob: endCusMobile,
        benefAccNo: '',
        benfIfsc: '',
        billerLogo: '',
        statusDescription: '',
        tranType: 'bbps',
        parameterName: paramsNameList.toString(),
        parameterValue: mobile,
        bbpsRefNo: '',
        billerName: billerName.value,
        billerId: billerId.value,
        convFee: '0.00',
        isBillerBbps: 'Y',
        paymentChannel: AppStrings.txtAgent,
        referenceNo: '',
        billerCategory: category.value,
        authCount: authCount.value.toString(),
        paymentId: '',
        traceId: traceId);
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
    await saveToDB(bbpsReport, traceId);
    final jsonBody = json.encode(body);
    String jsonBodyEncode = jsonBody.replaceAll(r'\', '');
    String requestBody = jsonBodyEncode.replaceAll('["', '[');
    String bodyReq = requestBody.replaceAll('"]', ']');
    String encryptedBody = await AesEncryption().encrypt(
        bodyReq,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        header,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.VALIDATE_PAY);
    if (result != null) {
      if (result.status!) {
        final jsonEncode = json.encode(result.data);
        final jsonDecode = json.decode(jsonEncode);
        final bbpsReport = BBPSReport.fromJson(jsonDecode);
        await saveToDB(bbpsReport, traceId);
        goToSummaryPage(bbpsReport);
      } else {
        goToSummaryPage(bbpsReport);
        commonSnackBar(result.message!);
      }
    } else {
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///validate the details by the biller
  Future<dynamic> validateBiller() async {
    List<String> authenticators = await getAuth();
    dynamic body = await bbpsValidateBillerBody(
        billerId: billerId.value,
        authenticators: authenticators,
        latLng: latLng.value,
        postalCode: postalCode.value,
        macAddress: macAddress.value,
        ipAddress: ipAddress.value,
        mobileNo: senderMobile.value,
        isBBPS: 'Y',
        billerCategory: category.value.toString());

    dynamic header = await bbpsCommonHeader();
    final jsonBody = json.encode(body);
    String jsonBodyEncode = jsonBody.replaceAll(r'\', '');
    String requestBody = jsonBodyEncode.replaceAll('["', '[');
    String bodyReq = requestBody.replaceAll('"]', ']');
    String encryptedBody = await AesEncryption().encrypt(
        bodyReq,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final result = await ApiService().postMethod(
        reqBody,
        header,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.VALIDATE_BILLER);
    return result;
  }

  ///saving datas to the db
  Future<void> saveToDB(BBPSReport bbpsReport, String traceId) async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool isTableEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbBBPSReports);
    List<BBPSReport> reportList = [];
    if (isTableEmpty) {
      reportList =
          box.get(DatabaseConstants.dbBBPSReports).toList().cast<BBPSReport>();
      Log().logs('length--', reportList.length.toString());
      int index = reportList
          .indexWhere((element) => element.traceId.toString() == traceId);
      if (index == -1) {
        reportList.add(bbpsReport);
        box.put(DatabaseConstants.dbBBPSReports, reportList);
      } else {
        reportList.removeAt(index);
        reportList.add(bbpsReport);
        box.put(DatabaseConstants.dbBBPSReports, reportList);
      }
    } else {
      reportList.add(bbpsReport);
      box.put(DatabaseConstants.dbBBPSReports, reportList);
    }
  }

  ///pay button click function
  void onPayTap() {
    btnClicked.value = true;
    checkValidation(fetchBill.value, onlineVal.value, partialPay.value);
  }

  ///delete text function
  void onTextDelete() {
    List<String> amountList = amountController.text.split('');
    amountList.removeLast();
    amountController.value = TextEditingValue(text: amountList.join(''));
  }

  ///go to detail page after the payment
  void goToSummaryPage(BBPSReport bbpsReport) {
    String paramsValue = bbpsReport.parameterValue!.replaceAll('[', '');
    String value = paramsValue.replaceAll(']', '');
    String paramsName = bbpsReport.parameterName!.replaceAll('[', '');
    String name = paramsName.replaceAll(']', '');
    Get.to(() => const BBPSPaymentDetailsPage(),
        binding: BBPSPaymentDetailsBinding(),
        arguments: {
          AppStrings.txtParameterName: name,
          AppStrings.txtParameterValue: value,
          AppStrings.txtBillAmount: bbpsReport.amount,
          AppStrings.txtSenderName: bbpsReport.endCstmrName,
          AppStrings.txtStatus: bbpsReport.status,
          AppStrings.txtSenderMobile: bbpsReport.endCstmrMob,
          AppStrings.txtBillerName: bbpsReport.billerName,
          AppStrings.txtBillerId: bbpsReport.billerId,
          AppStrings.txtBBPSRefNo: bbpsReport.bbpsRefNo,
          AppStrings.txtBillDate: bbpsReport.transactionDate,
          AppStrings.txtPaymentId: bbpsReport.paymentId,
          AppStrings.txtCategory: bbpsReport.billerCategory,
          AppStrings.txtPaymentChannel: bbpsReport.paymentChannel,
          AppStrings.txtPaymentMode: bbpsReport.transferMode,
          AppStrings.txtTraceId: bbpsReport.traceId,
          'home': true,
        });
    amountController.clear();
  }
}
