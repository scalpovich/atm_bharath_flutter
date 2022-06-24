import 'package:atm_flutter_app/pages/door_step/completed_order/door_step_completed_order_controller.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoorStepCompletedOrderPage
    extends GetView<DoorStepCompletedOrderController> {
  DoorStepCompletedOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView.builder(
          itemCount: controller.completedOrderList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5,
              child: ListTile(
                leading: const Icon(
                  Icons.done,
                  size: 25,
                  color: AppColors.green,
                ),
                title: TextWidget(
                    text:
                        controller.completedOrderList[index].orderId.toString(),
                    textColor: AppColors.black),
                subtitle: TextWidget(
                    text: controller.completedOrderList[index].orderTime
                            .toString() +
                        '-' +
                        controller.completedOrderList[index].endTime.toString(),
                    textColor: AppColors.black),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                ),
                onTap: () => {},
              ),
            );
          }),
    );
  }
}
