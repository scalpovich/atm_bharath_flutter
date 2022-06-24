import 'package:atm_flutter_app/pages/money_transfer/report/money_transafer_report_controller.dart';
import 'package:atm_flutter_app/widgets/button_widget/icon_button_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/money_transfer_report_card_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/total_count_summary_card_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

class MoneyTransferReportPage extends GetView<MoneyTransferReportController> {
  const MoneyTransferReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body:Obx(
            () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 3,),
          opacity: 0.0,
    child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    title: SizedBox(
                      height: 35,
                      child: TextField(
                        controller: controller.searchController,
                        onSubmitted: (value) {
                          controller.searchView(value);
                        },
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          hintText: 'search_here'.tr,
                          hintStyle: TextStyle(
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .color!,
                            fontSize: 14,
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .titleTextStyle!
                                      .color!,
                                  width: 1),
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color!),
                      ),
                    ),
                    leading: IconButtonWidget(
                      icon: Icons.arrow_back_ios,
                      iconSize: 20,
                      iconColor:
                          Theme.of(context).appBarTheme.titleTextStyle!.color!,
                      onTap: Get.back,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    expandedHeight: 200.0,
                    floating: true,
                    pinned: false,
                    snap: true,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: 1.0,
                              child: Text(
                                'report'.tr,
                                style: const TextStyle(fontSize: 18.0),
                              )),
                          background: Container(
                            alignment: Alignment.center,
                            color: Theme.of(context).primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 40.0),
                                          child: TextWidget(
                                              align: TextAlign.left,
                                              text: 'from_date'.tr,
                                              textColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: TextWidget(
                                            align: TextAlign.left,
                                            text: 'to_date'.tr,
                                            textColor: Theme.of(context)
                                                .appBarTheme
                                                .titleTextStyle!
                                                .color!))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2.0),
                                      child: SizedBox(
                                        height: 35,
                                        width: 135,
                                        child: DateTimePicker(
                                          type: DateTimePickerType.date,
                                          dateMask: 'dd-MM-yyyy',
                                          initialValue:
                                              controller.firstDay.toString(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3000),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!),
                                          decoration: InputDecoration(
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color!,
                                              ),
                                            ),
                                            enabledBorder: Theme.of(context)
                                                .inputDecorationTheme
                                                .border,
                                            focusedBorder: Theme.of(context)
                                                .inputDecorationTheme
                                                .border,
                                          ),
                                          onChanged: (val) {
                                            controller.firstDay =
                                                DateFormat('yyyy-MM-dd')
                                                    .parse(val);
                                            controller.fromDate.value = val;
                                            controller.setDate();
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2.0),
                                      child: SizedBox(
                                        height: 30,
                                        width: 135,
                                        child: DateTimePicker(
                                          type: DateTimePickerType.date,
                                          dateMask: 'dd-MM-yyyy',
                                          initialValue: DateTime.now().toString(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3000),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!),
                                          decoration: InputDecoration(
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color!,
                                              ),
                                            ),
                                            enabledBorder: Theme.of(context)
                                                .inputDecorationTheme
                                                .border,
                                            focusedBorder: Theme.of(context)
                                                .inputDecorationTheme
                                                .border,
                                          ),
                                          onChanged: (val) {
                                            controller.toDate.value = val;
                                            controller.setDate();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    })),
              ];
            },
            body: Obx(
              () => LoadingOverlay(
                isLoading: controller.isLoading.value,
                progressIndicator: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 3,
                ),
                opacity: 0.0,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0)),
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                    ),
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 0,
                          child: Obx(
                            () => TotalCountSummaryCardWidget(
                                commission: controller.commission.value,
                                fee: controller.fee.value,
                                walletRecharge: controller.walletRecharge.value,
                                transaction: controller.transaction.value),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                            ),
                            child: Obx(() => controller.reportList.isEmpty
                                ? Center(
                                    child: TextWidget(
                                        text: 'no_data_found'.tr,
                                        textSize: 20,
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .color!),
                                  )
                                : ListView.builder(
                                    itemCount: controller.reportList.length,
                                    controller: controller.scrollController,
                                    itemBuilder: (context, index) {
                                      return ReportCardWidget(
                                        title: controller
                                            .reportList[index].benefAccName,
                                        text: '',
                                        mode: controller
                                            .reportList[index].transferMode
                                            .toString(),
                                        status: controller
                                            .reportList[index].status
                                            .toString(),
                                        transactionNo: controller
                                            .reportList[index].transactionId
                                            .toString(),
                                        transactionDate: DateFormat('dd-MM-yyyy')
                                            .format(DateTime.parse(controller
                                                .reportList[index].transactionDate
                                                .toString()))
                                            .toString(),
                                        amount: controller
                                            .reportList[index].amount
                                            .toString(),
                                        onTap: () => controller.onItemTap(index),
                                      );
                                    },
                                  )),
                          ),
                        ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ))));
  }
}
