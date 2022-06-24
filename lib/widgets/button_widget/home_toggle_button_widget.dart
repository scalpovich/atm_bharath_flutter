import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';
import '../text_widget/text_widget.dart';

class HomeToggleButtonWidget extends StatefulWidget {
  const HomeToggleButtonWidget(
      {Key? key, required this.value, required this.onItemTap})
      : super(key: key);

  final bool value;
  final Function onItemTap;

  @override
  State<HomeToggleButtonWidget> createState() => _HomeToggleButtonWidgetState();
}

class _HomeToggleButtonWidgetState extends State<HomeToggleButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         TextWidget(
          text: AppStrings.txtDuty,
          textColor: Theme.of(context).textTheme.subtitle1!.color!,
          textSize: 12.0,
        ),
        Switch(
            value: widget.value,
            onChanged: (value) {
              widget.onItemTap(value);
            }),
      ],
    );
  }
}
