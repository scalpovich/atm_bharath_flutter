import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_number/mobile_number_controller.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:atm_flutter_app/widgets/textfield_widget/underline_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';

class MobileNumberPage extends GetView<MobileNumberController> {
  const MobileNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: _BodyWidget(),
    );
  }
}

class _BodyWidget extends GetView<MobileNumberController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
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
                          child: IconButtonWidget(
                            icon: Icons.arrow_back_ios,
                            iconSize: 25,
                            iconColor:
                                Theme.of(context).textTheme.bodyText1!.color,
                            onTap: Get.back,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              AppDrawable.filePath + AppDrawable.bbpsBillLogo,
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                            ),
                          ))
                    ],
                  )),
              Expanded(
                  flex: 0,
                  child: SizedBox(
                    height: 150,
                    // color: AppColors.colorsPrimary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                AppDrawable.filePath +
                                    controller.catImage.value,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                height: 25,
                                width: 25,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: 'mobile_recharge'.tr,
                            textColor:
                                Theme.of(context).textTheme.bodyText1!.color!,
                            textStyle: FontWeight.bold,
                            textSize: 18,
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0))),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 20.0),
                        child: Obx(
                          () => UnderlineTextFieldWidget(
                            autoFocus: true,
                            hint: 'sender_name'.tr,
                            labelText: 'sender_name'.tr,
                            controller: controller.senderNameController,
                            validate: controller.senderNameValidate.value,
                            enabled: true,
                            action: TextInputAction.next,
                            errorText: 'sender_name_required'.tr,
                            type: TextInputType.text,
                            suffix: const SizedBox(),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: Obx(
                            () => UnderlineTextFieldWidget(
                              hint: 'sender_mobile'.tr,
                              labelText: 'sender_mobile'.tr,
                              action: TextInputAction.next,
                              controller: controller.senderNumberController,
                              validate: controller.senderNumberValidate.value,
                              enabled: true,
                              errorText: 'sender_mobile_required'.tr,
                              type: TextInputType.number,
                              suffix: const SizedBox(),
                            ),
                          )),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                          child: !controller.isLoading.value
                              ? Obx(
                                  () => Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: UnderlineTextFieldWidget(
                                          labelText: 'enter_mobile_number'.tr,
                                          hint: 'enter_mobile_number'.tr,
                                          controller:
                                              controller.numberController,
                                          validate:
                                              controller.numberValidate.value,
                                          enabled: true,
                                          type: TextInputType.number,
                                          suffix: const IconButtonWidget(
                                            icon: Icons.contacts,
                                            iconSize: 20,
                                            // onTap: controller.getContacts,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 0,
                                        child: Obx(
                                          () => Checkbox(
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              value:
                                                  controller.checkValue.value,
                                              onChanged: (value) => controller
                                                  .onCheckTap(value!)),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 0,
                                          child: TextWidget(
                                              lines: 2,
                                              text: 'same_as_above'.tr,
                                              textColor: Theme.of(context)
                                                  .primaryColor))
                                    ],
                                  ),
                                )
                              : Card(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: LoadingAnimationWidget.fallingDot(
                                      color: Theme.of(context).primaryColor,
                                      size: 50,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Obx(
                  () => ButtonWidget(
                    label: 'continue'.tr,
                    width: Get.width,
                    clicked: controller.btnClicked.value,
                    btnColor: Theme.of(context).primaryColor,
                    onTap: controller.verifyField,
                    border: 5,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
