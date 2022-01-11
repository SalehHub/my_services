import '../my_services.dart';

class MyTextInput extends StatelessWidget {
  const MyTextInput({
    Key? key,
    this.value,
    this.validator,
    this.labelText,
    this.helperText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.textDirection,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.borderRadius,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.done,
    this.margin = const EdgeInsets.only(top: 5),
    this.contentPadding,
    this.labelStyle,
    this.floatingLabelStyle,
    this.strutStyle,
    this.style,
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
  final BorderRadius? borderRadius;
  final int maxLines;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final StrutStyle? strutStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextFormField(
        autocorrect: !isPassword,
        enableSuggestions: !isPassword,
        controller: controller ?? (value != null ? TextEditingController(text: value) : null),
        validator: validator,
        textDirection: textDirection,
        obscureText: isPassword,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        maxLines: maxLines,
        strutStyle: strutStyle ?? const StrutStyle(height: 2.1),
        style: style,
        textAlignVertical: maxLines == 1 ? TextAlignVertical.center : TextAlignVertical.top,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelStyle: labelStyle,
          floatingLabelStyle: floatingLabelStyle,
          labelText: labelText,
          helperText: helperText,
          contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(10, 10, 10, 10),
          suffixIcon: suffixIcon,
          prefixIcon: maxLines == 1
              ? prefixIcon
              : Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Align(
                    alignment: Alignment.topCenter,
                    widthFactor: 1.0,
                    heightFactor: 10.0,
                    child: prefixIcon,
                  ),
                ),
          border: OutlineInputBorder(borderRadius: borderRadius ?? ServiceTheme.borderRadius),
        ),
        onChanged: onChanged,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
