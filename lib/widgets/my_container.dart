import '../my_services.dart';

class MyContainer extends StatelessWidget {
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
  final double? borderWidth;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final String? bgImageUrl;
  final String? bgImageBlurHash;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final double? bgImageOpacity;

  const MyContainer({
    Key? key,
    this.onTap,
    this.width,
    this.height,
    this.borderWidth,
    this.borderColor,
    this.margin,
    this.padding,
    required this.child,
    this.gradient,
    this.bgImageUrl,
    this.borderRadius,
    this.bgImageOpacity,
    this.bgImageBlurHash,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInk(
      onTap: onTap,
      margin: margin ?? EdgeInsets.zero,
      borderRadius: borderRadius,
      child: Container(
        height: height,
        width: width,
        decoration: (borderRadius == null && borderWidth == null && borderColor == null)
            ? null
            : BoxDecoration(
                borderRadius: borderRadius,
                border: (borderWidth == null && borderColor == null) ? null : Border.all(width: borderWidth ?? 0, color: borderColor ?? Colors.transparent),
              ),
        clipBehavior: Clip.antiAlias,
        child: ClipRRect(
          borderRadius: BorderRadius.circular((borderRadius?.topLeft.x ?? 0) - (borderWidth ?? 0)),
          child: Stack(
            children: [
              //bg image
              if (bgImageUrl != null && bgImageUrl?.trim() != "")
                Opacity(
                  opacity: bgImageOpacity ?? 1,
                  child: MyLoadingImage(url: bgImageUrl!, blurHash: bgImageBlurHash, width: double.infinity, height: double.infinity),
                ),

              //gradient
              if (gradient != null) Container(decoration: BoxDecoration(gradient: gradient)),

              //child
              Positioned.fill(child: Padding(padding: padding ?? EdgeInsets.zero, child: child))
            ],
          ),
        ),
      ),
    );
  }
}
