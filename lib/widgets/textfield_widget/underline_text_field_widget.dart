import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class UnderlineTextFieldWidget extends StatelessWidget {
  const UnderlineTextFieldWidget(
      {Key? key,
      required this.hint,
      required TextEditingController controller,
      required this.validate,
      required this.type,
      this.action,
      this.text,
      this.align,
      this.length,
      this.textCapital,
      this.border,
      this.textColor,
      this.errorText,
      this.labelText,
      this.autoFocus,
      required this.suffix,
      required this.enabled})
      : _controller = controller,
        super(key: key);

  final String hint;
  final TextEditingController _controller;
  final String? text;
  final TextAlign? align;
  final int? length;
  final bool validate;
  final String? errorText;
  final double? border;
  final Color? textColor;
  final bool enabled;
  final Widget suffix;
  final TextInputType type;
  final String? labelText;
  final TextInputAction? action;
  final TextCapitalization? textCapital;
  final bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus ?? false,
      // maxLength: length ?? 100,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 10.0, right: 5.0),
        counterText: '',
        labelText: labelText ?? '',
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: textColor ?? AppColors.grey,
        ),
        suffix: suffix,
        errorText: !validate ? errorText : null,
        // errorStyle: const TextStyle(height: 0),
        enabled: enabled,
        enabledBorder: UnderlineInputBorder(
            borderRadius: border != null
                ? BorderRadius.only(
                    topLeft: Radius.circular(border!),
                    bottomLeft: Radius.circular(border!))
                : BorderRadius.circular(5.0)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: border != null
                ? BorderRadius.only(
                    topLeft: Radius.circular(border!),
                    bottomLeft: Radius.circular(border!))
                : BorderRadius.circular(5.0)),
      ),
      controller: _controller,
      keyboardType: type,
      textAlign: align ?? TextAlign.start,
      textInputAction: action ?? TextInputAction.done,
      obscureText: hint == 'Password' ? true : false,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: textCapital ?? TextCapitalization.none,
      style: TextStyle(
        color: textColor ?? Theme.of(context).textTheme.subtitle1!.color,
        fontSize: 15.0,
      ),
    );
  }
}
