import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:atm_flutter_app/model/money_transfer/bank_name.dart';
import 'package:atm_flutter_app/model/money_transfer/purpose.dart';
import 'package:atm_flutter_app/pages/money_transfer/account_search/money_transfer_account_search_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/account_search/money_transfer_account_search_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/ifsc_details_page/ifsc_details_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/ifsc_details_page/ifsc_details_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/ifsc_search/ifsc_search_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/ifsc_search/ifsc_search_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/mobile_search/mobile_search_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/mobile_search/mobile_search_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/name_search/money_transfer_name_search_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/name_search/money_transfer_name_search_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/payment/payment_page.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:atm_flutter_app/widgets/dialog_box_widget/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../payment/payment_binding.dart';

class MoneyTransferController extends MainController {
  dynamic arguments = Get.arguments;
  RxBool isIMPS = true.obs;
  RxBool isNEFT = false.obs;
  RxBool isRTGS = false.obs;
  RxString toggleValue = 'IMPS'.obs;
  RxString toggleText = 'two_lacks_per_trans'.tr.obs;
  RxList<String> listPurpose = <String>[].obs;
  RxList<Purpose> purposelist = <Purpose>[].obs;
  RxBool verifyBtnClicked = false.obs;

  RxBool isDuty = false.obs;
  RxBool isOpen = false.obs;

  RxString genKey = ''.obs;

  final TextEditingController cusNameController = TextEditingController();
  final TextEditingController cusMobileController = TextEditingController();
  final TextEditingController benefNameController = TextEditingController();
  final TextEditingController benefAccountNoController =
      TextEditingController();
  final TextEditingController benefConfirmAccountNoController =
      TextEditingController();
  final TextEditingController ifscController = TextEditingController();

  RxBool cusNameValidate = true.obs;
  RxBool cusMobileValidate = true.obs;
  RxBool benefNameValidate = true.obs;
  RxBool benefAccountNoValidate = true.obs;
  RxBool benefConfirmValidate = true.obs;
  RxBool ifscValidate = true.obs;
  RxBool amountValidate = true.obs;
  RxBool bankValidate = true.obs;
  RxBool branchValidate = true.obs;
  RxBool stateValidate = true.obs;
  RxBool districtValidate = true.obs;
  RxString confirmBenefAccNoErrorText = ''.obs;
  RxString ifscErrorText = ''.obs;
  RxString mobileErrorText = ''.obs;
  RxString benefAccNoErrorText = ''.obs;

  RxString selectedPayment = AppStrings.txtDepositOrInvest.obs;
  RxString selectedPaymentMode = '1'.obs;

  var pickedImage = ''.obs;
  final picker = ImagePicker();

  checkTransactionMethod(String type, value) {
    if (type == AppStrings.txtIMPS) {
      isIMPS.value = value;
      isNEFT.value = false;
      isRTGS.value = false;
      toggleValue.value = AppStrings.txtIMPS;
      toggleText.value = 'two_lacks_per_trans'.tr;
    } else if (type == AppStrings.txtNEFT) {
      isNEFT.value = value;
      isIMPS.value = false;
      isRTGS.value = false;
      toggleValue.value = AppStrings.txtNEFT;
      toggleText.value = 'twenty_lack_receiver_money'.tr;
    } else if (type == AppStrings.txtRTGS) {
      isRTGS.value = value;
      isIMPS.value = false;
      isNEFT.value = false;
      toggleValue.value = AppStrings.txtRTGS;
      toggleText.value = 'two_lacks_max'.tr;
    }
  }

  imgFromGallery(String type) async {
    final XFile? pickedFile;
    if (type == AppStrings.txtGallery.toLowerCase()) {
      pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    } else {
      pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    }
    if (pickedFile != null) {
      pickedImage.value = pickedFile.path;
      update();
    }
  }

  void changeControllerValue(
      String benefNo, String benefName, String ifscCode, String cusName) {
    benefAccountNoController.value = TextEditingValue(text: benefNo);
    benefNameController.value = TextEditingValue(text: benefName);
    ifscController.value = TextEditingValue(text: ifscCode);
    benefConfirmAccountNoController.value = TextEditingValue(text: benefNo);
    cusNameController.value = TextEditingValue(text: cusName);
  }

