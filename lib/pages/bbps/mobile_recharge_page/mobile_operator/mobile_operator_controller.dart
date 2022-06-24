import 'dart:convert';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../helper/prefManager.dart';
import '../../../../model/bbps/mobile_plans.dart';
import '../../../../retrofit/api_service.dart';
import '../../../../retrofit/apis.dart';
import '../../../../retrofit/headers.dart';
import '../../../../utils/aes_encryption.dart';
import '../../../../utils/api_req_res_format.dart';
import '../../../../widgets/dialog_box_widget/snack_bar.dart';
import '../operator_page/operator_binding.dart';
import '../operator_page/operator_page.dart';
import '../recharge/mobile_recharge_binding.dart';
import '../recharge/mobile_recharge_page.dart';

class MobileOperatorController extends GetxController
    with GetTickerProviderStateMixin {
  dynamic arguments = Get.arguments;
  TextEditingController amountController = TextEditingController();
  final TextEditingController planSearchController = TextEditingController();
  RxString operatorImg = ''.obs;
  RxList<Tab> tabs = <Tab>[].obs;
  late TabController tabController;
  RxList<MobilePlans> plansList = <MobilePlans>[].obs;
  RxString operatorValue = ''.obs;
  RxString circleValue = ''.obs;
  RxString operatorIdValue = ''.obs;
  RxBool progressVisibility = true.obs;
  RxList<MobilePlans> rechargePlansList = <MobilePlans>[].obs;
  String mobileNo = '';
  RxString planName = ''.obs;
  RxString billerName = ''.obs;
  RxString circle = ''.obs;

  @override
  void onInit() {
    super.onInit();
    operatorIdValue.value = arguments[AppStrings.txtOperatorId];
    circleValue.value = arguments[AppStrings.txtCircle];
    billerName.value = arguments[AppStrings.txtOperator];
    circle.value = arguments[AppStrings.txtCircle];
    setOperatorImage();
    fetchPlanTabsFromApi();
  }

  ///getting mobile recharge plans
  void fetchPlanTabsFromApi() async {
    Map<String, String> header = await bbpsCommonHeader();
    dynamic body = {
      "biller_id": operatorIdValue.value,
      "biller_circle": circleValue.value
    };
    final jsonBody = json.encode(body);
    String encryptedBody = await AesEncryption().encrypt(
        jsonBody,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString());
    String reqBody = await ApiReqResFormat().reqFormatter(encryptedBody);
    final plansResponse = await ApiService().postMethod(
        reqBody,
        header,
        PrefManager().getDeviceId.toString() +
            PrefManager().getCustomerCode.toString(),
        Apis.VIEW_PLANS);
    if (plansResponse != null) {
      if (plansResponse.status!) {
        dynamic dataResult = plansResponse.data;
        for (int i = 0; dataResult.length > i; i++) {
          final jsonEncoded = json.encode(dataResult[i]);
          final jsonDecoded = json.decode(jsonEncoded);
          final plans = MobilePlans.fromJson(jsonDecoded);
          addTabsFromApi(plans);
        }
        tabs = getTabs(plansList)!;
        tabController = getTabController();
        onTapTab(0);
      } else {
        progressVisibility.value = false;
        commonSnackBar(plansResponse.message!);
      }
    } else {
      progressVisibility.value = false;
      commonSnackBar('error_network_timeout'.tr);
    }
  }

  ///adding category to tabs
  void addTabsFromApi(MobilePlans mobilePlans) {
    plansList.add(mobilePlans);
  }

  ///setting tabs title
  RxList<Tab>? getTabs(RxList<MobilePlans> plansTabs) {
    tabs.clear();
    progressVisibility.value = false;
    List<Tab> listTabs = [];
    for (int i = 0; i < plansTabs.length; i++) {
      listTabs.add(getTab(plansTabs[i].planCategoryName.toString()));
    }
    List<Tab> tabsList = listTabs.distinct((d) => d.text.toString()).toList();
    tabs.addAll(tabsList);
    return tabs;
  }

  ///setting tab controller
  TabController getTabController() {
    return TabController(length: tabs.length, vsync: this);
  }

  ///setting tabs
  Tab getTab(String name) {
    return Tab(
      text: name,
    );
  }

  ///tab click function
  void onTapTab(int index) {
    rechargePlansList.clear();
    planName.value = tabs[index].text.toString();
    rechargePlansList.value = plansList
        .where(
            (element) => element.planCategoryName.toString() == planName.value)
        .toList();
    rechargePlansList.sort((a, b) => double.parse(a.amount.toString())
        .compareTo(double.parse(b.amount.toString())));
  }

  void planSearch(String searchText) {
    searchText = planSearchController.text;
    rechargePlansList.clear();
    rechargePlansList.value = plansList
        .where((element) => element.amount.toString().contains(searchText))
        .toList();
  }

  ///setting operator image
  void setOperatorImage() {
    switch (operatorIdValue.value) {
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

  ///operator change click function
  onChangeOperatorTap() async {
    dynamic data =
        await Get.to(() => const OperatorPage(), binding: OperatorBinding());
    circle.value = data[AppStrings.txtCircle];
    billerName.value = data[AppStrings.txtOperator];
    operatorIdValue.value = data[AppStrings.txtOperatorId];
    if (data != null) {
      progressVisibility.value = true;
      tabs.clear();
      rechargePlansList.clear();
      plansList.clear();
      setOperatorImage();
      fetchPlanTabsFromApi();
    }
  }

  ///plan select function
  onPlanTileTap(String planId, String amount, String planDescription) {
    Get.to(() => const MobileRechargePage(),
        binding: MobileRechargeBinding(),
        arguments: {
          AppStrings.txtMobileNo: arguments[AppStrings.txtMobileNo],
          AppStrings.txtSenderName: arguments[AppStrings.txtSenderName],
          AppStrings.txtSenderMobile: arguments[AppStrings.txtSenderMobile],
          AppStrings.txtOperatorId: operatorIdValue.value,
          AppStrings.txtOperator: billerName.value,
          AppStrings.txtCircle: circleValue.value,
          AppStrings.txtPlanId: planId.toString(),
          AppStrings.txtAmount: amount.toString(),
          AppStrings.txtPlanDescription: planDescription.toString(),
          AppStrings.txtOperatorImage: operatorImg.value,
        });
  }
}
