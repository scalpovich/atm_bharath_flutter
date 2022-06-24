
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';


class LoginIconButtonWidget extends StatefulWidget {
  const LoginIconButtonWidget(
      {Key? key,
      required this.icon,
      required this.iconSize,
      required this.onTap,
      required this.selected,
      required this.userTypeText,
      this.iconColor,
      this.containerColor})
      : super(key: key);

  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final Function onTap;
  final Color? containerColor;
  final bool selected;
  final String userTypeText;

  @override
  State<LoginIconButtonWidget> createState() => _LoginIconButtonWidgetState();
}

class _LoginIconButtonWidgetState extends State<LoginIconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.5),
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          decoration: widget.selected
              ? BoxDecoration(
                  // color: containerColor,
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                )
              : BoxDecoration(
                  color: Theme.of(context).textTheme.bodyText1!.color!,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
          child: IconButton(
              onPressed: () =>
                  {widget.onTap(!widget.selected, widget.userTypeText)},
              icon: Icon(
                widget.icon,
                size: widget.iconSize,
                color: widget.selected
                    ? Theme.of(context).textTheme.bodyText1!.color!
                    : Theme.of(context).primaryColor,
              )),
        ),
        TextWidget(
            text: widget.userTypeText,
            textColor: Theme.of(context).textTheme.subtitle1!.color!)
      ],
    );
  }
}
