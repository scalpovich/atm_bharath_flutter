import 'dart:convert';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_payment/bbps_bills_payment_binding.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_payment/bbps_bills_payment_page.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';
import '../../../../helper/prefManager.dart';
import '../../../../model/bbps/bbps_category.dart';
import '../../../../model/bbps/bill.dart';
import '../../../../retrofit/api_service.dart';
import '../../../../retrofit/apis.dart';
import '../../../../retrofit/body/bbps_body.dart';
import '../../../../retrofit/headers.dart';
import '../../../../utils/aes_encryption.dart';
import '../../../../utils/api_req_res_format.dart';
import '../../../../utils/location_service.dart';
import '../../../../widgets/dialog_box_widget/snack_bar.dart';
import '../../show_bill/bbps_show_bill_binding.dart';
import '../../show_bill/bbps_show_bill_page.dart';

class BBPSBillDetailsController extends MainController {
  dynamic arguments = Get.arguments;
  final TextEditingController senderNameController = TextEditingController();
  final TextEditingController senderMobileController = TextEditingController();
  final RxList<TextEditingController> requiredFieldController = RxList();
  RxList<Authenticator> parameterList = <Authenticator>[].obs;
  RxList<bool> requiredList = RxList();
  RxBool senderNameValidate = true.obs;
  RxBool senderMobileValidate = true.obs;
  RxList<bool> authValidateList = RxList();
  RxList<Authenticator> authenticatorList = <Authenticator>[].obs;
  RxInt authCount = 0.obs;
  RxBool isPartialPay = false.obs;
  RxString billerName = ''.obs;
  RxString billFetch = ''.obs;
  RxString onlineValidation = ''.obs;
  RxString partialPay = ''.obs;
  RxBool fetchBillVisible = false.obs;
  RxBool fetchBillClicked = false.obs;
  RxString billerId = ''.obs;
  RxString billerImage = ''.obs;
  RxString category = ''.obs;
  RxString ipAddress = ''.obs;
  RxString macAddress = ''.obs;
  RxString postalCode = ''.obs;
  RxString latLng = ''.obs;
  WifiInfoWrapper? _wifiObject;
  late Position currentPosition;
  RxBool btnClicked = false.obs;
  String senderName = '';
  String senderMobile = '';

  @override
  void onInit() {
    getCurrentLocation();
    initPlatformState();
    super.onInit();
    category.value = arguments[AppStrings.txtCategory];
    senderName = arguments[AppStrings.txtSenderName] ?? '';
    senderMobile = arguments[AppStrings.txtSenderMobile] ?? '';
    if (senderName != '') {
      setFields();
    }
    onBillerDetails(arguments[AppStrings.txtCategoryList]);
  }

  void setFields() {
    senderNameController.value = TextEditingValue(text: senderName);
    senderMobileController.value = TextEditingValue(text: senderMobile);
  }

  ///setting parameter value list
  List<String> paramsValueList() {
    List<String> parameterValueList = [];
    for (int i = 0; i < requiredFieldController.length; i++) {
      parameterValueList.add(requiredFieldController[i].text);
    }
    return parameterValueList;
  }

  ///setting parameter name list
  List<String> paramsNameList() {
    List<String> parameterNameList = [];
    for (int i = 0; i < authenticatorList.length; i++) {
      parameterNameList.add(authenticatorList[i].parameterName.toString());
    }
    return parameterNameList;
  }

  ///setting biller details
  void onBillerDetails(BBPSCategory category) {
    getAuthenticators(category);
    authCount.value = category.authenticators!.length;
    parameterList.value = category.authenticators!;
    billerId.value = category.billerId.toString();
    billerName.value = category.billerName.toString();
    billFetch.value = category.fetchBill.toString();
    billFetch.value = category.fetchBill.toString();
    onlineValidation.value = category.onlineValidation.toString();
    partialPay.value = category.partialPay.toString();
    billerImage.value = category.billerLogo.toString();
    if (billFetch.value == 'Y') {
      fetchBillVisible.value = true;
    } else {
      fetchBillVisible.value = false;
    }
  }

  ///getting parameter fields
  void getAuthenticators(BBPSCategory category) {
    if (category.authenticators != null) {
      dynamic authList = category.authenticators;
      for (int i = 0; i < authList.length; i++) {
        final jsonEncode = json.encode(authList[i]);
        final jsonDecode = json.decode(jsonEncode);
        final auth = Authenticator.fromJson(jsonDecode);
        authenticatorList.add(auth);
        authValidateList.add(true);
      }
    }
  }

  ///checking required field is empty or not
  bool validateRequiredFields() {
    for (int i = 0; i < requiredFieldController.length; i++) {
      if (requiredFieldController[i].text.isNotEmpty) {
        requiredList.add(true);
      } else {
        requiredList.add(false);
      }
    }
    bool validation = requiredList.contains(false);
    return validation;
  }

