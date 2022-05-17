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
    super.key,
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
  });

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

    Widget tempChild = child;

    //we need the image to cover whole container
    if (padding != null) {
      tempChild = Padding(padding: padding!, child: tempChild);
    }

    if (image != null || gradient != null) {
      tempChild = Stack(children: [
        //bg image
        if (image != null) image,

        //gradient
        if (gradient != null) Container(decoration: BoxDecoration(gradient: gradient)),

        //child
        child,
      ]);
    }

    if (onTap != null) {
      tempChild = MyInk(onTap: onTap, child: tempChild);
    }

    if (borderRadius != null) {
      tempChild = ClipRRect(borderRadius: borderRadius, child: tempChild);
    }

    if (elevation != null) {
      tempChild = Material(elevation: elevation!, borderRadius: borderRadius, color: Colors.transparent, child: tempChild);
    }

    tempChild = Container(
      height: height,
      width: width,
      alignment: alignment,
      margin: margin,
      constraints: getBoxConstraints(),
      decoration: getBoxDecoration(),
      child: tempChild,
    );

    return tempChild;
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
