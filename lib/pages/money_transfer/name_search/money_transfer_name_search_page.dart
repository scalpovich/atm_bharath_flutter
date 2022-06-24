import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/card_widget/money_transfer_account_search_card_widget.dart';
import 'money_transfer_name_search_controller.dart';

class MoneyTransferNameSearchPage
    extends GetView<MoneyTransferNameSearchController> {
  const MoneyTransferNameSearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: TextWidget(
            text: 'name_search_list'.tr,
            textColor: Theme.of(context).textTheme.bodyText1!.color!),
        leading: IconButtonWidget(
          icon: Icons.arrow_back_ios,
          iconSize: 25,
          onTap: () => Get.back(),
          iconColor: Theme.of(context).appBarTheme.titleTextStyle!.color!,
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
                itemCount: controller.benefNameSearchList.length,
                itemBuilder: (context, int index) {
                  return MoneyTransferAccountSearchCardWidget(
                    onTap: () => controller.onTap(index),
                    title1: 'ifsc_code'.tr,
                    text1: controller.benefNameSearchList[index].benefIfsc!,
                    title2: 'customer_name'.tr,
                    text2: controller.benefNameSearchList[index].cusName!,
                    title4: 'benef_acc_no'.tr,
                    text4: controller.benefNameSearchList[index].benefAccount!,
                  );
                }),
      ),
    );
  }
}