  ///pay button click function
  void onPayTap() {
    bool required = validateRequiredFields();
    if (senderMobileController.text.isNotEmpty &&
        senderNameController.text.isNotEmpty &&
        !required) {
      List<String> paramsName = paramsNameList();
      List<String> paramsValue = paramsValueList();
      Get.to(() => const BBPSBillsPaymentPage(),
          binding: BBPSBillsPaymentBinding(),
          arguments: {
            AppStrings.txtParameterName: paramsName,
            AppStrings.txtParameterValue: paramsValue,
            AppStrings.txtAuthCount: authCount.value,
            AppStrings.txtCategory: category.value,
            AppStrings.txtIpAddress: ipAddress.value,
            AppStrings.txtMacAddress: macAddress.value,
            AppStrings.txtPostalCode: postalCode.value,
            AppStrings.txtLatLng: latLng.value,
            AppStrings.txtSenderMobile: senderMobileController.text,
            AppStrings.txtSenderName: senderNameController.text,
            AppStrings.txtBillerName: billerName.value,
            AppStrings.txtBillerId: billerId.value,
            AppStrings.txtOperatorImage: billerImage.value,
            AppStrings.txtPartialPay: partialPay.value,
            AppStrings.txtFetchBill: billFetch.value,
            AppStrings.txtOnlineValidation: onlineValidation.value,
          });
      clearTextFields();
    } else {
      if (senderNameController.text.isEmpty) {
        senderNameValidate.value = false;
      } else {
        senderNameValidate.value = true;
      }
      if (senderMobileController.text.isEmpty) {
        senderMobileValidate.value = false;
      } else {
        senderMobileValidate.value = true;
      }
    }
  }

  ///getting ip and mac address
  Future<void> initPlatformState() async {
    WifiInfoWrapper? wifiObject;
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}

    _wifiObject = wifiObject;
    ipAddress.value =
        _wifiObject != null ? _wifiObject!.ipAddress.toString() : "...";

    macAddress.value =
        _wifiObject != null ? _wifiObject!.macAddress.toString() : '...';
  }

  ///getting current latitude and longitude
  Future<void> getCurrentLocation() async {
    currentPosition = await LocationService().getUserCurrentLocation();
    latLng.value = currentPosition.latitude.toString() +
        ',' +
        currentPosition.longitude.toString();
    await getPostalCodeFromLocation();
  }

  ///getting current postal code
  Future<void> getPostalCodeFromLocation() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      postalCode.value = place.postalCode.toString();
    } catch (e) {
      print(e);
    }
  }

  void onFetchBillTap() async {
    btnClicked.value = true;
    dynamic result = await validateBiller();
    showBill(result);
  }

  showBill(dynamic result) async {
    if (result != null) {
      if (result.status!) {
        final jsonEncode = json.encode(result.data);
        final jsonDecode = json.decode(jsonEncode);
        final bill = Bill.fromJson(jsonDecode);
        dynamic listBill = bill.billlist;
        if (listBill != null) {
          for (int i = 0; i < listBill.length; i++) {
            final jsonBillEncode = json.encode(listBill[i]);
            final jsonBillDecode = json.decode(jsonBillEncode);
            final billList = Billlist.fromJson(jsonBillDecode);
            sendDataToShowBill(billList, bill.sourceRefNo.toString());
          }
        }
      } else {
        commonSnackBar(result.message!);
      }
    } else {
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  void sendDataToShowBill(Billlist bill, String sourceRefNo) async {
    fetchBillClicked.value = false;
    btnClicked.value = false;
    Get.to(
      () => const BBPSShowBillPage(),
      binding: BBPSShowBillBinding(),
      arguments: {
        AppStrings.txtCategoryImage: billerImage.value,
        AppStrings.txtBillerName: billerName.value,
        AppStrings.txtCategory: category.value,
        AppStrings.txtBillId: bill.billid.toString(),
        AppStrings.txtBillStatus: bill.billstatus.toString(),
        AppStrings.txtBillAmount: bill.billamount.toString(),
        AppStrings.txtCustomerName: bill.customerName.toString(),
        AppStrings.txtBillPeriod: bill.billPeriod.toString(),
        AppStrings.txtBillDate: bill.billdate.toString(),
        AppStrings.txtBillDueDate: bill.billduedate.toString(),
        AppStrings.txtSourceRefNo: sourceRefNo,
        AppStrings.txtParameterValue: parameterList,
        AppStrings.txtRequiredField: requiredFieldController.value,
        AppStrings.txtAuthCount: authCount.value,
        AppStrings.txtIpAddress: ipAddress.value,
        AppStrings.txtPostalCode: postalCode.value,
        AppStrings.txtLatLng: latLng.value,
        AppStrings.txtSenderName: senderNameController.text,
        AppStrings.txtSenderMobile: senderMobileController.text,
        AppStrings.txtBillerId: billerId.value,
        AppStrings.txtPartialPay: partialPay.value,
      },
    );
  }

  Future<List<String>> getAuth() async {
    List<String> authList = [];
    for (int i = 0; i < authCount.value; i++) {
      dynamic params = {
        'parameter_name': parameterList[i].parameterName.toString(),
        'value': requiredFieldController[i].text
      };
      final jsonAuth = json.encode(params);
      authList.add(jsonAuth);
    }
    return authList;
  }

  Future<dynamic> validateBiller() async {
    List<String> authenticators = await getAuth();
    dynamic body = await bbpsValidateBillerBody(
        billerId: billerId.value,
        authenticators: authenticators,
        latLng: latLng.value,
        postalCode: postalCode.value,
        macAddress: macAddress.value,
        ipAddress: ipAddress.value,
        mobileNo: senderMobileController.text,
        isBBPS: AppStrings.txtYes,
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

  void onPartialPayTap() {}

  @override
  void onClose() {
    clearTextFields();
    super.onClose();
  }

  void clearTextFields() {
    senderMobileController.clear();
    senderNameController.clear();
    requiredFieldController.clear();
  }
}
