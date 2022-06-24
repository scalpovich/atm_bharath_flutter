// ignore_for_file: must_be_immutable

import 'package:atm_flutter_app/helper/log.dart';
import 'package:atm_flutter_app/model/money_transfer/purpose.dart';
import 'package:atm_flutter_app/pages/money_transfer/add_transaction/money_transfer_controller.dart';
import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MTDropDownButtonWidget extends StatelessWidget {
  MTDropDownButtonWidget(
      {Key? key,
      required this.itemList,
      this.purposeList,
      this.value,
      this.textColor,
      this.textFontSize})
      : super(key: key);

  final List<String> itemList;
  final List<Purpose>? purposeList;
  final String? value;
  final double? textFontSize;
  final Color? textColor;
  MoneyTransferController moneyTransferController = MoneyTransferController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // width: 20,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
      ),
      child: Obx(
        () => DropdownButton<String>(
            value: moneyTransferController.selectedPayment.value,
            icon: const Padding(
              padding: EdgeInsets.only(top: 0.0, left: 70.0),
              child: Icon(Icons.arrow_drop_down),
            ),
            iconSize: 24,
            style: TextStyle(color: textColor, fontSize: textFontSize),
            underline: const SizedBox.shrink(),
            items: itemList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color!),
                ),
              );
            }).toList(),
            onChanged: (data) {
              moneyTransferController.selectedPayment.value == data.toString();
              int index = purposeList!.indexWhere((element) =>
                  (element.mtpsPurposename.toString().toLowerCase() ==
                      data.toString().toLowerCase()));
              moneyTransferController.selectedPaymentMode.value =
                  purposeList![index].mtpsSysId.toString();
              Log().logs('selected type',
                  moneyTransferController.selectedPaymentMode.value.toString());
            }),
      ),
    );
  }
}
