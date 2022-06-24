import 'dart:io';
import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_controller.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/mt_dropdown_button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/toggle_button_widget.dart';
// import 'package:atm_flutter_app/widgets/dialog_box_widget/ifsc_dialog_box_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:atm_flutter_app/widgets/textfield_widget/underline_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoneyTransferPage extends GetView<MoneyTransferController> {
  const MoneyTransferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MoneyTransferPageWidget(
          cusNameController: controller.cusNameController,
          cusMobileController: controller.cusMobileController,
          benefNameController: controller.benefNameController,
          benefAccountNoController: controller.benefAccountNoController,
          benefConfirmAccountNoController:
              controller.benefConfirmAccountNoController,
          ifscController: controller.ifscController),
    );
  }
}

class MoneyTransferPageWidget extends GetView<MoneyTransferController> {
  const MoneyTransferPageWidget(
      {Key? key,
      required TextEditingController cusNameController,
      required TextEditingController cusMobileController,
      required TextEditingController benefNameController,
      required TextEditingController benefAccountNoController,
      required TextEditingController benefConfirmAccountNoController,
      required TextEditingController ifscController})
      : _cusNameController = cusNameController,
        _cusMobileController = cusMobileController,
        _benefNameController = benefNameController,
        _benefAccountNoController = benefAccountNoController,
        _benefConfirmAccountNoController = benefConfirmAccountNoController,
        _ifscCodeController = ifscController,
        super(key: key);

