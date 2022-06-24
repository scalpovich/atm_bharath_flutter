import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.text,
      required this.textColor,
      this.textSize,
      this.textStyle,
      this.textFont,
      this.align,
      this.lines})
      : super(key: key);

  final String text;
  final Color textColor;
  final double? textSize;
  final FontWeight? textStyle;
  final String? textFont;
  final TextAlign? align;
  final int? lines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines ?? 10,
      softWrap: true,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontFamily: textFont,
        fontWeight: textStyle,
      ),
    );
  }
}
