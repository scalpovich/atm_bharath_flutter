import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';

class SettingsListTileWidget extends StatelessWidget {
  const SettingsListTileWidget(
      {Key? key, required this.leadingIcon, required this.title, this.onTap})
      : super(key: key);

  final IconData leadingIcon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 2,
          child: ListTile(
            leading: Icon(
              leadingIcon,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
            title: TextWidget(
              text: title,
              textColor: Theme.of(context).primaryColor,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            onTap: onTap,
          )),
    );
  }
}
