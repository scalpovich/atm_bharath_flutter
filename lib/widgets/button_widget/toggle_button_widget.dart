// ignore_for_file: must_be_immutable

import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_controller.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleButtonWidget extends StatelessWidget {
  ToggleButtonWidget(
      {Key? key,
      required this.onTap,
      required this.impsValue,
      required this.neftValue,
      required this.rtgsValue})
      : super(key: key);

  final Function onTap;
  final bool impsValue;
  final bool neftValue;
  final bool rtgsValue;

  final MoneyTransferController moneyTransferController =
      MoneyTransferController();

  // late final bool isToggled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: AppStrings.txtIMPS,
          textColor: Theme.of(context).textTheme.subtitle1!.color!,
          textSize: 12.0,
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Switch(
                activeColor: Theme.of(context).primaryColor,
                value: impsValue,
                onChanged: (value) {
                  onTap('IMPS', value);
                })),
        TextWidget(
          text: AppStrings.txtNEFT,
          textColor: Theme.of(context).textTheme.subtitle1!.color!,
          textSize: 12.0,
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Switch(
                activeColor: Theme.of(context).primaryColor,
                value: neftValue,
                onChanged: (value) {
                  onTap('NEFT', value);
                  moneyTransferController.isNEFT.value = value;
                })),
        TextWidget(
          text: AppStrings.txtRTGS,
          textColor: Theme.of(context).textTheme.subtitle1!.color!,
          textSize: 12.0,
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Switch(
                activeColor: Theme.of(context).primaryColor,
                value: rtgsValue,
                onChanged: (value) {
                  onTap('RTGS', value);
                  moneyTransferController.isRTGS.value = value;
                }))
      ],
    );
  }
}
