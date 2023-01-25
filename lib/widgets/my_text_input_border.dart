// import '../my_services.dart';

// class MyTextInputBorder extends StatelessWidget {
//   const MyTextInputBorder({
//     Key? key,
//     this.labelText,
//     this.labelStyle,
//     required this.child,
//     this.height,
//     this.labelMargin = const EdgeInsets.symmetric(horizontal: 25),
//     this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//   }) : super(key: key);

//   final Widget child;
//   final double? height;
//   final EdgeInsetsGeometry? labelMargin;
//   final EdgeInsetsGeometry? padding;
//   final String? labelText;
//   final TextStyle? labelStyle;

//   // final String? value;
//   // final FormFieldValidator<String>? validator;
//   // final bool isPassword;
//   // final String? prefixText;
//   // final String? helperText;
//   // final Widget? suffixIcon;
//   // final Widget? prefixIcon;
//   // final ValueChanged<String>? onChanged;
//   // final TextDirection? textDirection;
//   // final TextInputAction? textInputAction;
//   // final TextInputType? keyboardType;
//   // final BorderRadius? borderRadius;
//   // final int maxLines;
//   // final int? length;
//   // final bool digitsOnly;
//   // final TextEditingController? controller;
//   // final FocusNode? focusNode;
//   // final Function(String value)? onFieldSubmitted;
//   // final EdgeInsetsGeometry? contentPadding;
//   // final TextStyle? style;
//   // final TextStyle? floatingLabelStyle;
//   // final StrutStyle? strutStyle;
//   // final InputBorder? border;

//   // Positioned buildLabel(String label, BuildContext context) {
//   //   return Positioned(
//   //     top: -12,
//   //     child: Container(
//   //       margin: labelMargin,
//   //       padding: const EdgeInsets.symmetric(horizontal: 5),
//   //       color: getTheme(context).scaffoldBackgroundColor,
//   //       child: Text(
//   //         label,
//   //         style: getTextTheme(context).bodySmall,
//   //       ),
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return buildStackField(context);
//   }

//   MyText buildLabel() => MyText(labelText, bold: true, margin: const EdgeInsets.symmetric(horizontal: 15));

//   Widget buildStackField(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildLabel(),
//         Container(
//           height: height,
//           width: double.infinity,
//           padding: padding,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade500, width: 0.8),
//             borderRadius: ServiceTheme.borderRadius,
//           ),
//           child: child,
//         ),
//         // buildLabel(labelText ?? '', context),
//       ],
//     );
//   }
// }
