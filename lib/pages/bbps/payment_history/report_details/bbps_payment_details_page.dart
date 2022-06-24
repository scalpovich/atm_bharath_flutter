import 'package:atm_flutter_app/pages/home/home_page.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/bbps_report_details_card_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../../resources/app_drawables.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../home/home_binding.dart';
import 'bbps_payment_details_controller.dart';

class BBPSPaymentDetailsPage extends GetView<BBPSPaymentDetailsController> {
  const BBPSPaymentDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackPressed,
      child: Obx(
        () => Scaffold(
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
                                      onTap: () => controller.onPrintTap(),
                                    ))),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  AppDrawable.filePath +
                                      AppDrawable.bbpsBillLogo,
                                  height: 80,
                                  width: 70,
                                  fit: BoxFit.contain,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Obx(
                              () => TextWidget(
                                text: controller.billerName.value,
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
                                text: 'rupee'.tr +
                                    controller.totalAmount.value.toString(),
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
                      flex: 2,
                      child: Obx(
                        () => Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: BBPSReportDetailsCardWidget(
                              status: controller.status.value,
                              senderMobile: controller.senderMobile.value,
                              senderName: controller.senderName.value,
                              parameterName: controller.parameterName.value,
                              parameterValue: controller.subscriberId.value,
                              bbpsRefNo: controller.bbpsRefNo.value,
                              billerName: controller.billerName.value,
                              billerId: controller.billerID.value,
                              billDate: controller.billDate.value,
                              billAmount: controller.billAmount.value,
                              convFee: controller.convFee.value,
                              totalAmount:
                                  controller.totalAmount.value.toString(),
                              paymentChannel: controller.paymentChannel.value,
                              paymentId: controller.paymentId.value,
                              paymentMode: controller.paymentMode.value,
                            )),
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
          ),
        ),
      ),
    );
  }
}
