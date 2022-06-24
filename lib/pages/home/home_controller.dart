import 'dart:convert';

import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_sub_category/bbps_sub_category_binding.dart';
import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_sub_category/bbps_sub_category_page.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_number/mobile_number_binding.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_number/mobile_number_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/report/money_transfer_report_binding.dart';
import 'package:atm_flutter_app/pages/money_transfer/report/money_transfer_report_page.dart';
import 'package:atm_flutter_app/pages/qr_code/report/qr_code_report_binding.dart';
import 'package:atm_flutter_app/pages/qr_code/report/qr_code_report_page.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:atm_flutter_app/retrofit/apis.dart';
import 'package:atm_flutter_app/retrofit/headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../utils/aes_encryption.dart';
import '../../utils/api_req_res_format.dart';
import '../bbps/payment_history/report/bbps_report_binding.dart';
import '../bbps/payment_history/report/bbps_report_page.dart';

class HomeController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  RxBool toggleValue = true.obs;
  RxString agentStatus = ''.obs;
  RxBool isLoading = false.obs;
  RxString password = ''.obs;
  List<Category> rechargeList = [],
      billList = [],
      financialList = [],
      otherList = [],
      paymentList = [],
      reportList = [],
      categoryList = [];
  late Position currentPosition;

  ///creating payment service list
  void createCategoryList() {
    categoryList.add(Category('send_money'.tr, AppDrawable.moneyTransfer));
    categoryList.add(Category('QR', AppDrawable.qrCode));
  }

  ///creating recharge category list
  void createRechargeList() {
    rechargeList.add(Category('Mobile Recharge', AppDrawable.mobileRecharge));
    rechargeList.add(Category('DTH', AppDrawable.dth));
    rechargeList.add(Category('FASTag', AppDrawable.fastag));
  }

  ///creating bill category list
  void createBillList() {
    billList.add(Category('Electricity', AppDrawable.electricity));
    billList.add(Category('Piped Gas', AppDrawable.pipelineGas));
    billList.add(Category('LPG Cylinder', AppDrawable.cylinder));
    billList.add(Category('Water', AppDrawable.pipelineWater));
    billList.add(Category('Broadband', AppDrawable.broadband));
    billList.add(Category('Landline', AppDrawable.landlinePostpaid));
    billList.add(Category('Cable TV', AppDrawable.cableTv));
    billList.add(Category('Postpaid', AppDrawable.mobilePostpaid));
  }

  ///creating finance category list
  void createFinancialList() {
    financialList.add(Category('Insurance', AppDrawable.insurance));
    financialList.add(Category('Loan', AppDrawable.loan));
    financialList.add(Category('Credit Card', AppDrawable.creditCard));
    financialList.add(Category('Tax', AppDrawable.municipalTax));
    financialList
        .add(Category('Municipal Services', AppDrawable.municipalService));
  }

  ///creating other category list
  void createOtherList() {
    otherList.add(Category('Hospital', AppDrawable.hospital));
    otherList.add(Category('Housing Society', AppDrawable.housingSociety));
    otherList.add(Category('Subscription', AppDrawable.subscriptionFee));
    otherList.add(Category('Donation', AppDrawable.donation));
    otherList.add(
        Category('Clubs And Associations', AppDrawable.clubsAndAssociations));
  }

  void onItemTap(bool value) {
    toggleValue.value = value;
    if (toggleValue.value) {
      agentStatus.value = 'Y';
    } else {
      agentStatus.value = 'N';
    }
    changeAgentDutyStatus();
  }

  void changeAgentDutyStatus() async {
    isLoading.value = true;
    dynamic bodyData = {'onduty': agentStatus.value};
    final jsonBody = json.encode(bodyData);
    String reqBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getDriverCode.toString());
    String body = await ApiReqResFormat().reqFormatter(reqBody);

    dynamic response = await ApiService().postMethod(
        body,
        agentDutyStatusHeader,
        PrefManager().getDeviceId.toString() +
            PrefManager().getDriverCode.toString(),
        Apis.AGENT_DUTY);
    if (response.data != null) {
      String dutyStatus = response.data.toString();
      PrefManager().setDriverDutyStatus(dutyStatus);
      isLoading.value = false;
    }
  }

  ///service password
  void onButtonTap(String value) {
    password.value = password.value + value;
  }

  ///delete text
  void onTextDelete() {
    List<String> passwordList = password.value.split('');
    passwordList.removeLast();
    password.value = passwordList.join('');
  }

  ///go to next page
  void gotoNextPage(String catName, String catImage) {
    if (catName == 'mobile_recharge'.tr) {
      Get.to(() => const MobileNumberPage(),
          binding: MobileNumberBinding(),
          arguments: {AppStrings.txtCategoryImage: catImage});
    } else {
      Get.to(() => const BBPSSubCategoryPage(),
          binding: BBPSSubCategoryBinding(),
          arguments: {
            AppStrings.txtCategory: catName,
            AppStrings.txtCategoryImage: catImage,
          });
    }
  }

  /// go to report page
  void goToReportPage(String catName, String catImage) {
    if (catName == "money_transfer_report".tr) {
      Get.to(() => const MoneyTransferReportPage(),
          binding: MoneyTransferReportBinding());
    } else if (catName == "qr_report".tr) {
      Get.to(() => QRCodeReportPage(), binding: QRCodeReportBinding());
    } else if (catName == "bbps_report".tr) {
      Get.to(() => BBPSReportPage(), binding: BBPSReportBinding());
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
    setIcons();
    createBillList();
    createFinancialList();
    createRechargeList();
    createOtherList();
    createCategoryList();
  }

  ///set icons for category
  void setIcons() {
    if (PrefManager().getMoneyTransfer!) {
      Category category =
          Category("money_transfer_report".tr, AppDrawable.moneyTransferReport);
      reportList.add(category);
    }
    if (PrefManager().getQR!) {
      Category category2 = Category("qr_report".tr, AppDrawable.qrReport);
      reportList.add(category2);
    }
    if (PrefManager().getBBPS!) {
      Category category3 = Category("bbps_report".tr, AppDrawable.bbpsReport);
      reportList.add(category3);
    }
    Category category4 =
        Category("money_transfer".tr, AppDrawable.moneyTransfer);
    Category category5 = Category('QR', AppDrawable.qrCode);
    paymentList.add(category4);
    paymentList.add(category5);
  }

  ///getting current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      currentPosition = position;
    }).catchError((e) {
      print(e);
    });
  }
}

class Category {
  String catName;
  String catImage;

  Category(this.catName, this.catImage);
}
