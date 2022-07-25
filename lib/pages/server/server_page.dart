import 'package:atm_flutter_app/pages/server/server_controller.dart';
import 'package:atm_flutter_app/widgets/button_widget/check_box_widget.dart';
import 'package:atm_flutter_app/widgets/textfield_widget/underline_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../resources/app_strings.dart';
import '../../widgets/button_widget/button_widget.dart';
import '../../widgets/text_widget/text_widget.dart';

class ServerPage extends GetView<ServerController> {
  const ServerPage({Key? key}) : super(key: key);

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
        title: TextWidget(
          text: 'app_name'.tr,
          textSize: 18,
          textColor: Theme.of(context).textTheme.bodyText1!.color!,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
          onPressed: () => Get.back(),
        ),
        // actions: [
        //   IconButtonWidget(
        //     icon: Icons.info_outline,
        //     iconSize: 25,
        //     iconColor: Theme.of(context).textTheme.bodyText1!.color,
        //     onTap: controller.alertPop,
        //   )
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _openProjectAlertBox,
        child: Icon(
          Icons.add,
          color: Theme.of(context).textTheme.bodyText1!.color!,
          size: 24,
        ),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: controller.serverList.length,
            itemBuilder: (BuildContext context, int index) {
              // return CheckBoxWidget(
              //     url: controller.serverList[index].serverUrl!,
              //     isChecked: controller.serverList[index].serverStatus!,
              //     onChanged: (value) => controller.onchangeValue(value, index));
              return Slidable(
                key: const ValueKey(0),
                enabled: true,
                // Padding(
                //   padding: const EdgeInsets.all(5.0),
                //   child: Card(
                //     elevation:
                //         controller.serverList[index].serverStatus! ? 5 : 0,
                //     color: controller.serverList[index].serverStatus!
                //         ? Theme.of(context).primaryColor
                //         : Theme.of(context).textTheme.bodyText1!.color!,
                //     child: ListTile(
                //       // leading:
                //       title: TextWidget(
                //         text:
                //             controller.serverList[index].serverUrl.toString(),
                //         textColor: controller.serverList[index].serverStatus!
                //             ? Theme.of(context).textTheme.bodyText1!.color!
                //             : Theme.of(context).textTheme.subtitle1!.color!,
                //       ),
                //     ),
                //   ),
                // ),
                startActionPane: ActionPane(
                  extentRatio: 0.20,
                  dragDismissible: false,
                  motion: const DrawerMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) =>
                          controller.onItemDelete(index),
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor:
                          Theme.of(context).textTheme.bodyText1!.color!,
                      icon: Icons.delete,
                      label: AppStrings.txtDelete,
                      spacing: 10.0,
                    )
                  ],
                ),
                child: CheckBoxWidget(
                    url: controller.serverList[index].serverUrl!,
                    isChecked: controller.serverList[index].serverStatus!,
                    onChanged: (value) =>
                        controller.onchangeValue(value, index)),
                //     endActionPane: ActionPane(
                //         extentRatio: 0.20,
                //         dragDismissible: false,
                //         motion: const ScrollMotion(),
                //         children: [
                //           SlidableAction(
                //             onPressed: (BuildContext context) =>
                //                 controller.onItemSelected(index),
                //             backgroundColor: const Color(0xFF7BC043),
                //             foregroundColor:
                //                 Theme.of(context).textTheme.bodyText1!.color!,
                //             icon: Icons.arrow_forward,
                //           ),
                //         ])
              );
            }),
      ),
    );
  }

  _openProjectAlertBox() {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      contentPadding: const EdgeInsets.all(20.0),
      radius: 15.0,
      title: 'add_server'.tr,
      titleStyle:
          TextStyle(color: Theme.of(Get.context!).textTheme.subtitle1!.color!),
      backgroundColor: Theme.of(Get.context!).textTheme.bodyText1!.color!,
      barrierDismissible: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UnderlineTextFieldWidget(
            enabled: true,
            hint: 'server_url'.tr,
            labelText: 'server_url'.tr,
            controller: controller.serverUrlController,
            validate: true,
            suffix: const SizedBox(),
            type: TextInputType.url,
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonWidget(
            width: 100,
            label: 'add'.tr,
            btnColor: Theme.of(Get.context!).primaryColor,
            onTap: controller.addServerToDB,
            clicked: false,
          ),
        ],
      ),
    );
  }
}
