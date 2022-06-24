import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalCountSummaryCardWidget extends StatelessWidget {
  const TotalCountSummaryCardWidget(
      {Key? key,
      required this.commission,
      required this.fee,
      required this.walletRecharge,
      required this.transaction})
      : super(key: key);

  final double commission;
  final double fee;
  final double walletRecharge;
  final double transaction;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                    child: Column(
                  children: [
                    Text(
                      'total_commission'.tr,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    Text(
                      commission.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
                      'total_fee'.tr,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    Text(
                      fee.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                  ],
                )),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Theme.of(context).primaryColor,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                    child: Column(
                  children: [
                    Text(
                      'wallet_recharge'.tr,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    Text(
                      walletRecharge.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
                      'total_transactions'.tr,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                    Text(
                      transaction.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.subtitle1!.color!),
                    ),
                  ],
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