  final TextEditingController _cusNameController;
  final TextEditingController _cusMobileController;
  final TextEditingController _benefNameController;
  final TextEditingController _benefAccountNoController;
  final TextEditingController _benefConfirmAccountNoController;
  final TextEditingController _ifscCodeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: IconButtonWidget(
                                  icon: Icons.arrow_back_ios,
                                  iconSize: 25,
                                  iconColor: Theme.of(context)
                                      .appBarTheme
                                      .titleTextStyle!
                                      .color,
                                  onTap: Get.back,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 100.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .titleTextStyle!
                                        .color!,
                                    size: 25,
                                  ),
                                  TextWidget(
                                    text:
                                        PrefManager().getWalletMoney.toString(),
                                    textColor: Theme.of(context)
                                        .appBarTheme
                                        .titleTextStyle!
                                        .color!,
                                    textSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: 'send_money'.tr,
                            textColor: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color!,
                            textSize: 22,
                            textStyle: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: UnderlineTextFieldWidget(
                                autoFocus: true,
                                border: 5.0,
                                errorText: controller.mobileErrorText.value,
                                validate: controller.cusMobileValidate.value,
                                length: 10,
                                hint: 'customer_mobile'.tr,
                                labelText: 'customer_mobile'.tr,
                                controller: _cusMobileController,
                                type: TextInputType.number,
                                suffix: const SizedBox(),
                                enabled: true,
                              ),
                            ),
                            Expanded(
                                flex: 0,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: IconButtonWidget(
                                      icon: Icons.search,
                                      iconSize: 23,
                                      iconColor: Theme.of(context).primaryColor,
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        controller.mobileSearch(
                                            _cusMobileController.text);
                                      }),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UnderlineTextFieldWidget(
                          enabled: true,
                          validate: controller.cusNameValidate.value,
                          errorText: 'customer_name_required'.tr,
                          hint: 'customer_name'.tr,
                          labelText: 'customer_name'.tr,
                          controller: _cusNameController,
                          suffix: const SizedBox(),
                          type: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: UnderlineTextFieldWidget(
                                enabled: true,
                                border: 5.0,
                                errorText: 'benef_name_required'.tr,
                                labelText: 'benef_name'.tr,
                                validate: controller.benefNameValidate.value,
                                hint: 'benef_name'.tr,
                                controller: _benefNameController,
                                suffix: const SizedBox(),
                                type: TextInputType.text,
                              ),
                            ),
                            Expanded(
                                flex: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3.0, right: 3.0, bottom: 3.0),
                                  child: IconButtonWidget(
                                      icon: Icons.search,
                                      iconSize: 23,
                                      iconColor: Theme.of(context).primaryColor,
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        controller.nameSearch(
                                            _benefNameController.text);
                                      }),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: UnderlineTextFieldWidget(
                                enabled: true,
                                border: 5.0,
                                errorText: controller.benefAccNoErrorText.value,
                                validate:
                                    controller.benefAccountNoValidate.value,
                                hint: 'benef_acc_no'.tr,
                                labelText: 'benef_acc_no'.tr,
                                controller: _benefAccountNoController,
                                suffix: const SizedBox(),
                                type: TextInputType.text,
                              ),
                            ),
                            Expanded(
                                flex: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3.0, bottom: 3.0),
                                  child: IconButtonWidget(
                                      icon: Icons.search,
                                      iconSize: 23,
                                      iconColor: Theme.of(context).primaryColor,
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        controller.accountSearch(
                                            _benefAccountNoController.text);
                                      }),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UnderlineTextFieldWidget(
                          enabled: true,
                          errorText:
                              controller.confirmBenefAccNoErrorText.value,
                          validate: controller.benefConfirmValidate.value,
                          hint: 're_enter_benef_acc_no'.tr,
                          labelText: 're_enter_benef_acc_no'.tr,
                          controller: _benefConfirmAccountNoController,
                          type: TextInputType.text,
                          suffix: const SizedBox(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: UnderlineTextFieldWidget(
                                enabled: true,
                                border: 5.0,
                                errorText: controller.ifscErrorText.value,
                                validate: controller.ifscValidate.value,
                                length: 11,
                                hint: 'ifsc_code'.tr,
                                labelText: 'ifsc_code'.tr,
                                controller: _ifscCodeController,
                                suffix: const SizedBox(),
                                type: TextInputType.text,
                              ),
                            ),
                            Expanded(
                                flex: 0,
                                child: IconButtonWidget(
                                    icon: Icons.search,
                                    iconSize: 25,
                                    iconColor: Theme.of(context).primaryColor,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      controller.ifscSearch();
                                    }))
                          ],
                        ),
                      ),
                      TextWidget(
                          text: 'transfer_mode'.tr, textColor: AppColors.grey),
                      Obx(
                        () => ToggleButtonWidget(
                          onTap: controller.checkTransactionMethod,
                          impsValue: controller.isIMPS.value,
                          rtgsValue: controller.isRTGS.value,
                          neftValue: controller.isNEFT.value,
                        ),
                      ),
                      Obx(
                        () => TextWidget(
                            text: controller.toggleText.value.toString(),
                            textColor: AppColors.grey),
                      ),
                      TextWidget(text: 'purpose'.tr, textColor: AppColors.grey),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MTDropDownButtonWidget(
                            purposeList: controller.purposelist,
                            itemList: controller.listPurpose),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => GestureDetector(
                            onTap: _imagePicker,
                            child: Container(
                              height: 100,
                              width: 150,
                              // color: AppColors.black,
                              decoration: BoxDecoration(
                                  image: controller.pickedImage.value.isNotEmpty
                                      ? DecorationImage(
                                          image: FileImage(File(
                                              controller.pickedImage.value)))
                                      : const DecorationImage(
                                          image: AssetImage(AppDrawable
                                                  .filePath +
                                              AppDrawable.imagePlaceholder))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonWidget(
                            clicked: false,
                            label: 'next'.tr,
                            btnColor: Theme.of(context).primaryColor,
                            width: 150,
                            onTap: () {
                              controller.verifyBtnClicked.value = true;
                              FocusScope.of(context).unfocus();
                              controller.textValidation();
                            }
                            //     () {
                            //   Get.to(() => const MoneyTransferFeeSubmit());
                            // },
                            ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _imagePicker() {
    Get.bottomSheet(
      SafeArea(
        child: SizedBox(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text(AppStrings.txtPhotoLibrary),
                  onTap: () {
                    controller
                        .imgFromGallery(AppStrings.txtGallery.toLowerCase());
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text(AppStrings.txtCamera),
                onTap: () {
                  controller.imgFromGallery(AppStrings.txtCamera.toLowerCase());
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      enableDrag: false,
      isDismissible: true,
      backgroundColor:
          Theme.of(Get.context!).appBarTheme.titleTextStyle!.color!,
    );
  }

  void exitDialogBox(BuildContext context) {
    Get.defaultDialog(
        title: '',
        content: TextWidget(
            text: 'details_entered_lose_dialog'.tr,
            textColor: Theme.of(context).textTheme.subtitle1!.color!),
        cancel: ButtonWidget(
          label: 'cancel'.tr,
          width: 100,
          clicked: false,
          onTap: onCancelTap,
        ),
        confirm: ButtonWidget(
          label: 'ok'.tr,
          width: 100,
          clicked: false,
          onTap: onOkTapped,
        ));
  }

  void onCancelTap() {
    Get.back();
  }

  void onOkTapped() {
    Get.back();
    Get.back();
  }
}
