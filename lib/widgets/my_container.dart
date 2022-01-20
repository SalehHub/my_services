import '../my_services.dart';

class MyContainer extends StatelessWidget {
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    if (onTap != null) {
      return MyInk(
        onTap: onTap,
        margin: margin ?? EdgeInsets.zero,
        borderRadius: borderRadius,
        child: buildChild(),
      );
    } else {
      return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: buildChild(),
      );
    }
  }

  Widget buildChild() {
    if (elevation != null) {
      return Material(
        elevation: elevation!,
        borderRadius: borderRadius,
        child: buildContainer(),
      );
    }

    return buildContainer();
  }

  Container buildContainer() {
    Widget? image;

    if (bgImageUrl != null && bgImageUrl?.trim() != "") {
      image = Opacity(
        opacity: bgImageOpacity ?? 1,
        child: MyLoadingImage(
          url: bgImageUrl!,
          blurHash: bgImageBlurHash,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    Widget _child = Padding(padding: padding ?? EdgeInsets.zero, child: child);
    if (image != null || gradient != null) {
      _child = Stack(children: [
        //bg image
        if (image != null) image,

        //gradient
        if (gradient != null) Container(decoration: BoxDecoration(gradient: gradient)),

        //child
        Padding(padding: padding ?? EdgeInsets.zero, child: child),
      ]);
    }

    return Container(
      height: height,
      width: width,
      alignment: alignment,
      decoration: getBoxDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular((borderRadius?.topLeft.x ?? 0) - (borderWidth ?? 0)),
        child: _child,
      ),
    );
  }

  BoxDecoration? getBoxDecoration() {
    bool disabled = (bgColor == null && borderRadius == null && borderWidth == null && borderColor == null);

    if (!disabled) {
      return BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        border: (borderWidth == null && borderColor == null) ? null : Border.all(width: borderWidth ?? 0, color: borderColor ?? Colors.transparent),
      );
    }
  }
}
