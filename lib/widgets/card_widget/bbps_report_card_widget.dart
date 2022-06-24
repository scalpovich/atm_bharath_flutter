import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/card_widget/status_card_widget.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BBPSReportCardWidget extends StatelessWidget {
  const BBPSReportCardWidget(
      {Key? key,
      required this.status,
      required this.category,
      required this.transactionDate,
      required this.amount,
      required this.mode,
      this.title,
      this.image,
      this.onTap})
      : super(key: key);

  final String status;
  final String category;
  final String transactionDate;
  final String amount;
  final String? title;
  final String? image;
  final VoidCallback? onTap;
  final String mode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: image != null && image != ''
                        ? Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            // child: Image.network(
                            //   image!,
                            //   height: 50,
                            //   width: 50,
                            //   fit: BoxFit.contain,
                            // ),
                            child: Image.asset(
                              AppDrawable.filePath + image!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Theme.of(context).primaryColor,
                            ))),
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
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .color!)
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
                                  const TextWidget(
                                    text: AppStrings.txtCategory,
                                    textColor: AppColors.grey,
                                    textSize: 12,
                                  ),
                                  TextWidget(
                                    text: category,
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .color!,
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
                                      textColor: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .color!),
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
                                    textColor: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .color!,
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
                                  text: '',
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .color!)),
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
    );
  }
}
