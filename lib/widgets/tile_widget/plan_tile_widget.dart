import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';

class PlanTileWidget extends StatelessWidget {
  const PlanTileWidget({
    Key? key,
    required this.days,
    required this.amount,
    required this.description,
  }) : super(key: key);

  final String days;
  final String amount;
  final String description;

  @override
  Widget build(BuildContext context) {
    String price = amount.replaceAll('.00', '');
    return Container(
      color: Theme.of(context).textTheme.bodyText1!.color!,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: const ImageIcon(
                            AssetImage(
                                AppDrawable.filePath + AppDrawable.rupeeIcon),
                            size: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: TextWidget(
                          text: price,
                          textColor:
                              Theme.of(context).textTheme.subtitle1!.color!,
                          textSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextWidget(
                    text: AppStrings.txtValidity + '-' + days + ' days',
                    textColor: Theme.of(context).textTheme.subtitle1!.color!,
                    align: TextAlign.right,
                    textSize: 16,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 0.5,
            color: AppColors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextWidget(
                text: description,
                textColor: Theme.of(context).textTheme.subtitle1!.color!,
                align: TextAlign.left,
                textSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
