import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalQRCountSummaryCardWidget extends StatelessWidget {
  const TotalQRCountSummaryCardWidget({Key? key, required this.transaction})
      : super(key: key);

  final double transaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(children: [
          TextWidget(
              text: 'Total QR Transaction',
              textStyle: FontWeight.bold,
              textColor: Theme.of(context).textTheme.subtitle1!.color!),
          TextWidget(
              textStyle: FontWeight.bold,
              text: 'rupee'.tr + transaction.toString(),
              textColor: Theme.of(context).textTheme.subtitle1!.color!)
        ]),
      ),
    );
  }
}
