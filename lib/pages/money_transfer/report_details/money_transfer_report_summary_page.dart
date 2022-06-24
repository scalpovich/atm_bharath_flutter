import 'package:atm_flutter_app/pages/money_transfer/report_details/money_transfer_report_summary_controller.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/money_transfer_report_details_card.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/button_widget/icon_button_widget.dart';

class MoneyTransferReportSummaryPage
    extends GetView<MoneyTransferReportSummaryController> {
  const MoneyTransferReportSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.status.value == 'Success'
            ? AppColors.green
            : controller.status.value == 'Failed'
                ? AppColors.red
                : AppColors.orange,
        body: SafeArea(
          child: SizedBox(
            child: Column(
              children: [
                Expanded(
                    flex: 0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: IconButtonWidget(
                            icon: Icons.arrow_back_ios,
                            iconSize: 25,
                            iconColor:
                                Theme.of(context).textTheme.bodyText1!.color!,
                            onTap: () => Get.back(),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextWidget(
                            text: 'report_details'.tr.toUpperCase(),
                            textColor:
                                Theme.of(context).textTheme.bodyText1!.color!,
                            textSize: 18,
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextWidget(
                            text: 'To:',
                            textColor:
                                Theme.of(context).textTheme.bodyText1!.color!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Obx(
                          () => TextWidget(
                            text: controller.benefName.value,
                            textColor:
                                Theme.of(context).textTheme.bodyText1!.color!,
                            textSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Obx(
                          () => TextWidget(
                            text: 'rupee'.tr + controller.amount.value,
                            textColor:
                                Theme.of(context).textTheme.bodyText1!.color!,
                            textSize: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: MoneyTransferReportDetailsCard(
                        senderName: controller.senderName.value,
                        senderMobile: controller.senderMobile.value,
                        benefAccNo: controller.accountNo.value,
                        ifscCode: controller.ifsc.value,
                        transactionNo: controller.transactionId.value,
                        transactionDate: controller.transactionDate.value,
                        transferMode: controller.mode.value,
                        fee: controller.fee.value == 'null'
                            ? '0'
                            : controller.fee.value,
                        status: controller.status.value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonWidget(
                      btnColor: Theme.of(context).textTheme.bodyText1!.color!,
                      onTap: controller.onRepeatTap,
                      clicked: false,
                      labelColor: Theme.of(context).primaryColor,
                      label: 'repeat_transaction'.tr,
                      width: 250),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
