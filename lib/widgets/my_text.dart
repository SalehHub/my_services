import '../my_services.dart';

class MyText extends StatelessWidget {
  const MyText(this.text, {Key? key, this.margin = EdgeInsets.zero, this.style, this.bold = false, this.textAlign, this.maxLines, this.fontSize, this.color, this.shadows, this.overflow})
      : super(key: key);
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
    TextStyle? _textStyle = style ?? getTextTheme(context).button;
    if (bold) {
      _textStyle = _textStyle?.copyWith(fontWeight: FontWeight.bold);
    }
    if (color != null) {
      _textStyle = _textStyle?.copyWith(color: color);
    }
    if (shadows != null) {
      _textStyle = _textStyle?.copyWith(shadows: shadows);
    }
    if (fontSize != null) {
      _textStyle = _textStyle?.copyWith(fontSize: fontSize);
    }

    return Padding(
      padding: margin,
      child: Text(
        text ?? '',
        textAlign: textAlign ?? Helpers.getTextAlignByLang(context),
        maxLines: maxLines,
        textDirection: Helpers.getTextDirection(text ?? ''),
        style: _textStyle,
        overflow: overflow,
      ),
    );
  }
}