  void changeIFSCCodeControllerValue(String ifscCode) {
    ifscController.value = TextEditingValue(text: ifscCode);
  }

  void submitImageId(dynamic body, dynamic header) {
    var result = ApiService().uploadImageIdForTransaction();
  }

  @override
  void onInit() {
    super.onInit();
    getPurposeBox();
  }

  void getPurposeBox() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    bool isTableNotEmpty =
        await dbAccess.isTableEmpty(DatabaseConstants.dbPurpose);
    if (isTableNotEmpty) {
      List<Purpose> purposeList =
          box.get(DatabaseConstants.dbPurpose).toList().cast<Purpose>();
      purposelist.addAll(purposeList);
      for (int i = 0; i < purposeList.length; i++) {
        listPurpose.add(purposeList[i].mtpsPurposename);
      }
    } else {
      listPurpose.value = [
        AppStrings.txtDepositOrInvest,
        AppStrings.txtGift,
        AppStrings.txtDonation,
        AppStrings.txtFees,
        AppStrings.txtRent,
        AppStrings.txtFamilyMaintenance
      ];
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (arguments != null) {
      setControllerValues();
    }
  }

  void setControllerValues() {
    cusNameController.value =
        TextEditingValue(text: arguments[AppStrings.txtSenderName].toString());
    benefNameController.value = TextEditingValue(
        text: arguments[AppStrings.txtBeneficiaryName].toString());
    benefAccountNoController.value =
        TextEditingValue(text: arguments[AppStrings.txtBenefAccNo].toString());
    benefConfirmAccountNoController.value =
        TextEditingValue(text: arguments[AppStrings.txtBenefAccNo].toString());
    ifscController.value =
        TextEditingValue(text: arguments[AppStrings.txtIFSCCode].toString());
  }

  void mobileSearch(String mobileNo) async {
    if (mobileNo.length == 10) {
      dynamic data = await Get.to(() => const MobileSearchPage(),
          arguments: {AppStrings.txtMobileNo: cusMobileController.text},
          binding: MobileSearchBinding());
      changeControllerValue(
        data[AppStrings.txtBenefAccNo] ?? '',
        data[AppStrings.txtBeneficiaryName] ?? '',
        data[AppStrings.txtIFSCCode] ?? '',
        data[AppStrings.txtCustomerName] ?? '',
      );
    } else {
      commonSnackBar('Check the mobile no.');
    }
  }

  void nameSearch(String name) async {
    dynamic data = await Get.to(() => const MoneyTransferNameSearchPage(),
        arguments: {AppStrings.txtBeneficiaryName: benefNameController.text},
        binding: MoneyTransferNameSearchBinding());
    if (data != null) {
      benefAccountNoController.value =
          TextEditingValue(text: data[AppStrings.txtBenefAccNo] ?? '');
      cusMobileController.value =
          TextEditingValue(text: data[AppStrings.txtCustomerMobile] ?? '');
      ifscController.value =
          TextEditingValue(text: data[AppStrings.txtIFSCCode] ?? '');
      benefConfirmAccountNoController.value =
          TextEditingValue(text: data[AppStrings.txtBenefAccNo] ?? '');
      cusNameController.value =
          TextEditingValue(text: data[AppStrings.txtCustomerName] ?? '');
    }
  }

  void accountSearch(String account) async {
    dynamic data = await Get.to(() => const MoneyTransferAccountSearchPage(),
        arguments: {AppStrings.txtBenefAccNo: benefAccountNoController.text},
        binding: MoneyTransferAccountSearchBinding());
    if (data != null) {
      benefAccountNoController.value =
          TextEditingValue(text: data[AppStrings.txtBenefAccNo] ?? '');
      cusMobileController.value =
          TextEditingValue(text: data[AppStrings.txtCustomerMobile] ?? '');
      ifscController.value =
          TextEditingValue(text: data[AppStrings.txtIFSCCode] ?? '');
      benefConfirmAccountNoController.value =
          TextEditingValue(text: benefAccountNoController.text);
      cusNameController.value =
          TextEditingValue(text: data[AppStrings.txtCustomerName] ?? '');
    }
  }

