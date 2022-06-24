import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../resources/app_drawables.dart';
import '../../../../widgets/button_widget/icon_button_widget.dart';
import 'mobile_recharge_controller.dart';

class MobileRechargePage extends GetView<MobileRechargeController> {
  const MobileRechargePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  Expanded(
                    flex: 0,
                    child: Expanded(
                        flex: 0,
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
                                iconSize: 20,
                                onTap: Get.back,
                                iconColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!,
                              ),
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            AppDrawable.filePath + AppDrawable.mobileRecharge,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            height: 25,
                            width: 25,
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          text: 'mobile_recharge'.tr,
                          textColor:
                              Theme.of(context).textTheme.bodyText1!.color!,
                          textSize: 20,
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
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ))
                ],
              ),
            ),
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
                                image: AssetImage(AppDrawable.filePath +
                                    controller.operatorImg.value),
                                fit: BoxFit.fill),
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
                        text: controller.operator,
                        textColor:
                            Theme.of(context).textTheme.bodyText1!.color!,
                        textSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWidget(
                          text: controller.circle,
                          textColor:
                              Theme.of(context).textTheme.bodyText1!.color!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWidget(
                        text: 'rupee'.tr + ' ' + controller.amount,
                        textColor:
                            Theme.of(context).textTheme.bodyText1!.color!,
                        textSize: 20,
                      ),
                    ),
                    TextWidget(
                      text: controller.mobileNo.toString(),
                      textColor: Theme.of(context).textTheme.bodyText1!.color!,
                      textSize: 20,
                    )
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
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextWidget(
                              text: controller.planDescription,
                              textColor: Theme.of(context).primaryColor,
                              textSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => ButtonWidget(
                                btnColor: Theme.of(context).primaryColor,
                                labelColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                label: 'pay'.tr,
                                width: Get.width - 100,
                                clicked: controller.payBtnClicked.value,
                                onTap: controller.onPayTap,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
