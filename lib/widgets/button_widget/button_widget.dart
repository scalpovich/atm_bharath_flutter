import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.label,
      required this.width,
      required this.clicked,
      this.onTap,
      this.border,
      this.btnColor,
      this.labelColor,
      this.height,
      this.size})
      : super(key: key);

  final VoidCallback? onTap;
  final String label;
  final double width;
  final bool clicked;
  final double? border;
  final double? size;
  final Color? btnColor;
  final Color? labelColor;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: width,
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(width, height ?? 45),
            shape: RoundedRectangleBorder(
                borderRadius: border != null
                    ? BorderRadius.only(
                        topRight: Radius.circular(border!),
                        bottomRight: Radius.circular(border!))
                    : BorderRadius.circular(8.0)),
            primary: btnColor ?? Theme.of(context).textTheme.bodyText1!.color!,
          ),
          onPressed: onTap,
          child: clicked
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: labelColor ??
                        Theme.of(context).textTheme.bodyText1!.color!,
                    strokeWidth: 1.5,
                  ))
              : TextWidget(
                  text: label,
                  textColor: labelColor ??
                      Theme.of(context).textTheme.bodyText1!.color!,
                  textSize: size,
                ),
        ));
  }
}
