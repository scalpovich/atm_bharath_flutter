import 'package:atm_flutter_app/resources/app_drawables.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';

class BBPSCategoryCardWidget extends StatelessWidget {
  const BBPSCategoryCardWidget(
      {Key? key, required this.image, required this.title, this.padding})
      : super(key: key);

  final String image;
  final String title;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          height: 70,
          // width: 100,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(padding ?? 8.0),
                child: Image.asset(
                  AppDrawable.filePath + image,
                  fit: BoxFit.contain,
                  color: Theme.of(context).primaryColor,
                  height: 30,
                  width: 30,
                ),
              ),
              TextWidget(
                text: title,
                textColor: Theme.of(context).textTheme.subtitle1!.color!,
                textSize: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
