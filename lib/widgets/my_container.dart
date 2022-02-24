import '../my_services.dart';

class MyContainer extends StatelessWidget {
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
  final double? minHeight;
  final double? maxHeight;
  final double? borderWidth;
  final Color? borderColor;
  final Color? bgColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final String? bgImageUrl;
  final String? bgImageBlurHash;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final double? bgImageOpacity;
  final double? elevation;
  final AlignmentGeometry? alignment;

  const MyContainer({
    Key? key,
    this.onTap,
    this.width,
    this.height,
    this.borderWidth,
    this.borderColor,
    this.bgColor,
    this.margin,
    this.padding,
    required this.child,
    this.gradient,
    this.bgImageUrl,
    this.borderRadius,
    this.bgImageOpacity,
    this.bgImageBlurHash,
    this.elevation,
    this.alignment,
    this.minHeight,
    this.maxHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  BoxConstraints? getBoxConstraints() {
    if (maxHeight == null && minHeight == null) {
      return null;
    }

    BoxConstraints boxConstraints = const BoxConstraints();
    if (maxHeight != null) {
      boxConstraints = boxConstraints.copyWith(maxHeight: maxHeight);
    }
    if (minHeight != null) {
      boxConstraints = boxConstraints.copyWith(minHeight: minHeight);
    }
    return boxConstraints;
  }

  Widget buildContainer() {
    Widget? image;

    if (bgImageUrl != null && bgImageUrl?.trim() != "") {
      image = MyLoadingImage(
        url: bgImageUrl!,
        // borderColor: Colors.green,
        // borderWidth: 1,
        useCacheImage: true,
        blurHash: bgImageBlurHash,
        // borderRadius: borderRadius,
        width: double.infinity,
        height: double.infinity,
      );

      if (bgImageOpacity != null) {
        image = Opacity(
          opacity: bgImageOpacity!,
          child: image,
        );
      }
    }

    Widget _child = child;

    //we need the image to cover whole container
    if (padding != null) {
      _child = Padding(padding: padding!, child: _child);
    }

    if (image != null || gradient != null) {
      _child = Stack(children: [
        //bg image
        if (image != null) image,

        //gradient
        if (gradient != null) Container(decoration: BoxDecoration(gradient: gradient)),

        //child
        child,
      ]);
    }

    if (onTap != null) {
      _child = MyInk(onTap: onTap, child: _child);
    }

    if (borderRadius != null) {
      _child = ClipRRect(borderRadius: borderRadius, child: _child);
    }

    if (elevation != null) {
      _child = Material(elevation: elevation!, borderRadius: borderRadius, color: Colors.transparent, child: _child);
    }

    _child = Container(
      height: height,
      width: width,
      alignment: alignment,
      margin: margin,
      constraints: getBoxConstraints(),
      decoration: getBoxDecoration(),
      child: _child,
    );

    return _child;
  }

  BoxDecoration? getBoxDecoration() {
    bool disabled = (bgColor == null && borderRadius == null && borderWidth == null && borderColor == null);

    if (!disabled) {
      return BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        gradient: gradient,
        border: getBorder(),
      );
    }

    return null;
  }

  BoxBorder? getBorder() {
    if (borderWidth == null && borderColor == null) {
      return null;
    }

    return Border.all(width: borderWidth ?? 0, color: borderColor ?? Colors.transparent);
  }
}
