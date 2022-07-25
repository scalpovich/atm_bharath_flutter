import 'package:atm_flutter_app/pages/qr_code/report_details/qr_code_report_summary_controller.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/qr_report_details_card_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../resources/app_colors.dart';
import '../../home/home_binding.dart';
import '../../home/home_page.dart';

class QRCodeReportSummaryPage extends GetView<QRCodeReportSummaryController> {
  QRCodeReportSummaryPage({Key? key}) : super(key: key);

  @override
  QRCodeReportSummaryController controller =
      Get.put(QRCodeReportSummaryController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onBackPressed(),
      child: Scaffold(
          backgroundColor: controller.status.value == 'SUCCESS'
              ? AppColors.green
              : controller.status.value == 'FAILED'
                  ? AppColors.red
                  : AppColors.orange,
          body: Obx(
            () => LoadingOverlay(
              isLoading: controller.isLoading.value,
              progressIndicator: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
                strokeWidth: 3,
              ),
              opacity: 0.0,
              child: SafeArea(
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
                                iconColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!,
                                onTap: () {
                                  if (controller.home.value) {
                                    Get.off(() => HomePage(),
                                        binding: HomeBinding());
                                  } else {
                                    Get.back();
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextWidget(
                                text: 'report_details'.tr.toUpperCase(),
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!,
                                textSize: 18,
                              ),
                            ),
                            Expanded(
                                flex: 0,
                                child: Visibility(
                                    visible:
                                        controller.status.value == 'SUCCESS',
                                    child: IconButtonWidget(
                                      icon: Icons.print,
                                      iconSize: 25,
                                      iconColor: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      onTap: () => controller.printReceipt(),
                                    ))),
                          ],
                        )),
                    Expanded(
                      flex: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextWidget(
                              text: 'To:',
                              textColor:
                                  Theme.of(context).textTheme.bodyText1!.color!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Obx(
                              () => TextWidget(
                                text: controller.name.value,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!,
                                textSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Obx(
                              () => TextWidget(
                                text: 'rupee'.tr + controller.amount.value,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!,
                                textSize: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () => Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: QRReportDetailsCardWidget(
                            status: controller.status.value,
                            amount: controller.amount.value,
                            invoiceNo: controller.invoiceNo.value,
                            invoiceName: controller.invoiceName.value,
                            invoiceDate: controller.invoiceDate.value,
                            transId: controller.transactionNo.value,
                            transDate: controller.transactionDate.value,
                            gst: controller.gst.value,
                            gstIn: controller.gstIn.value,
                            gstIncentive: controller.gstIncentive.value,
                            cess: controller.cess.value,
                            igst: controller.igst.value,
                            sgst: controller.sgst.value,
                            cgst: controller.cgst.value,
                            gstPct: controller.gstPct.value,
                            onExpanded: controller.onExpanded,
                            isExpanded: controller.isExpanded.value,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonWidget(
                            onTap: controller.onRepeatTap,
                            clicked: false,
                            labelColor: Theme.of(context).primaryColor,
                            label: 'repeat_transaction'.tr,
                            width: 150,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: controller.status.value == 'PENDING',
                            child: ButtonWidget(
                              onTap: () => controller.getStatusFromApi(),
                              clicked: false,
                              labelColor: Theme.of(context).primaryColor,
                              label: 'check_status'.tr,
                              width: 150,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
