import '../my_services.dart';

class MyTextInput extends StatelessWidget {
  const MyTextInput({
    Key? key,
    this.value,
    this.validator,
    this.prefixText,
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
    this.length,
    this.digitsOnly = false,
    this.textInputAction = TextInputAction.done,
    this.margin = const EdgeInsets.only(top: 5),
    this.contentPadding,
    this.labelStyle,
    this.floatingLabelStyle,
    this.strutStyle,
    this.style,
    this.border,
    this.isDropDown = false,
    this.items = const [],
    this.widget,
  }) : super(key: key);

  final bool isDropDown;
  final String? value;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final String? prefixText;
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
  final int? length;
  final bool digitsOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final StrutStyle? strutStyle;
  final InputBorder? border;
  final List<MyDropdownMenuItemData> items;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    // return buildStackField(context);

    if (isDropDown) {
      return Padding(
        padding: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel(context),
            DropdownButtonFormField<String>(
              validator: validator,
              value: value,
              onChanged: (String? v) {
                if (v != null) {
                  if (onChanged != null) {
                    onChanged!(v);
                  }
                }
              },
              items: items.map((e) => DropdownMenuItem(child: MyText(e.text), value: e.value)).toList(),
              decoration: buildMyInputDecoration(),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel(context),
          if (widget != null)
            Container(
              // height: height,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500, width: 0.8),
                borderRadius: ServiceTheme.borderRadius,
              ),
              child: widget!,
            )
          else
            Directionality(
              textDirection: textDirection ?? Directionality.of(context),
              child: TextFormField(
                autocorrect: !isPassword,
                enableSuggestions: !isPassword,
                controller: controller ?? (value != null ? TextEditingController(text: value) : null),
                validator: validator,
                textDirection: textDirection,
                obscureText: isPassword,
                textInputAction: textInputAction,
                keyboardType: keyboardType,
                inputFormatters: [
                  if (length != null) LengthLimitingTextInputFormatter(length),
                  if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
                ],
                maxLines: maxLines,
                strutStyle: strutStyle ?? const StrutStyle(height: 2.1),
                style: style,
                textAlignVertical: maxLines == 1 ? TextAlignVertical.center : TextAlignVertical.top,
                decoration: buildMyInputDecoration(),
                onChanged: (String v) {
                  if (onChanged != null) {
                    onChanged!(v);
                  }
                },
                focusNode: focusNode,
                onFieldSubmitted: onFieldSubmitted,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildLabel(BuildContext context) {
    print(Directionality.of(context));
    return MyText(
      labelText,
      bold: true,
      margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }

  InputDecoration buildMyInputDecoration() {
    return InputDecoration(
      prefixText: prefixText,
      alignLabelWithHint: true,
      // labelStyle: labelStyle,
      floatingLabelStyle: floatingLabelStyle,
      // labelText: labelText,
      helperText: helperText,
      contentPadding: contentPadding ?? (isDropDown ? const EdgeInsets.fromLTRB(10, 15, 10, 15) : const EdgeInsets.fromLTRB(15, 10, 10, 10)),
      suffixIcon: suffixIcon,
      // prefixIcon: prefixIcon,
      prefixIcon: buildPrefixIcon(),
      border: border ?? OutlineInputBorder(borderRadius: borderRadius ?? ServiceTheme.borderRadius),
    );
  }

  Widget? buildPrefixIcon() {
    if (prefixIcon == null) {
      return null;
    } else if (maxLines == 1) {
      return prefixIcon;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Align(
        alignment: Alignment.topCenter,
        widthFactor: 1.0,
        heightFactor: 10.0,
        child: prefixIcon,
      ),
    );
  }

// Stack buildStackField(BuildContext context) {
//   return Stack(
//     clipBehavior: Clip.none,
//     children: [
//       Container(
//         height: 55.0 * maxLines,
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//         decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade500, width: 1), borderRadius: ServiceTheme.borderRadius),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             prefixIcon ?? const SizedBox(),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 1),
//                 child: TextFormField(
//                   controller: controller,
//                   initialValue: value,
//                   maxLines: maxLines,
//                   onChanged: onChanged,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//             suffixIcon ?? const SizedBox(),
//           ],
//         ),
//       ),
//       buildLabel(labelText ?? '', context),
//     ],
//   );
// }
}

class MyDropdownMenuItemData {
  final String text;
  final String value;

  const MyDropdownMenuItemData(this.text, this.value);
}
