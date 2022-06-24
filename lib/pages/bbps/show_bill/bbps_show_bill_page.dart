import 'package:atm_flutter_app/pages/bbps/show_bill/bbps_show_bill_controller.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/row_text_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BBPSShowBillPage extends GetView<BBPSShowBillController> {
  const BBPSShowBillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      iconSize: 30,
                      onTap: Get.back,
                      iconColor: Theme.of(context).primaryColor,
                    )),
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 0,
                    child: Image.asset(
                      AppDrawable.filePath + AppDrawable.bharatBillPay,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    )),
              ],
            ),
          ),
          Image.network(
            controller.categoryImage.value,
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
          TextWidget(
            text: controller.billerName.value,
            textColor: Theme.of(context).primaryColor,
            textStyle: FontWeight.bold,
            textSize: 16,
          ),
          Divider(
            thickness: 1,
            color: Theme.of(context).textTheme.subtitle1!.color!,
          ),
          SizedBox(
            height: 400,
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'bbps_category'.tr,
                    text: controller.category.value,
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'bill_id'.tr,
                    text: controller.billId.value,
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'bill_status'.tr,
                    text: controller.billStatus.value,
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'bill_number'.tr,
                    text: '',
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'bill_period'.tr,
                    text: controller.billPeriod.value,
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'net_bill_amount'.tr,
                    text: controller.billAmount.value,
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'customer_name'.tr,
                    text: controller.customerName.value,
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'bill_amount'.tr,
                    text: controller.billAmount.toString(),
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'bill_date'.tr,
                    text: controller.bDate[0],
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'bill_due_date'.tr,
                    text: controller.bdDate[0],
                    textColor: AppColors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowTextWidget(
                    textfield: 'source_ref_no'.tr,
                    text: controller.sourceRefNo.value,
                    textColor: AppColors.grey),
              ),
            ]),
          ),
          ButtonWidget(
            clicked: false,
            label: 'proceed_to_pay'.tr,
            width: 180,
            btnColor: Theme.of(context).primaryColor,
            onTap: () => controller.onTap(),
          ),
        ],
      )),
    );
  }
}
