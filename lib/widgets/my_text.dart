import '../my_services.dart';

class MyText extends StatelessWidget {
  const MyText(
    this.text, {
    super.key,
    this.margin = EdgeInsets.zero,
    this.style,
    this.bold = false,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.fontSize,
    this.color,
    this.shadows,
    this.overflow,
  });
  final String? text;
  final bool bold;
  final TextStyle? style;
  final EdgeInsetsGeometry margin;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final double? fontSize;
  final Color? color;
  final List<Shadow>? shadows;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style;

    TextStyle textStyle = style ?? defaultTextStyle;

    if (bold) {
      textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
    }

    // if (color != null) {
    textStyle = textStyle.copyWith(color: color ?? defaultTextStyle.color);
    // }

    if (shadows != null) {
      textStyle = textStyle.copyWith(shadows: shadows);
    }
    if (fontSize != null) {
      textStyle = textStyle.copyWith(fontSize: fontSize);
    }

    return Padding(
      padding: margin,
      child: Text(
        text ?? '',
        textAlign: textAlign ?? MyServices.helpers.getTextAlignByLang(context),
        maxLines: maxLines,
        textDirection: textDirection ?? MyServices.helpers.getTextDirection(text ?? ''),
        style: textStyle,
        overflow: overflow,
      ),
    );
  }
}

// class MyText2 extends Text {
//   const MyText2(
//     super.data, {
//     super.key,
//     super.style,
//     super.textAlign,
//     super.maxLines,
//     super.overflow,
//     this.bold = false,
//     this.margin = EdgeInsets.zero,
//     this.fontSize,
//     this.color,
//     this.shadows,
//   });

//   final bool bold;
//   final EdgeInsetsGeometry margin;
//   final double? fontSize;
//   final Color? color;
//   final List<Shadow>? shadows;

//   @override
//   Widget build(BuildContext context) {

//     String text = super.data ?? "";

//     TextStyle textStyle = super.style ?? DefaultTextStyle.of(context).style;

//     if (bold) {
//       textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
//     }
//     if (color != null) {
//       textStyle = textStyle.copyWith(color: color);
//     }
//     if (shadows != null) {
//       textStyle = textStyle.copyWith(shadows: shadows);
//     }
//     if (fontSize != null) {
//       textStyle = textStyle.copyWith(fontSize: fontSize);
//     }

//     return Padding(
//       padding: margin,
//       child: Text(
//         text,
//         textAlign: textAlign ?? MyServices.helpers.getTextAlignByLang(context),
//         maxLines: maxLines,
//         textDirection: MyServices.helpers.getTextDirection(text),
//         style: textStyle,
//         overflow: overflow,
//       ),
//     );
//   }
// }
