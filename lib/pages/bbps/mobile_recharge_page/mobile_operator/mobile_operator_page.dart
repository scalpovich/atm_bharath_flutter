import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/mobile_operator/mobile_operator_controller.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/tile_widget/plan_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/button_widget/icon_button_widget.dart';
import '../../../../widgets/text_widget/text_widget.dart';

class MobileOperatorPage extends GetView<MobileOperatorController> {
  const MobileOperatorPage({Key? key}) : super(key: key);

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
                      child: IconButtonWidget(
                        icon: Icons.arrow_back_ios,
                        iconSize: 20,
                        iconColor:
                            Theme.of(context).appBarTheme.titleTextStyle!.color,
                        onTap: Get.back,
                      ),
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
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              height: 25,
                              width: 25,
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextWidget(
                        text: 'mobile_recharge'.tr,
                        align: TextAlign.start,
                        textColor:
                            Theme.of(context).textTheme.bodyText1!.color!,
                        textStyle: FontWeight.normal,
                        textSize: 20,
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
              flex: 1,
              child: SizedBox(
                child: Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0, bottom: 3.0),
                                      child: TextWidget(
                                        textSize: 20,
                                        text: controller
                                            .arguments[AppStrings.txtMobileNo],
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!,
                                        textStyle: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Obx(
                                        () => TextWidget(
                                            textSize: 16,
                                            text:
                                                '${controller.billerName.value},${controller.circle.value}',
                                            textColor: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ButtonWidget(
                                          btnColor: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          labelColor:
                                              Theme.of(context).primaryColor,
                                          label: 'change_operator'.tr,
                                          width: 140,
                                          onTap: controller.onChangeOperatorTap,
                                          clicked: false),
                                    )
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(45),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            AppDrawable.filePath +
                                                controller.operatorImg.value,
                                          ),
                                          fit: BoxFit.fill),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color!,
                                          width: 1)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0)),
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Obx(() {
                                if (controller.tabs.isEmpty) {
                                  if (controller.progressVisibility.value) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TabBar(
                                      indicator: UnderlineTabIndicator(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      labelColor:
                                          Theme.of(context).primaryColor,
                                      unselectedLabelColor: Theme.of(context)
                                          .tabBarTheme
                                          .unselectedLabelColor,
                                      isScrollable: true,
                                      controller: controller.tabController,
                                      tabs: controller.tabs,
                                      onTap: controller.onTapTab,
                                    ),
                                  );
                                }
                              }),
                            ),
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => ListView.separated(
                                  itemCount:
                                      controller.rechargePlansList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      child: PlanTileWidget(
                                        days: controller
                                            .rechargePlansList[index].validity
                                            .toString(),
                                        amount: controller
                                            .rechargePlansList[index].amount
                                            .toString(),
                                        description: controller
                                            .rechargePlansList[index]
                                            .planDescription
                                            .toString(),
                                      ),
                                      onTap: () => controller.onPlanTileTap(
                                          controller
                                              .rechargePlansList[index].planid
                                              .toString(),
                                          controller
                                              .rechargePlansList[index].amount
                                              .toString(),
                                          controller.rechargePlansList[index]
                                              .planDescription
                                              .toString()),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      thickness: 2,
                                      color: Theme.of(context).primaryColor,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
