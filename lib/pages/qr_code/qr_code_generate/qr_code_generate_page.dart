import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/qr_code/qr_code_generate/qr_code_controller.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:atm_flutter_app/widgets/textfield_widget/underline_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QRCodeGeneratePage extends GetView<QRCodeController> {
  QRCodeGeneratePage({Key? key}) : super(key: key);
  String exTile = "GST";
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Obx(
          () => Column(children: [
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
                              iconColor:
                                  Theme.of(context).textTheme.bodyText1!.color!,
                              onTap: Get.back,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 100.0, right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!,
                                size: 25,
                              ),
                              TextWidget(
                                text: PrefManager().getWalletMoney.toString(),
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
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
                        text: 'qr'.tr,
                        textColor:
                            Theme.of(context).textTheme.bodyText1!.color!,
                        textSize: 22,
                        textStyle: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UnderlineTextFieldWidget(
                        enabled: true,
                        validate: true,
                        hint: 'invoice_name'.tr,
                        labelText: 'invoice_name'.tr,
                        controller: controller.invoiceNameController,
                        type: TextInputType.text,
                        suffix: const SizedBox(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UnderlineTextFieldWidget(
                        enabled: true,
                        validate: true,
                        hint: 'invoice_no'.tr,
                        labelText: 'invoice_no'.tr,
                        controller: controller.invoiceNoController,
                        suffix: const SizedBox(),
                        type: TextInputType.text,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: AppColors.grey, width: 1)),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Obx(
                                  () => Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextWidget(
                                          text: controller.invoiceDate.value,
                                          textColor: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .color!),
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 0,
                                child: IconButtonWidget(
                                  icon: Icons.arrow_drop_down,
                                  iconSize: 25,
                                  iconColor: Theme.of(context).primaryColor,
                                  onTap: onDateTap,
                                )),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => UnderlineTextFieldWidget(
                          autoFocus: true,
                          validate: controller.amountValidate.value,
                          errorText: 'amount_required'.tr,
                          hint: 'amount'.tr,
                          labelText: 'amount'.tr,
                          controller: controller.amountController,
                          align: TextAlign.end,
                          type: TextInputType.number,
                          enabled: true,
                          suffix: const SizedBox(),
                        ),
                      ),
                    ),
                    Obx(
                      () => Container(
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: ExpansionPanelList(
                          expansionCallback: (panelIndex, bool isExpanded) {
                            exTile = 'GST';
                            active = !controller.isExpanded.value;
                            controller.isExpanded.value = !isExpanded;
                          },
                          children: [
                            ExpansionPanel(
                              headerBuilder: (context, bool isExpanded) {
                                return Container(
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.only(left: 60.0),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  alignment: Alignment.center,
                                  child: TextWidget(
                                    text: 'gst_info'.tr,
                                    textColor: Theme.of(context).primaryColor,
                                    textSize: 15,
                                  ),
                                );
                              },
                              body: expansionBody(context),
                              isExpanded: controller.isExpanded.value,
                              canTapOnHeader: true,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonWidget(
                        clicked: controller.btnClicked.value,
                        label: AppStrings.txtGenerate,
                        btnColor: Theme.of(context).primaryColor,
                        width: 150,
                        onTap: () => controller.textValidate(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ))));
  }

  Widget expansionBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnderlineTextFieldWidget(
                suffix: const SizedBox(),
                type: TextInputType.number,
                enabled: true,
                validate: true,
                // labelText: AppStrings.txtGSTIn.toUpperCase(),
                hint: AppStrings.txtGSTIn.toUpperCase(),
                controller: controller.gstInController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnderlineTextFieldWidget(
                suffix: const SizedBox(),
                type: TextInputType.number,
                enabled: true,
                validate: true,
                labelText: AppStrings.txtGST.toUpperCase(),
                hint: AppStrings.txtGST.toUpperCase(),
                controller: controller.gstController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnderlineTextFieldWidget(
                suffix: const SizedBox(),
                type: TextInputType.number,
                labelText: AppStrings.txtCGSt.toUpperCase(),
                enabled: true,
                validate: true,
                hint: AppStrings.txtCGSt.toUpperCase(),
                controller: controller.cgstController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnderlineTextFieldWidget(
                suffix: const SizedBox(),
                type: TextInputType.number,
                labelText: AppStrings.txtSGST.toUpperCase(),
                enabled: true,
                validate: true,
                hint: AppStrings.txtSGST.toUpperCase(),
                controller: controller.sgstController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnderlineTextFieldWidget(
                suffix: const SizedBox(),
                type: TextInputType.number,
                labelText: AppStrings.txtIGST.toUpperCase(),
                enabled: true,
                validate: true,
                hint: AppStrings.txtIGST.toUpperCase(),
                controller: controller.igstController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnderlineTextFieldWidget(
              enabled: true,
              validate: true,
              labelText: AppStrings.txtCESS.toUpperCase(),
              hint: AppStrings.txtCESS.toUpperCase(),
              controller: controller.cessController,
              suffix: const SizedBox(),
              type: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnderlineTextFieldWidget(
              labelText: AppStrings.txtGSTIncentive.toUpperCase(),
              enabled: true,
              validate: true,
              hint: AppStrings.txtGSTIncentive.toUpperCase(),
              controller: controller.gstIncentiveController,
              suffix: const SizedBox(),
              type: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UnderlineTextFieldWidget(
              enabled: true,
              validate: true,
              labelText: AppStrings.txtGSTPCT.toUpperCase(),
              hint: AppStrings.txtGSTPCT.toUpperCase(),
              controller: controller.gstPctController,
              suffix: const SizedBox(),
              type: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  void onDateTap() async {
    final DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));
    controller.invoiceDate.value =
        DateFormat('dd/MM/yyyy').format(pickedDate!).toString();
  }
}
