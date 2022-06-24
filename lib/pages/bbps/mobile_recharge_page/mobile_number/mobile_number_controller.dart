import 'dart:convert';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_operator/mobile_operator_binding.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_operator/mobile_operator_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';

import '../../../../helper/prefManager.dart';
import '../../../../model/bbps/mobile_operator.dart';
import '../../../../resources/app_strings.dart';
import '../../../../retrofit/api_service.dart';
import '../../../../retrofit/apis.dart';
import '../../../../retrofit/headers.dart';
import '../../../../utils/aes_encryption.dart';
import '../../../../utils/api_req_res_format.dart';
import '../../../../widgets/dialog_box_widget/snack_bar.dart';

class MobileNumberController extends GetxController {
  dynamic arguments = Get.arguments;
  TextEditingController numberController = TextEditingController();
  TextEditingController senderNameController = TextEditingController();
  TextEditingController senderNumberController = TextEditingController();
  PhoneContact? _phoneContact;
  String mobileNo = '';
  RxString operator = ''.obs;
  RxString catImage = ''.obs;
  RxString circle = ''.obs;
  RxString operatorId = ''.obs;
  RxBool senderNameValidate = true.obs;
  RxBool senderNumberValidate = true.obs;
  RxBool isLoading = false.obs;
  RxBool btnClicked = false.obs;
  RxBool numberValidate = true.obs;
  RxBool checkValue = false.obs;
  String senderName = '';
  String senderMobile = '';
  String mobile = '';

  @override
  void onInit() {
    super.onInit();
    catImage.value = arguments[AppStrings.txtCategoryImage];
    senderName = arguments[AppStrings.txtSenderName] ?? '';
    senderMobile = arguments[AppStrings.txtSenderMobile] ?? '';
    mobile = arguments[AppStrings.txtParameterValue] ?? '';
    if (senderName != '') {
      setFields();
    }
    numberController.addListener(() {
      if (numberController.text.length == 10) {
        mobileNo = numberController.text.substring(0, 5);
        verifyField();
      }
    });
  }

  ///setting text fields value
  void setFields() {
    senderNameController.value = TextEditingValue(text: senderName);
    senderNumberController.value = TextEditingValue(text: senderMobile);
    numberController.value = TextEditingValue(text: mobile);
  }

  ///check button tap function
  void onCheckTap(bool value) {
    checkValue.value = value;
    if (value) {
      if (senderNumberController.text.isNotEmpty) {
        numberController.value =
            TextEditingValue(text: senderNumberController.text);
      } else {
        commonSnackBar('mobile_no_required'.tr);
      }
    }
  }

  ///getting phone contacts
  void getContacts() async {
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
    _phoneContact = contact;
    numberController.value = TextEditingValue(text: _phoneContact.toString());
  }

  ///getting mobile operators and circle
  void getOperatorsAndCirclesFromApi() async {
    dynamic body = {'mobile': mobileNo};
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    Map<String, String> header = await bbpsCommonHeader();
    final result = await ApiService().postMethod(
        reqBody,
        header,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.OPERATOR_SERIES);
    if (result != null) {
      if (result.status!) {
        dynamic dataResult = result.data;
        final jsonEncode = json.encode(dataResult);
        final jsonDecode = json.decode(jsonEncode);
        final operators = MobileOperators.fromJson(jsonDecode);
        operator.value = '${operators.billerName},${operators.circleName}';
        operator.value = operators.billerName.toString();
        circle.value = operators.circleName.toString();
        operatorId.value = operators.billerid.toString();
        gotoNextPage();
      } else {
        btnClicked.value = false;
        commonSnackBar(result.message!);
      }
    } else {
      btnClicked.value = false;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///go to next page
  void gotoNextPage() {
    isLoading.value = false;
    btnClicked.value = false;
    Get.to(() => const MobileOperatorPage(),
        binding: MobileOperatorBinding(),
        arguments: {
          AppStrings.txtOperator: operator.value,
          AppStrings.txtCircle: circle.value,
          AppStrings.txtOperatorId: operatorId.value,
          AppStrings.txtMobileNo: numberController.text,
          AppStrings.txtSenderName: senderNameController.text,
          AppStrings.txtSenderMobile: senderNumberController.text
        });
    clearTextFields();
  }

  ///verifing text field before go to next page
  void verifyField() {
    if (senderNameController.text.isEmpty ||
        senderNumberController.text.isEmpty ||
        numberController.text.isEmpty) {
      if (senderNameController.text.isEmpty) {
        senderNameValidate.value = false;
      } else {
        senderNameValidate.value = true;
      }
      if (senderNumberController.text.isEmpty) {
        senderNumberValidate.value = false;
      } else {
        senderNumberValidate.value = true;
      }
      if (numberController.text.isEmpty) {
        numberValidate.value = false;
      } else {
        numberValidate.value = true;
      }
      commonSnackBar('Check Fields');
    } else {
      isLoading.value = true;
      btnClicked.value = true;
      getOperatorsAndCirclesFromApi();
    }
  }

  @override
  void onClose() {
    clearTextFields();
    super.onClose();
  }

  void clearTextFields() {
    senderNameController.clear();
    senderNumberController.clear();
    numberController.clear();
    checkValue.value = false;
  }
}
