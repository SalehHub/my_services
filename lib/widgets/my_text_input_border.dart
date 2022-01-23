import '../my_services.dart';

class MyTextInputBorder extends StatelessWidget {
  const MyTextInputBorder({
    Key? key,
    // this.value,
    // this.validator,
    // this.prefixText,
    // this.helperText,
    // this.suffixIcon,
    // this.prefixIcon,
    // this.onChanged,
    // this.textDirection,
    // this.keyboardType,
    // this.controller,
    // this.focusNode,
    // this.onFieldSubmitted,
    // this.isPassword = false,
    // this.borderRadius,
    // this.maxLines = 1,
    // this.length,
    // this.digitsOnly = false,
    // this.textInputAction = TextInputAction.done,
    // this.contentPadding,
    // this.floatingLabelStyle,
    // this.strutStyle,
    // this.style,
    // this.border,
    //
    this.labelText,
    this.labelStyle,
    required this.child,
    this.height,
    this.labelMargin = const EdgeInsets.symmetric(horizontal: 25),
  }) : super(key: key);

  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? labelMargin;
  final String? labelText;
  final TextStyle? labelStyle;

  // final String? value;
  // final FormFieldValidator<String>? validator;
  // final bool isPassword;
  // final String? prefixText;
  // final String? helperText;
  // final Widget? suffixIcon;
  // final Widget? prefixIcon;
  // final ValueChanged<String>? onChanged;
  // final TextDirection? textDirection;
  // final TextInputAction? textInputAction;
  // final TextInputType? keyboardType;
  // final BorderRadius? borderRadius;
  // final int maxLines;
  // final int? length;
  // final bool digitsOnly;
  // final TextEditingController? controller;
  // final FocusNode? focusNode;
  // final Function(String value)? onFieldSubmitted;
  // final EdgeInsetsGeometry? contentPadding;
  // final TextStyle? style;
  // final TextStyle? floatingLabelStyle;
  // final StrutStyle? strutStyle;
  // final InputBorder? border;

  Positioned buildLabel(String label, BuildContext context) {
    return Positioned(
      top: -12,
      child: Container(
        margin: labelMargin,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        color: getTheme(context).scaffoldBackgroundColor,
        child: Text(
          label,
          style: getTextTheme(context).caption,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildStackField(context);
  }

  Stack buildStackField(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500, width: 1),
            borderRadius: ServiceTheme.borderRadius,
          ),
          child: child,
        ),
        buildLabel(labelText ?? '', context),
      ],
    );
  }
}
