import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget(
      {Key? key,
      required this.icon,
      required this.iconSize,
      this.iconColor,
      this.onTap})
      : super(key: key);

  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: iconSize,
          color: iconColor,
          // )),
        ));
  }
}
