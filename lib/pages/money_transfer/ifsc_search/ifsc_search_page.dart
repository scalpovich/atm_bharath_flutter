import 'package:atm_flutter_app/pages/money_transfer/ifsc_search/ifsc_search_controller.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/card_widget/money_transfer_ifsc_search_card.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IFSCSearchPage extends GetView<IFSCSearchController> {
  const IFSCSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: TextWidget(
            text: 'ifsc_search_list'.tr.toUpperCase(),
            textColor: Theme.of(context).appBarTheme.titleTextStyle!.color!),
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
                itemCount: controller.ifscSearchList.length,
                itemBuilder: (context, int index) {
                  return MoneyTransferIFSCSearchCard(
                    bank: controller.ifscSearchList[index].bank!,
                    branch: controller.ifscSearchList[index].branch!,
                    state: controller.ifscSearchList[index].state!,
                    district: controller.ifscSearchList[index].district!,
                    ifscCode: controller.ifscSearchList[index].ifsc!,
                    onTap: () => Get.back(result: {
                      AppStrings.txtIFSCCode:
                          controller.ifscSearchList[index].ifsc!
                    }),
                  );
                }),
      ),
    );
  }
}
