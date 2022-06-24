import 'package:atm_flutter_app/widgets/text_widget/row_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../text_widget/text_widget.dart';

class MoneyTransferReportDetailsCard extends StatelessWidget {
  const MoneyTransferReportDetailsCard(
      {Key? key,
      this.senderName,
      this.senderMobile,
      this.benefAccNo,
      this.ifscCode,
      this.transactionNo,
      this.transactionDate,
      this.transferMode,
      this.fee,
      this.status})
      : super(key: key);

  final String? senderName;
  final String? senderMobile;
  final String? benefAccNo;
  final String? ifscCode;
  final String? transactionNo;
  final String? transactionDate;
  final String? transferMode;
  final String? fee;
  final String? status;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Theme.of(context).textTheme.bodyText1!.color!),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, left: 8.0, right: 8.0, bottom: 8.0),
                  child: RowTextWidget(
                      textfield: 'sender_name'.tr,
                      text: senderName!,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTextWidget(
                      textfield: 'sender_mobile'.tr,
                      text: senderMobile!,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTextWidget(
                      textfield: 'benef_acc_no'.tr,
                      text: benefAccNo!,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTextWidget(
                      textfield: 'ifsc_code'.tr,
                      text: ifscCode!,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTextWidget(
                      textfield: 'transac_no'.tr,
                      text: transactionNo!,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTextWidget(
                      textfield: 'transac_date'.tr,
                      text: transactionDate!,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTextWidget(
                      textfield: 'transfer_mode'.tr,
                      text: transferMode!,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowTextWidget(
                      textfield: 'fee'.tr,
                      text: fee!,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!),
                ),
                // Padding(
              ],
            ),
          ),
        ),
        ClipRect(
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(55),
            ),
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      borderRadius: BorderRadius.circular(55),
                      // border: Border.all(color: AppColors.red, width: 2),
                    ),
                    child: status == 'Success'
                        ? Icon(
                            Icons.check,
                            size: 35,
                            color: Theme.of(context).primaryColor,
                          )
                        : status == 'Failed'
                            ? Icon(
                                Icons.clear,
                                size: 35,
                                color: Theme.of(context).primaryColor,
                              )
                            : SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
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
      ],
    );
  }
}
