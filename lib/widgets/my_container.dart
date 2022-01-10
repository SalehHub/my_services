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
  final double? elevation;

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
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDec = (borderRadius == null && borderWidth == null && borderColor == null && elevation != null);
    return MyInk(
      onTap: onTap,
      margin: margin ?? EdgeInsets.zero,
      borderRadius: borderRadius,
      child: Container(
        height: height,
        width: width,
        decoration: boxDec
            ? null
            : BoxDecoration(
                boxShadow: [
                  if (elevation != null)
                    BoxShadow(
                      color: Colors.black87,
                      offset: const Offset(0.0, 0.5),
                      blurRadius: elevation!,
                      spreadRadius: 0,
                    ),
                ],
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
                  child: MyLoadingImage(
                    // bgImageUrl!,
                    url: bgImageUrl!,
                    blurHash: bgImageBlurHash,
                    width: double.infinity,
                    height: double.infinity,
                    // fit: BoxFit.cover,
                    useCacheImage: true,
                  ),
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
