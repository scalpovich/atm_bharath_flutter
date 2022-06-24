import 'package:atm_flutter_app/pages/door_step/accepted_order/door_step_accepted_order_page.dart';
import 'package:atm_flutter_app/pages/door_step/completed_order/door_step_completed_order_page.dart';
import 'package:atm_flutter_app/pages/door_step/door_step_controller.dart';
import 'package:atm_flutter_app/pages/door_step/pending_order/door_step_pending_orders_page.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoorStepPage extends GetView<DoorStepController> {
  const DoorStepPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorsPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppDrawable.filePath + AppDrawable.atmLogoCropped,
              height: 60,
              width: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 17.0),
              child: TextWidget(
                text: '',
                textColor: AppColors.white,
                textSize: 12,
              ),
            )
          ],
        ),
        leading: const IconButtonWidget(
          icon: Icons.arrow_back,
          iconSize: 30,
          iconColor: AppColors.white,
        ),
        bottom: TabBar(
          controller: controller.tabController,
          tabs: const [
            Tab(
              text: AppStrings.txtPending,
            ),
            Tab(
              text: AppStrings.txtAccepted,
            ),
            Tab(
              text: AppStrings.txtCompleted,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          DoorStepPendingOrdersPage(),
          // DoorStepAcceptedOrderPage(),
          DoorStepCompletedOrderPage(),
        ],
      ),
    );
  }
}
