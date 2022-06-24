import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    Key? key,
    required this.url,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  final String url;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  value: isChecked,
                  onChanged: onChanged,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                url,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto'),
                maxLines: 2,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
