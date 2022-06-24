import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalBBPSCountSummaryCardWidget extends StatelessWidget {
  const TotalBBPSCountSummaryCardWidget(
      {Key? key, required this.convFee, required this.transaction})
      : super(key: key);

  final double convFee;
  final double transaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                  child: Column(
                children: [
                  Text(
                    'conv_fee'.tr,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.subtitle1!.color!),
                  ),
                  Text(
                    convFee.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.subtitle1!.color!),
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 0,
              child: VerticalDivider(
                thickness: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                  child: Column(
                children: [
                  Text(
                    'total_bbps_transaction'.tr,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.subtitle1!.color!),
                  ),
                  Text(
                    transaction.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.subtitle1!.color!),
                  ),
                ],
              )),
            ),
          ],
        ),
      ]),
    );
  }
}
