import 'package:atm_flutter_app/widgets/text_widget/bbps_row_text_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BBPSReportDetailsCardWidget extends StatelessWidget {
  const BBPSReportDetailsCardWidget(
      {Key? key,
      this.status,
      this.senderName,
      this.senderMobile,
      this.parameterValue,
      this.billAmount,
      this.bbpsRefNo,
      this.billerName,
      this.billerId,
      this.billDate,
      this.totalAmount,
      this.convFee,
      this.paymentId,
      this.parameterName,
      this.paymentChannel,
      this.paymentMode})
      : super(key: key);

  final String? senderName;
  final String? senderMobile;
  final String? parameterValue;
  final String? parameterName;
  final String? bbpsRefNo;
  final String? billerName;
  final String? billerId;
  final String? billDate;
  final String? billAmount;
  final String? convFee;
  final String? totalAmount;
  final String? paymentChannel;
  final String? paymentId;
  final String? paymentMode;
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
            padding: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Theme.of(context).textTheme.bodyText1!.color!),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BBPSRowTextWidget(
                    text1: 'payment_id'.tr,
                    text2: paymentId,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, left: 8.0, right: 8.0, bottom: 8.0),
                  child: BBPSRowTextWidget(
                    text1: 'sender_name'.tr,
                    text2: senderName,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'sender_mobile'.tr,
                      text2: senderMobile,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: parameterName.toString(),
                      text2: parameterValue.toString(),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'bbps_ref_no'.tr,
                      text2: bbpsRefNo,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'biller_name'.tr,
                      text2: billerName,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'biller_id'.tr,
                      text2: billerId,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'bill_date'.tr,
                      text2: billDate,
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BBPSRowTextWidget(
                      text1: 'bill_amount'.tr,
                      text2: billAmount,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BBPSRowTextWidget(
                    text1: 'conv_fee'.tr,
                    text2: convFee,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BBPSRowTextWidget(
                    text1: 'total_amount'.tr,
                    text2: totalAmount,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BBPSRowTextWidget(
                    text1: 'payment_channel'.tr,
                    text2: paymentChannel,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BBPSRowTextWidget(
                    text1: 'payment_mode'.tr,
                    text2: paymentMode,
                  ),
                )
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
            color: Colors.white,
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2.5,
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
                      child: status == 'SUCCESS'
                          ? Icon(
                              Icons.check,
                              size: 35,
                              color: Theme.of(context).primaryColor,
                            )
                          : status == 'FAILED'
                              ? Icon(
                                  Icons.clear,
                                  size: 35,
                                  color: Theme.of(context).primaryColor,
                                )
                              : SizedBox(
                                  height: 33,
                                  width: 33,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
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
}
