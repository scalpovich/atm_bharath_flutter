import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'door_step_pending_order_controller.dart';

class DoorStepPendingOrdersPage
    extends GetView<DoorStepPendingOrderController> {
  const DoorStepPendingOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: (PrefManager().getDriverDutyStatus == 'Y')
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              shrinkWrap: true,
              itemCount: controller.pendingOrderList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    getOrderDetailsDialog(index);
                  },
                  child: GridTile(
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: Stack(
                                // overflow: Overflow.visible,
                                alignment: AlignmentDirectional.centerEnd,
                                fit: StackFit.loose,
                                children: <Widget>[
                                  Positioned(
                                    right: 50,
                                    child: CircleAvatar(
                                        backgroundColor: AppColors.white,
                                        radius: 35,
                                        backgroundImage: AssetImage(
                                            controller.setOrderIcon(controller
                                                .pendingOrderList[index]
                                                .product![0]
                                                .imageName
                                                .toString()))),
                                  ),
                                  Positioned(
                                    left: 30,
                                    child: CircleAvatar(
                                        backgroundColor: AppColors.white,
                                        radius: 35,
                                        backgroundImage: AssetImage(
                                            controller.setOrderIcon(controller
                                                .pendingOrderList[index]
                                                .product![0]
                                                .imageName
                                                .toString()))),
                                  )
                                ],
                              ),
                            ),
                            TextWidget(
                                text: controller.pendingOrderList[index].orderId
                                    .toString(),
                                textColor: AppColors.black),
                            Container(
                              height: 20,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.green, width: 2),
                              ),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.greenish),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () => getDialogBox(
                                      AppStrings.txtAcceptOrder,
                                      AppStrings.txtAccept,
                                      AppStrings
                                          .txtDoorStepOrderAcceptDialogText,
                                      controller.rejectOrder(
                                          controller
                                              .pendingOrderList[index].orderId
                                              .toString(),
                                          index)),
                                  child: const TextWidget(
                                    text: AppStrings.txtAccept,
                                    textColor: AppColors.white,
                                    textSize: 8,
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              height: 20,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColors.red, width: 2),
                              ),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.text),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () => getDialogBox(
                                      AppStrings.txtRejectOrder,
                                      AppStrings.txtReject,
                                      AppStrings
                                          .txtDoorStepOrderRejectDialogText,
                                      controller.rejectOrder(
                                          controller
                                              .pendingOrderList[index].orderId
                                              .toString(),
                                          index)),
                                  child: const TextWidget(
                                    text: AppStrings.txtReject,
                                    textColor: AppColors.white,
                                    textSize: 8,
                                  )),
                            )
                          ],
                        )),
                  ),
                );
              })
          : Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: const TextWidget(
                  text: AppStrings.txtNoNewOrders, textColor: Colors.black),
            ),
    ));
  }

  void getOrderDetailsDialog(int index) {
    Get.defaultDialog(
        backgroundColor: Colors.transparent,
        title: '',
        content: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                      flex: 0,
                      child: Icon(
                        Icons.location_pin,
                        size: 20,
                      )),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                            text: controller.pendingOrderList[index].address
                                    .toString() +
                                ',' +
                                controller.pendingOrderList[index].buildingType
                                    .toString() +
                                ',' +
                                controller.pendingOrderList[index].landmark
                                    .toString(),
                            textColor: AppColors.black),
                      ))
                ],
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: SizedBox(
                          height: 60,
                          width: 60,
                          child: Stack(
                            // overflow: Overflow.visible,
                            alignment: AlignmentDirectional.centerEnd,
                            fit: StackFit.loose,
                            children: <Widget>[
                              Positioned(
                                right: 0,
                                child: CircleAvatar(
                                    backgroundColor: AppColors.white,
                                    radius: 35,
                                    backgroundImage: AssetImage(
                                        controller.setOrderIcon(controller
                                            .pendingOrderList[index]
                                            .product![0]
                                            .imageName
                                            .toString()))),
                              ),
                              Positioned(
                                left: 0,
                                child: CircleAvatar(
                                    backgroundColor: AppColors.white,
                                    radius: 35,
                                    backgroundImage: AssetImage(
                                        controller.setOrderIcon(controller
                                            .pendingOrderList[index]
                                            .product![0]
                                            .imageName
                                            .toString()))),
                              )
                            ],
                          ),
                        ),
                        title: TextWidget(
                            text: controller
                                .pendingOrderList[index].product![0].productName
                                .toString(),
                            textColor: AppColors.black),
                        subtitle: const TextWidget(
                            text: 'amount', textColor: AppColors.black),
                      );
                    }),
              )
            ],
          ),
        ),
        confirm: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.green, width: 2),
          ),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.greenish),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () => getDialogBox(
                  AppStrings.txtRejectOrder,
                  AppStrings.txtReject,
                  AppStrings.txtDoorStepOrderRejectDialogText,
                  controller.rejectOrder(
                      controller.pendingOrderList[index].orderId.toString(),
                      index)),
              child: const TextWidget(
                text: AppStrings.txtAccept,
                textColor: AppColors.white,
                textSize: 8,
              )),
        ),
        cancel: Container(
          margin: const EdgeInsets.only(top: 5),
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.red, width: 2),
          ),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.text),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () => getDialogBox(
                  AppStrings.txtRejectOrder,
                  AppStrings.txtReject,
                  AppStrings.txtDoorStepOrderRejectDialogText,
                  controller.rejectOrder(
                      controller.pendingOrderList[index].orderId.toString(),
                      index)),
              child: const TextWidget(
                text: AppStrings.txtReject,
                textColor: AppColors.white,
                textSize: 8,
              )),
        ),
        barrierDismissible: true);
  }

  void getDialogBox(
      String title, String buttonText, String message, VoidCallback onTap) {
    Get.defaultDialog(
        title: title,
        content: TextWidget(text: message, textColor: Colors.black),
        onCancel: () => Get.back(),
        cancel: TextWidget(text: 'cancel'.tr, textColor: Colors.black),
        confirm: TextWidget(text: buttonText, textColor: Colors.black),
        onConfirm: onTap);
  }
}
