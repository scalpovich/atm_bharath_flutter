import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../resources/app_drawables.dart';
import '../../../../widgets/button_widget/icon_button_widget.dart';
import '../../../../widgets/text_widget/text_widget.dart';
import 'bbps_bills_payment_controller.dart';

class BBPSBillsPaymentPage extends GetView<BBPSBillsPaymentController> {
  const BBPSBillsPaymentPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: IconButtonWidget(
                                icon: Icons.arrow_back_ios,
                                iconSize: 25,
                                iconColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!,
                                onTap: Get.back,
                              ),
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
                          height: 80,
                          width: 70,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45.0),
                            image: DecorationImage(
                                image: NetworkImage(
                              controller.operatorImage.value,
                            )),
                            border: Border.all(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!,
                                width: 1)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWidget(
                        text: controller.billerName.value,
                        textColor:
                            Theme.of(context).textTheme.bodyText1!.color!,
                        textStyle: FontWeight.bold,
                        textSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 10),
                        child: Obx(
                          () => IntrinsicWidth(
                            child: controller.btnClicked.value
                                ? CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  )
                                : TextField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!,
                                        fontSize: 35),
                                    controller: controller.amountController,
                                    enabled: false,
                                    maxLength: 7,
                                    decoration: InputDecoration(
                                      hintText: 'rupee'.tr,
                                      counterText: '',
                                      prefixText: 'rupee'.tr,
                                      prefixStyle: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color!,
                                          fontSize: 35),
                                      hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!,
                                        fontSize: 20,
                                      ),
                                    ),
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
                child: SizedBox(
                  width: Get.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: keyboardWidget(context),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget keyboardWidget(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 1, child: keyboardItem(context, '1')),
                Expanded(flex: 1, child: keyboardItem(context, '2')),
                Expanded(flex: 1, child: keyboardItem(context, '3')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 1, child: keyboardItem(context, '4')),
                Expanded(flex: 1, child: keyboardItem(context, '5')),
                Expanded(flex: 1, child: keyboardItem(context, '6')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 1, child: keyboardItem(context, '7')),
                Expanded(flex: 1, child: keyboardItem(context, '8')),
                Expanded(flex: 1, child: keyboardItem(context, '9')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: IconButtonWidget(
                        iconSize: 25,
                        icon: Icons.backspace,
                        iconColor: Theme.of(context).primaryColor,
                        onTap: controller.onTextDelete)),
                Expanded(flex: 1, child: keyboardItem(context, '0')),
                Expanded(
                    flex: 1,
                    child: IconButtonWidget(
                      icon: Icons.arrow_forward,
                      iconSize: 25,
                      onTap: controller.onPayTap,
                      iconColor: Theme.of(context).primaryColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget keyboardItem(BuildContext context, String text) {
    return GestureDetector(
      onTap: () => controller.amountController.value =
          TextEditingValue(text: controller.amountController.text + text),
      child: TextWidget(
          text: text,
          textSize: 30,
          textColor: Theme.of(context).textTheme.bodyText2!.color!),
    );
  }
}
