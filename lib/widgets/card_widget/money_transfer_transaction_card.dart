import 'dart:math';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoneyTransferTransactionCard extends StatelessWidget {
  const MoneyTransferTransactionCard(
      {Key? key,
      required this.benefAccNo,
      required this.benefName,
      required this.mode,
      required this.transDate,
      required this.transNo})
      : super(key: key);

  final String benefAccNo;
  final String benefName;
  final String mode;
  final String transDate;
  final String transNo;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            shape: BoxShape.rectangle),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                ),
                child: TextWidget(
                    text: 'NA',
                    textColor: Theme.of(context).textTheme.subtitle1!.color!),
              ),
              flex: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: benefName, textColor: AppColors.grey),
                              TextWidget(
                                text: 'acc_no'.tr + benefAccNo,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .color!,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: AppColors.blue)),
                          child:
                              TextWidget(text: mode, textColor: AppColors.blue),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                              text: 'transac_no'.tr, textColor: AppColors.grey),
                          flex: 1,
                        ),
                        Expanded(
                          child: TextWidget(
                              text: 'transac_date'.tr,
                              textColor: AppColors.grey),
                          flex: 1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            text: transNo,
                            textColor:
                                Theme.of(context).textTheme.subtitle1!.color!,
                            textStyle: FontWeight.bold,
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: TextWidget(
                            text: transDate,
                            textColor:
                                Theme.of(context).textTheme.subtitle1!.color!,
                            textStyle: FontWeight.bold,
                          ),
                          flex: 1,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
