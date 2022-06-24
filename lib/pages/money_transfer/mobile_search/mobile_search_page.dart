import 'package:atm_flutter_app/pages/money_transfer/mobile_search/mobile_search_controller.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/money_transfer_mobile_search_card.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileSearchPage extends GetView<MobileSearchController> {
  const MobileSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: TextWidget(
            text: 'mobile_search_list'.tr.toUpperCase(),
            textColor: Theme.of(context).appBarTheme.titleTextStyle!.color!),
        leading: IconButtonWidget(
          icon: Icons.arrow_back_ios,
          iconSize: 25,
          onTap: Get.back,
          iconColor: Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: controller.status.value
                    ? CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Theme.of(context).primaryColor,
                      )
                    : TextWidget(
                        text: 'no_data_found'.tr,
                        textColor:
                            Theme.of(context).textTheme.subtitle1!.color!))
            : ListView.builder(
                itemCount: controller.searchList.length,
                itemBuilder: (context, int index) {
                  return MoneyTransferMobileSearchCardWidget(
                    onTap: () {
                      Get.back(result: {
                        AppStrings.txtIFSCCode:
                            controller.searchList[index].benefIfsc!,
                        AppStrings.txtCustomerName:
                            controller.searchList[index].cusName!,
                        AppStrings.txtBenefAccNo:
                            controller.searchList[index].benefAccount!,
                        AppStrings.txtBeneficiaryName:
                            controller.searchList[index].benefName!
                      });
                    },
                    title1: 'ifsc_code'.tr,
                    text1: controller.searchList[index].benefIfsc!,
                    title2: 'customer_name'.tr,
                    text2: controller.searchList[index].cusName!,
                    title3: 'benef_acc_no'.tr,
                    text3: controller.searchList[index].benefAccount!,
                    title4: 'benef_name'.tr,
                    text4: controller.searchList[index].benefName!,
                  );
                }),
      ),
    );
  }
}