  void textValidation() {
    if (cusNameController.text.isNotEmpty &&
        cusMobileController.text.isNotEmpty &&
        benefAccountNoController.text.isNotEmpty &&
        benefNameController.text.isNotEmpty &&
        ifscController.text.isNotEmpty &&
        benefConfirmAccountNoController.text.isNotEmpty &&
        benefConfirmAccountNoController.text == benefAccountNoController.text &&
        cusMobileController.text.length == 10 &&
        ifscController.text.length == 11 &&
        benefAccountNoController.text.length > 8) {
      Get.to(() => const PaymentPage(), binding: PaymentBinding(), arguments: {
        AppStrings.txtCustomerName: cusNameController.text,
        AppStrings.txtCustomerMobile: cusMobileController.text,
        AppStrings.txtBeneficiaryName: benefNameController.text,
        AppStrings.txtBenefAccNo: benefAccountNoController.text,
        AppStrings.txtIFSCCode: ifscController.text,
        AppStrings.txtPurpose: selectedPayment.value,
        AppStrings.txtPurposeId: selectedPaymentMode.value,
        AppStrings.txtPaymentMode: toggleValue.value,
      });
      clearTextFields();
    } else {
      if (!cusNameController.text.isNotEmpty) {
        cusNameValidate.value = false;
      } else {
        cusNameValidate.value = true;
      }
      if (cusMobileController.text.isNotEmpty) {
        if (cusMobileController.text.length != 10) {
          cusMobileValidate.value = false;
          mobileErrorText.value = 'invalid_mobile_number'.tr;
        } else {
          cusMobileValidate.value = true;
        }
      } else {
        cusMobileValidate.value = false;
        mobileErrorText.value = 'customer_mobile_required'.tr;
      }
      if (!benefNameController.text.isNotEmpty) {
        benefNameValidate.value = false;
      } else {
        benefNameValidate.value = true;
      }
      if (benefAccountNoController.text.isNotEmpty) {
        if (benefAccountNoController.text.length < 8) {
          benefAccountNoValidate.value = false;
          benefAccNoErrorText.value = 'account_no_min_length'.tr;
        } else {
          benefAccountNoValidate.value = true;
        }
      } else {
        benefAccountNoValidate.value = false;
        benefAccNoErrorText.value = 'benef_acc_no_required'.tr;
      }

      if (benefConfirmAccountNoController.text.isNotEmpty) {
        if (benefAccountNoController.text !=
            benefConfirmAccountNoController.text) {
          benefConfirmValidate.value = false;
          confirmBenefAccNoErrorText.value = 'account_no_mismatch'.tr;
        } else {
          benefConfirmValidate.value = true;
        }
      } else {
        benefConfirmValidate.value = false;
        confirmBenefAccNoErrorText.value = 'benef_acc_no_required'.tr;
      }
      if (ifscController.text.isNotEmpty) {
        if (ifscController.text.length != 11) {
          ifscValidate.value = false;
          ifscErrorText.value = 'invalid_ifsc'.tr;
        } else {
          ifscValidate.value = true;
        }
      } else {
        ifscValidate.value = false;
        ifscErrorText.value = 'ifsc_code_required'.tr;
      }
      commonSnackBar('Enter correct details!');
    }
  }

  @override
  void onClose() {
    clearTextFields();
    super.onClose();
  }

  void clearTextFields() {
    cusNameController.clear();
    cusMobileController.clear();
    benefNameController.clear();
    benefAccountNoController.clear();
    benefConfirmAccountNoController.clear();
    ifscController.clear();
  }

  Future<void> ifscSearch() async {
    final data = await Get.to(() => const IFSCDetailsPage(),
        binding: IFSCDetailsBinding());
    if (data != null) {
      ifscController.value =
          TextEditingValue(text: data[AppStrings.txtIFSCCode] ?? '');
    }
  }
}
