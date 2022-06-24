import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget(
      {Key? key,
      required this.hint,
      required TextEditingController controller,
      this.text,
      this.align,
      this.containerColor,
      this.rounded})
      : _controller = controller,
        super(key: key);

  final String hint;
  final TextEditingController _controller;
  final text;
  final TextAlign? align;
  final double? rounded;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(rounded ?? 0),
      ),
      child: TextField(
        decoration: InputDecoration(
            suffixIcon:  Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            hintText: hint,
            hintStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(rounded ?? 0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(rounded ?? 0)),
            focusColor: Theme.of(context).primaryColor
            // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: colours.text_color)),
            ),
        controller: _controller,
        keyboardType: TextInputType.text,
        cursorColor: Theme.of(context).textTheme.subtitle1!.color!,
        style:  TextStyle(color: Theme.of(context).textTheme.subtitle1!.color!),
      ),
    );
  }
}
