import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/home/home_binding.dart';
import 'package:atm_flutter_app/pages/home/home_page.dart';
import 'package:atm_flutter_app/pages/sync/sync_controller.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/row_widget/sync_row_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SyncPage extends GetView<SyncController> {
  const SyncPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0)),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
          onPressed: () {
            if (controller.btnVisibility.value) {
              Get.off(() => HomePage(), binding: HomeBinding());
            } else {
              controller.cancelDialog();
            }
          },
        ),
        title: TextWidget(
          text: 'app_name'.tr,
          textColor: Theme.of(context).textTheme.bodyText1!.color!,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Obx(
                () => ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularPercentIndicator(
                        percent: controller.percent.value,
                        radius: 40.0,
                        lineWidth: 7,
                        animation: true,
                        center: TextWidget(
                            text: controller.percentValue.value + '%',
                            textColor: Theme.of(context).primaryColor),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    Visibility(
                        visible: PrefManager().getMoneyTransfer ?? false,
                        child: SyncRowWidget(
                            synced: controller.reportSynced.value,
                            text: AppStrings.txtMoneyTransferReport)),
                    Visibility(
                        visible: PrefManager().getBBPS ?? false,
                        child: SyncRowWidget(
                            synced: controller.bbpsReportSynced.value,
                            text: AppStrings.txtBBPSReport)),
                    Visibility(
                        visible: PrefManager().getQR ?? false,
                        child: SyncRowWidget(
                            synced: controller.qrReportSynced.value,
                            text: AppStrings.txtQRReport)),
                    Visibility(
                        visible: controller.doorStepUser.value,
                        child: SyncRowWidget(
                            synced: controller.doorStepReportSynced.value,
                            text: AppStrings.txtDoorStepReport)),
                    Visibility(
                        visible: PrefManager().getMoneyTransfer ?? false,
                        child: SyncRowWidget(
                            synced: controller.bankSynced.value,
                            text: AppStrings.txtBank)),
                    Visibility(
                        visible: PrefManager().getMoneyTransfer ?? false,
                        child: SyncRowWidget(
                            synced: controller.purposeSynced.value,
                            text: 'purpose'.tr)),
                    Visibility(
                        visible: PrefManager().getBBPS ?? false,
                        child: SyncRowWidget(
                            synced: controller.billerCircleSynced.value,
                            text: AppStrings.txtBillerCircle)),
                    // ],
                    // )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Visibility(
                    visible: controller.btnVisibility.value,
                    child: ButtonWidget(
                      label: 'Done',
                      width: 150,
                      clicked: controller.btnClicked.value,
                      btnColor: Theme.of(context).primaryColor,
                      onTap: () {
                        controller.btnClicked.value = true;
                        Get.off(() => HomePage(), binding: HomeBinding());
                      },
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
