import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/card_widget/money_transfer_account_search_card_widget.dart';
import 'money_transfer_account_search_controller.dart';

class MoneyTransferAccountSearchPage
    extends GetView<MoneyTransferAccountSearchController> {
  const MoneyTransferAccountSearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: TextWidget(
            text: 'mobile_no_search_list'.tr.toUpperCase(),
            textColor: Theme.of(context).textTheme.bodyText1!.color!),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: controller.status.value
                    ? CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Theme.of(context)
                            .appBarTheme
                            .titleTextStyle!
                            .color!,
                      )
                    : TextWidget(
                        text: 'no_data_found'.tr,
                        textColor:
                            Theme.of(context).textTheme.subtitle1!.color!))
            : ListView.builder(
                itemCount: controller.accountSearchList.length,
                itemBuilder: (context, int index) {
                  return MoneyTransferAccountSearchCardWidget(
                    onTap: () => controller.onTap(index),
                    title1: 'ifsc_code'.tr,
                    text1: controller.accountSearchList[index].benefIfsc!,
                    title2: 'customer_name'.tr,
                    text2: controller.accountSearchList[index].cusName!,
                    title4: 'benef_name'.tr,
                    text4: controller.accountSearchList[index].benefName!,
                  );
                }),
      ),
    );
  }
}
