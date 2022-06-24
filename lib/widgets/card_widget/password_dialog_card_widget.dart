import 'package:flutter/material.dart';

import '../text_widget/text_widget.dart';

class PasswordDialogCardWidget extends StatelessWidget {
  const PasswordDialogCardWidget({Key? key, this.text, required this.onTap})
      : super(key: key);

  final Function onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 50,
        width: 50,
        child: Card(
          elevation: 3,
          child: Center(
              child: TextWidget(
                  text: text!, textColor: Theme.of(context).primaryColor)),
        ),
      ),
      onTap: () {
        onTap(text);
      },
    );
  }
}
