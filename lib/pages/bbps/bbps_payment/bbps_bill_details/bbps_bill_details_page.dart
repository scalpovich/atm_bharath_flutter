import 'package:atm_flutter_app/pages/bbps/bbps_payment/bbps_bill_details/bbps_bill_details_controller.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../resources/app_drawables.dart';
import '../../../../widgets/button_widget/icon_button_widget.dart';
import '../../../../widgets/text_widget/text_widget.dart';
import '../../../../widgets/textfield_widget/underline_text_field_widget.dart';

class BBPSBillDetailsPage extends GetView<BBPSBillDetailsController> {
  const BBPSBillDetailsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Expanded(
                  flex: 0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: IconButtonWidget(
                                icon: Icons.arrow_back_ios,
                                iconSize: 25,
                                iconColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                onTap: Get.back,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Image.asset(
                            AppDrawable.filePath + AppDrawable.bbpsBillLogo,
                            height: 60,
                            width: 60,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: SizedBox(
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  controller.billerImage.value.toString(),
                                ),
                              ),
                              border: Border.all(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!,
                                  width: 1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: controller.billerName.value,
                            textColor:
                                Theme.of(context).textTheme.bodyText1!.color!,
                            textSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyText1!.color!,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Obx(
                                    () => UnderlineTextFieldWidget(
                                      autoFocus: true,
                                      hint: 'sender_name'.tr,
                                      labelText: 'sender_name'.tr,
                                      action: TextInputAction.next,
                                      controller:
                                          controller.senderNameController,
                                      validate:
                                          controller.senderNameValidate.value,
                                      enabled: true,
                                      errorText: 'sender_name_required'.tr,
                                      type: TextInputType.text,
                                      suffix: const SizedBox(),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 12.0),
                                    child: Obx(
                                      () => UnderlineTextFieldWidget(
                                        hint: 'sender_mobile'.tr,
                                        labelText: 'sender_mobile'.tr,
                                        action: TextInputAction.next,
                                        controller:
                                            controller.senderMobileController,
                                        validate: controller
                                            .senderMobileValidate.value,
                                        enabled: true,
                                        errorText: 'sender_mobile_required'.tr,
                                        type: TextInputType.number,
                                        suffix: const SizedBox(),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 12.0,
                                      bottom: 10.0),
                                  child: Obx(
                                    () => ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.authenticatorList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          controller.requiredFieldController
                                              .add(TextEditingController());
                                          return UnderlineTextFieldWidget(
                                            labelText: controller
                                                    .authenticatorList[index]
                                                    .parameterName
                                                    .toString() +
                                                ' (required)',
                                            type: TextInputType.text,
                                            validate: controller
                                                .authValidateList[index],
                                            // errorText: 'required_field'.tr,
                                            hint: controller
                                                    .authenticatorList[index]
                                                    .parameterName
                                                    .toString() +
                                                ' (required)',
                                            controller: controller
                                                .requiredFieldController[index],
                                            suffix: const SizedBox(),
                                            enabled: true,
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: controller.isPartialPay.value
                                        ? ButtonWidget(
                                            label: 'Partial Pay',
                                            width: Get.width - 100,
                                            btnColor:
                                                Theme.of(context).primaryColor,
                                            clicked: false,
                                            onTap: controller.onPartialPayTap,
                                          )
                                        : const SizedBox()),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: controller.fetchBillVisible.value
                                      ? ButtonWidget(
                                          label: 'Show Bill'.tr,
                                          width: Get.width - 100,
                                          clicked: controller.btnClicked.value,
                                          btnColor:
                                              Theme.of(context).primaryColor,
                                          onTap: controller.onFetchBillTap,
                                        )
                                      : ButtonWidget(
                                          label: 'pay'.tr,
                                          width: Get.width - 100,
                                          btnColor:
                                              Theme.of(context).primaryColor,
                                          clicked: controller.btnClicked.value,
                                          onTap: controller.onPayTap,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
