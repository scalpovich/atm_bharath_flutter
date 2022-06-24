import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_strings.dart';
import '../text_widget/bbps_row_text_widget.dart';
import '../text_widget/text_widget.dart';

class QRReportDetailsCardWidget extends StatelessWidget {
  QRReportDetailsCardWidget(
      {Key? key,
      required this.isExpanded,
      required this.onExpanded,
      this.status,
      this.amount,
      this.transDate,
      this.gstPct,
      this.gstIncentive,
      this.igst,
      this.sgst,
      this.cgst,
      this.cess,
      this.gstIn,
      this.gst,
      this.invoiceName,
      this.invoiceDate,
      this.invoiceNo,
      this.transId})
      : super(key: key);

  final String? amount;
  final String? invoiceDate;
  final String? invoiceNo;
  final String? invoiceName;
  final String? transId;
  final String? transDate;
  final String? gst;
  final String? gstIn;
  final String? cess;
  final String? cgst;
  final String? sgst;
  final String? igst;
  final String? gstIncentive;
  final String? gstPct;
  final String? status;
  String exTile = "GST";
  bool active = false;
  final Function onExpanded;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Theme.of(context).textTheme.bodyText1!.color!),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BBPSRowTextWidget(
                    text1: 'amount'.tr,
                    text2: amount,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
                  child: BBPSRowTextWidget(
                    text1: 'invoice_no'.tr,
                    text2: invoiceNo,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'invoice_date'.tr,
                      text2: invoiceDate,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'invoice_name'.tr,
                      text2: invoiceName,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'transac_no'.tr,
                      text2: transId,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'transac_date'.tr,
                      text2: transDate,
                    )),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                  child: ExpansionPanelList(
                    expansionCallback: (panelIndex, bool Expanded) {
                      exTile = 'GST';
                      active = isExpanded;
                      // isExpanded = !isExpanded;
                      onExpanded(!Expanded);
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, bool isExpanded) {
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.only(left: 60.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0)),
                            alignment: Alignment.center,
                            child: TextWidget(
                              text: 'gst_info'.tr,
                              textColor: Theme.of(context).primaryColor,
                              textSize: 15,
                            ),
                          );
                        },
                        body: expansionBody(context),
                        isExpanded: isExpanded,
                        canTapOnHeader: true,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ClipRect(
          child: Card(
            // margin: const EdgeInsets.symmetric(horizontal: 50),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(55),
            ),
            color: Colors.white,
            child: SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width / 2.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        borderRadius: BorderRadius.circular(55),
                        // border: Border.all(color: AppColors.red, width: 2),
                      ),
                      child: status == 'SUCCESS'
                          ? Icon(
                              Icons.check,
                              size: 35,
                              color: Theme.of(context).primaryColor,
                            )
                          : status == 'FAILED'
                              ? Icon(
                                  Icons.remove_outlined,
                                  size: 35,
                                  color: Theme.of(context).primaryColor,
                                )
                              : SizedBox(
                                  height: 33,
                                  width: 33,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )),
                  TextWidget(
                    text: status.toString(),
                    textColor: Theme.of(context).primaryColor,
                    textSize: 16,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget expansionBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: BBPSRowTextWidget(
                text1: AppStrings.txtGST,
                text2: gst,
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: BBPSRowTextWidget(
                text1: AppStrings.txtGSTIn,
                text2: gstIn,
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: BBPSRowTextWidget(
                text1: AppStrings.txtCESS,
                text2: cess,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BBPSRowTextWidget(
              text1: AppStrings.txtCGSt,
              text2: cgst,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BBPSRowTextWidget(
              text1: AppStrings.txtSGST,
              text2: sgst,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BBPSRowTextWidget(
              text1: AppStrings.txtIGST,
              text2: igst,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BBPSRowTextWidget(
              text1: AppStrings.txtGSTIncentive,
              text2: gstIncentive,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BBPSRowTextWidget(
              text1: AppStrings.txtGSTPCT,
              text2: gstPct,
            ),
          )
        ],
      ),
    );
  }
}
