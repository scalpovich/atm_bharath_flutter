import 'dart:math';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/widgets/card_widget/status_card_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportCardWidget extends StatelessWidget {
  const ReportCardWidget(
      {Key? key,
      required this.status,
      required this.transactionNo,
      required this.transactionDate,
      required this.amount,
      required this.mode,
      this.title,
      this.text,
      this.onTap})
      : super(key: key);

  final String status;
  final String transactionNo;
  final String transactionDate;
  final String amount;
  final String? title;
  final String? text;
  final VoidCallback? onTap;
  final String mode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Theme.of(context).primaryColor, width: 0.5)),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                  ),
                  child:
                       TextWidget(text: 'NA', textColor: Theme.of(context).textTheme.subtitle1!.color!),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: title != null
                                ? TextWidget(
                                    align: TextAlign.left,
                                    text: title!,
                                    textColor: Theme.of(context).textTheme.subtitle1!.color!)
                                : Container(),
                          ),
                          Expanded(
                            flex: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: AppColors.blue)),
                              child: TextWidget(
                                  text: mode, textColor: AppColors.blue),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  TextWidget(
                                    text: 'transac_no'.tr,
                                    textColor: AppColors.grey,
                                    textSize: 12,
                                  ),
                                  TextWidget(
                                    text: transactionNo,
                                    textColor: Theme.of(context).textTheme.subtitle1!.color!,
                                    textSize: 12,
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  TextWidget(
                                    text: 'transac_date'.tr,
                                    textColor: AppColors.grey,
                                    textSize: 12,
                                  ),
                                  TextWidget(
                                      text: transactionDate,
                                      textSize: 12,
                                      textColor: Theme.of(context).textTheme.subtitle1!.color!),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  TextWidget(
                                    text: 'amount'.tr,
                                    textColor: AppColors.grey,
                                    textSize: 12,
                                  ),
                                  TextWidget(
                                    text: amount,
                                    textColor: Theme.of(context).textTheme.subtitle1!.color!,
                                    textSize: 12,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextWidget(
                                  text: text!, textColor: Theme.of(context).textTheme.subtitle1!.color!)),
                          Expanded(
                              flex: 0, child: StatusCardWidget(status: status))
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
