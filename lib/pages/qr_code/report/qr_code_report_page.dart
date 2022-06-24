import 'package:atm_flutter_app/pages/qr_code/report/qr_code_report_controller.dart';
import 'package:atm_flutter_app/pages/qr_code/report_details/qr_code_report_summary_binding.dart';
import 'package:atm_flutter_app/pages/qr_code/report_details/qr_code_report_summary_page.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/card_widget/qr_report_card_widget.dart';
import 'package:atm_flutter_app/widgets/card_widget/total_qr_count_summary_card_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../widgets/button_widget/icon_button_widget.dart';

class QRCodeReportPage extends GetView<QRCodeReportController> {
  QRCodeReportPage({Key? key}) : super(key: key);

  DateTime firstDay = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: NestedScrollView(
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
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                          fontSize: 14,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!,
                                width: 1),
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color!,
                      ),
                    ),
                  ),
                  leading: IconButtonWidget(
                    icon: Icons.arrow_back_ios,
                    iconSize: 25,
                    iconColor: Theme.of(context).textTheme.bodyText1!.color!,
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
                            'qr_report'.tr,
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
                                          const EdgeInsets.only(left: 35.0),
                                      child: TextWidget(
                                        align: TextAlign.left,
                                        text: 'from_date'.tr,
                                        textColor: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!,
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: TextWidget(
                                      align: TextAlign.left,
                                      text: 'to_date'.tr,
                                      textColor: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
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
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!,
                                      ),
                                      decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!,
                                              width: 1),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!,
                                              width: 1),
                                        ),
                                      ),
                                      onChanged: (val) {
                                        controller.fromDate.value = val;
                                        controller.setDate();
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 35,
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
                                            .color!,
                                      ),
                                      decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!,
                                              width: 1),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color!,
                                              width: 1),
                                        ),
                                      ),
                                      onChanged: (val) {
                                        controller.toDate.value = val;
                                        controller.setDate();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            ];
          },
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: AppColors.reportBg,
              ),
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => TotalQRCountSummaryCardWidget(
                            transaction: controller.transaction.value),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35.0),
                            topRight: Radius.circular(35.0)),
                      ),
                      margin: const EdgeInsets.only(
                          left: 3.0, right: 3.0, top: 5.0),
                      child: Obx(
                        () => controller.reportList.isEmpty
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
                                  return QRReportCardWidget(
                                    title:
                                        controller.reportList[index].payerName,
                                    status: controller.reportList[index].status
                                        .toString(),
                                    transactionNo: controller
                                        .reportList[index].transactionId
                                        .toString(),
                                    transactionDate: DateFormat('dd-MM-yyyy')
                                        .format(DateTime.parse(controller
                                            .reportList[index].transactionDate
                                            .toString()))
                                        .toString(),
                                    amount: controller.reportList[index].amount
                                        .toString(),
                                    onTap: () {
                                      Get.to(() => QRCodeReportSummaryPage(),
                                          arguments: {
                                            AppStrings.txtTransactionId:
                                                controller.reportList[index]
                                                    .transactionId
                                                    .toString(),
                                            AppStrings.txtAmount: controller
                                                .reportList[index].amount
                                                .toString(),
                                            AppStrings.txtName: controller
                                                .reportList[index].payerName
                                                .toString(),
                                            AppStrings.txtInvoiceNo: controller
                                                .reportList[index].invoiceNo
                                                .toString(),
                                            AppStrings.txtInvoiceName:
                                                controller.reportList[index]
                                                    .invoiceName
                                                    .toString(),
                                            AppStrings.txtInvoiceDate:
                                                controller.reportList[index]
                                                    .invoiceDate
                                                    .toString(),
                                            AppStrings.txtStatus: controller
                                                .reportList[index].status
                                                .toString(),
                                            AppStrings.txtGST: controller
                                                .reportList[index].gst
                                                .toString(),
                                            AppStrings.txtGSTIn: controller
                                                .reportList[index].gstIn
                                                .toString(),
                                            AppStrings.txtCESS: controller
                                                .reportList[index].cess
                                                .toString(),
                                            AppStrings.txtCGSt: controller
                                                .reportList[index].cgst
                                                .toString(),
                                            AppStrings.txtSGST: controller
                                                .reportList[index].sgst
                                                .toString(),
                                            AppStrings.txtGSTIncentive:
                                                controller.reportList[index]
                                                    .gstIncentive
                                                    .toString(),
                                            AppStrings.txtIGST: controller
                                                .reportList[index].igst
                                                .toString(),
                                            AppStrings.txtGSTPCT: controller
                                                .reportList[index].gstPct
                                                .toString(),
                                            'home': false,
                                          },
                                          binding:
                                              QRCodeReportSummaryBinding());
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
