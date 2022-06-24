import 'package:atm_flutter_app/helper/prefManager.dart';
import 'package:atm_flutter_app/pages/home/home_binding.dart';
import 'package:atm_flutter_app/pages/home/home_page.dart';
import 'package:atm_flutter_app/pages/money_transfer/fee_submit/money_transfer_fee_submit_controller.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/button_widget/button_widget.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/money_transfer_transaction_card.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoneyTransferFeeSubmit extends GetView<MoneyTransferFeeSubmitController> {
  const MoneyTransferFeeSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onBackPressed(),
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                leading: IconButtonWidget(
                  icon: Icons.arrow_back_ios,
                  iconSize: 30,
                  onTap: () =>
                      Get.off(() => HomePage(), binding: HomeBinding()),
                  iconColor: Colors.white,
                ),
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return FlexibleSpaceBar(
                      centerTitle: true,
                      title: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: 1.0,
                          child: Text(
                            'fee_info'.tr,
                            style: const TextStyle(fontSize: 12.0),
                          )),
                      background: Container(
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: PrefManager().getCustomerName!,
                              textColor: Theme.of(context)
                                  .appBarTheme
                                  .titleTextStyle!
                                  .color!,
                              textSize: 14,
                            ),
                            TextWidget(
                              text: PrefManager().getShopGstNo!,
                              textColor:
                                  Theme.of(context).textTheme.bodyText1!.color!,
                              textSize: 12,
                            ),
                          ],
                        ),
                      ));
                })),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => MoneyTransferTransactionCard(
                  benefAccNo: controller.benefAccNo.value,
                  benefName: controller.benefName.value,
                  mode: controller.transferMode.value,
                  transDate: controller.transactionDate.value,
                  transNo: controller.transactionNo.value),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextWidget(
                text: 'amount_details'.tr,
                textColor: Theme.of(context).textTheme.subtitle1!.color!,
                textStyle: FontWeight.bold,
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextWidget(
                          align: TextAlign.left,
                          text: 'amount'.tr,
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!)),
                  Expanded(
                    child: Obx(
                      () => TextWidget(
                          text: controller.amount.value.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    flex: 0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Visibility(
                        visible: true,
                        child: TextWidget(
                            align: TextAlign.left,
                            text: 'fee'.tr.toUpperCase(),
                            textColor:
                                Theme.of(context).textTheme.subtitle1!.color!),
                      )),
                  Expanded(
                    child: Obx(
                      () => TextWidget(
                          text: controller.commissionFee.value.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    flex: 0,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextWidget(
                          align: TextAlign.left,
                          text: AppStrings.txtSGST.toUpperCase(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!)),
                  Expanded(
                    child: Obx(
                      () => TextWidget(
                          text: controller.sgst.value.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    flex: 0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextWidget(
                          align: TextAlign.left,
                          text: AppStrings.txtCGSt.toUpperCase(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!)),
                  Expanded(
                    child: Obx(
                      () => TextWidget(
                          text: controller.cgst.value.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    flex: 0,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextWidget(
                          align: TextAlign.left,
                          text: AppStrings.txtIGST.toUpperCase(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!)),
                  Expanded(
                    child: Obx(
                      () => TextWidget(
                          text: controller.cess.value.toString(),
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    flex: 0,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextWidget(
                        align: TextAlign.left,
                        text: 'total_amount'.tr,
                        textColor:
                            Theme.of(context).textTheme.subtitle1!.color!,
                        textStyle: FontWeight.bold,
                      )),
                  Expanded(
                    child: Obx(
                      () => TextWidget(
                        text: 'rupee'.tr +
                            controller.totalAmount.value.toString(),
                        textColor:
                            Theme.of(context).textTheme.subtitle1!.color!,
                        textStyle: FontWeight.bold,
                      ),
                    ),
                    flex: 0,
                  ),
                ],
              ),
            ),
            Center(
              child: ButtonWidget(
                clicked: false,
                label: 'print'.tr,
                btnColor: Theme.of(context).primaryColor,
                width: 150,
                onTap: controller.printReceipt,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
