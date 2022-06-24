import 'package:atm_flutter_app/pages/bbps/mobile_recharge_page/operator_page/operaor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../resources/app_drawables.dart';
import '../../../../widgets/text_widget/text_widget.dart';

class OperatorPage extends GetView<OperatorController> {
  const OperatorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: TextWidget(
            text: controller.isVisible.value
                ? 'select_operator'.tr
                : 'select_circle'.tr,
            textColor: Theme.of(context).textTheme.bodyText1!.color!),
      ),
      body: Obx(
        () => controller.isVisible.value
            ? ListView.separated(
                itemCount: controller.billerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    tileColor: const Color(0XFFF7F7F7),
                    leading: CircleAvatar(
                      radius: 15,
                      child: Image.asset(
                        AppDrawable.filePath +
                            getIcon(controller.billerList[index].billerid
                                .toString()),
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: TextWidget(
                        text:
                            controller.billerList[index].billerName.toString(),
                        textColor:
                            Theme.of(context).textTheme.subtitle1!.color!),
                    onTap: () => controller.onOperatorTap(
                        controller.billerList[index].billerName.toString(),
                        controller.billerList[index].billerid.toString()),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 5,
                    color: Theme.of(context).textTheme.bodyText1!.color!,
                  );
                },
              )
            : ListView.separated(
                itemCount: controller.circleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    tileColor: const Color(0XFFF7F7F7),
                    title: TextWidget(
                        text: controller.circleList[index].toString(),
                        textColor:
                            Theme.of(context).textTheme.subtitle1!.color!),
                    onTap: () => controller
                        .onCircleTap(controller.circleList[index].toString()),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 5,
                    color: Theme.of(context).textTheme.bodyText1!.color!,
                  );
                },
              ),
      ),
    );
  }

  String getIcon(String id) {
    String icon = '';
    switch (id) {
      case 'AIRTELPRE':
        icon = AppDrawable.airtelIcon;
        break;
      case 'BSNLPRE':
        icon = AppDrawable.bsnlIcon;
        break;
      case 'VODAFONPRE':
        icon = AppDrawable.viIcon;
        break;
      case 'JIOPRE':
        icon = AppDrawable.jioIcon;
        break;
      case 'MTNLDELPRE':
        icon = AppDrawable.mtnlIcon;
        break;
      case 'MTNLMUMPRE':
        icon = AppDrawable.mtnlIcon;
        break;
    }
    return icon;
  }
}
