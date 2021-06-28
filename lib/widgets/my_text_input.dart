import 'package:flutter/material.dart';

import '../service_theme.dart';

class MyTextInput extends StatelessWidget {
  const MyTextInput({
    Key? key,
    this.value,
    this.validator,
    this.isPassword = false,
    this.labelText,
    this.helperText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.textDirection,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    this.radius = 10,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  final String? value;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final String? labelText;
  final String? helperText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final double radius;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? (value != null ? TextEditingController(text: value) : null),
      enableSuggestions: !isPassword,
      validator: validator,
      textDirection: textDirection,
      obscureText: isPassword,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: getTextTheme(context).bodyText1?.copyWith(height: 2.5),
      decoration: InputDecoration(
        labelStyle: getTextTheme(context).bodyText2,
        labelText: labelText,
        helperText: helperText,
        contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      onChanged: onChanged,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
