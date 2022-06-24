import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';

class RowTextWidget extends StatelessWidget {
  const RowTextWidget(
      {Key? key,
      required this.textfield,
      required this.text,
      required this.textColor})
      : super(key: key);

  final String textfield;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: TextWidget(
              text: textfield,
              textColor: textColor,
              align: TextAlign.left,
            )),
        Expanded(flex: 0, child: TextWidget(text: ' : ', textColor: textColor)),
        Expanded(
            flex: 1,
            child: TextWidget(
              text: text,
              textColor: textColor,
              align: TextAlign.left,
            )),
      ],
    );
  }
}
