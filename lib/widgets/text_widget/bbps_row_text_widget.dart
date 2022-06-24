import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';

class BBPSRowTextWidget extends StatelessWidget {
  const BBPSRowTextWidget(
      {Key? key, required this.text1, this.text2, this.value1, this.value2})
      : super(key: key);

  final String text1;
  final String? text2;
  final String? value1;
  final String? value2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextWidget(text: text1, textColor: Colors.grey),
              TextWidget(
                  text: text2 ?? '',
                  textColor: Theme.of(context).textTheme.subtitle1!.color!),
            ],
          ),
        ),
      ],
    );
  }
}
