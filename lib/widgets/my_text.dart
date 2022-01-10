import '../my_services.dart';

class MyText extends StatelessWidget {
  const MyText(this.text,
      {Key? key, this.margin = EdgeInsets.zero, this.style, this.bold = false, this.textAlign, this.maxLines, this.fontSize, this.color, this.shadows})
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

  @override
  Widget build(BuildContext context) {
    TextStyle? _textStyle = style ?? getTextTheme(context).bodyText1;
    if (bold) {
      _textStyle = _textStyle?.copyWith(fontWeight: FontWeight.bold);
    }
    if (color != null) {
      _textStyle = _textStyle?.copyWith(color: color);
    }
    if (shadows != null) {
      _textStyle = _textStyle?.copyWith(shadows: shadows);
    }

    return Padding(
      padding: margin,
      child: Text(
        text ?? '',
        textAlign: textAlign,
        maxLines: maxLines,
        textDirection: Helpers.getTextDirection(text ?? ''),
        style: _textStyle,
      ),
    );
  }
}
