import 'package:flutter/material.dart';

import '../text_widget/text_widget.dart';

class MoneyTransferAccountSearchCardWidget extends StatelessWidget {
  const MoneyTransferAccountSearchCardWidget(
      {Key? key,
      required this.text1,
      required this.text2,
      // required this.text3,
      required this.text4,
      required this.title1,
      required this.title2,
      // required this.title3,
      required this.title4,
      this.onTap})
      : super(key: key);

  final String title1;
  final String title2;
  // final String title3;
  final String title4;
  final String text1;
  final String text2;
  // final String text3;
  final String text4;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextWidget(
                      text: title1,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      textSize: 14,
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: TextWidget(
                      text: '-',
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      textSize: 14,
                      textStyle: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextWidget(
                      text: text1,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      textSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextWidget(
                      text: title2,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      textSize: 12,
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: TextWidget(
                      text: '-',
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      textSize: 14,
                      textStyle: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextWidget(
                      text: text2,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      textSize: 14,
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 1,
              //       child: TextWidget(
              //         text: title3,
              //         textColor: Theme.of(context).textTheme.subtitle1!.color!,
              //         textSize: 12,
              //       ),
              //     ),
              //     Expanded(
              //       flex: 0,
              //       child: TextWidget(
              //         text: '-',
              //         textColor: Theme.of(context).textTheme.subtitle1!.color!,
              //         textSize: 14,
              //         textStyle: FontWeight.bold,
              //       ),
              //     ),
              //     Expanded(
              //       flex: 1,
              //       child: TextWidget(
              //         text: text3,
              //         textColor: Theme.of(context).textTheme.subtitle1!.color!,
              //         textSize: 14,
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextWidget(
                      text: title4,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      textSize: 12,
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: TextWidget(
                      text: '-',
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      textSize: 14,
                      textStyle: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextWidget(
                      text: text4,
                      textColor: Theme.of(context).textTheme.subtitle1!.color!,
                      textSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
