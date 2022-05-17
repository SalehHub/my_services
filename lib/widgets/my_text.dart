import '../my_services.dart';

class MyText extends StatelessWidget {
  const MyText(
    this.text, {
    Key? key,
    this.margin = EdgeInsets.zero,
    this.style,
    this.bold = false,
    this.textAlign,
    this.maxLines,
    this.fontSize,
    this.color,
    this.shadows,
    this.overflow,
  }) : super(key: key);
  final String? text;
  final bool bold;
  final TextStyle? style;
  final EdgeInsetsGeometry margin;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? fontSize;
  final Color? color;
  final List<Shadow>? shadows;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = style ?? DefaultTextStyle.of(context).style;
    if (bold) {
      textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
    }
    if (color != null) {
      textStyle = textStyle.copyWith(color: color);
    }
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
        textDirection: MyServices.helpers.getTextDirection(text ?? ''),
        style: textStyle,
        overflow: overflow,
      ),
    );
  }
}

// class MyText2 extends Text {
//   MyText2(

//     String? text, {
//     Key? key,
//     this.margin = EdgeInsets.zero,
//     TextStyle? style,
//     bool? bold = false,
//     TextAlign? textAlign,
//     int? maxLines,
//     double? fontSize,
//     Color? color,
//     List<Shadow>? shadows,
//     TextOverflow? overflow,

//   }) : super(
//           text ?? "",
//           key: key,
//           maxLines: maxLines,
//           overflow: overflow,
//           textAlign: textAlign,
//           style: getStyle(style, bold, color, shadows, fontSize),
//         );

//   final EdgeInsetsGeometry? margin;

//   static TextStyle? getStyle(style, bold, color, shadows, fontSize) {
//     TextStyle? _textStyle = style ?? const TextStyle();
//     if (bold) {
//       _textStyle = _textStyle?.copyWith(fontWeight: FontWeight.bold);
//     }
//     if (color != null) {
//       _textStyle = _textStyle?.copyWith(color: color);
//     }
//     if (shadows != null) {
//       _textStyle = _textStyle?.copyWith(shadows: shadows);
//     }
//     if (fontSize != null) {
//       _textStyle = _textStyle?.copyWith(fontSize: fontSize);
//     }

//     return _textStyle;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (margin != null) {
//       return Padding(padding: margin!, child: super.build(context));
//     }
//     return super.build(context);
//   }

// }
