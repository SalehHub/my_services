import '../my_services.dart';

class MyLoadingImage extends StatelessWidget {
  const MyLoadingImage({
    super.key,
    required this.url,
    this.blurHash,
    this.width = 150,
    this.height = 150,
    this.radius = 0,
    this.borderRadius,
    this.onTap,
    this.borderColor,
    this.borderWidth = 0,
    this.circle = false,
    this.useCacheImage = true,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.fetchStrategy,
    this.errorBuilder,
    this.placeholderBuilder,
  });

  final String url;
  final String? blurHash;
  final double width;
  final double height;
  final Color? borderColor;
  final double borderWidth;
  final double radius;
  final BorderRadius? borderRadius;
  final bool circle;
  final bool useCacheImage;
  final GestureTapCallback? onTap;
  final BoxFit fit;
  final Alignment alignment;
  final Future<FetchInstructions> Function(Uri uri, FetchFailure? failure)? fetchStrategy;
  final OctoErrorBuilder? errorBuilder;
  final OctoPlaceholderBuilder? placeholderBuilder;

  // final PlaceholderWidgetBuilder? placeholderBuilder;
  // final LoadingErrorWidgetBuilder? errorBuilder;

  // PlaceholderWidgetBuilder get defaultPlaceholderBuilder => (BuildContext context, _) => placeHolder;
  // LoadingErrorWidgetBuilder get defaultErrorBuilder => (BuildContext context, _, __) => placeHolder;

  // Widget buildImageContainer(Widget child) {}

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      if (circle) {
        return SizedBox(
          width: width,
          height: height,
          child: CircleAvatar(
            radius: circle ? width : 0,
            backgroundImage: NetworkImage(
              url,
              // width: width,
              // height: height,
              // fit: fit.
            ),
            child: const SizedBox(),

            // Image.network(
            //   url,
            //   width: width,
            //   height: height,
            //   fit: fit,
            // ),
          ),
        );
      }

      return Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
      );
    }

    final ImageProvider image = provider(url, useCacheImage: useCacheImage, fetchStrategy: fetchStrategy);

    final Widget placeHolder = ImageContainer(
      width: width,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      onTap: onTap,
      borderColor: borderColor,
      borderWidth: borderWidth,
      circle: circle,
      child: Image(width: width, height: height, image: BlurHashImage(blurHash ?? 'LUMiyF-=_N?a#PD*IUslj^RPt6RP'), fit: fit),
    );

    // precacheImage(image,context);

    // return buildImageContainer(Image(image: image, fit: fit, width: width, height: height));

    return OctoImage(
      alignment: alignment,
      width: width,
      height: height,
      fit: fit,
      imageBuilder: (BuildContext context, Widget child) => ImageContainer(
        width: width,
        height: height,
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        onTap: onTap,
        borderColor: borderColor,
        borderWidth: borderWidth,
        circle: circle,
        child: child,
      ),
      image: image,
      placeholderBuilder: placeholderBuilder ?? (BuildContext context) => placeHolder,
      errorBuilder: errorBuilder ?? (BuildContext context, Object error, StackTrace? stackTrace) => Stack(children: [placeHolder, const Center(child: Icon(Icons.error))]),
    );
  }

  static ImageProvider provider(String url, {bool useCacheImage = true, Future<FetchInstructions> Function(Uri, FetchFailure?)? fetchStrategy}) {
    if (useCacheImage) {
      return CachedNetworkImageProvider(url);
    } else {
      return NetworkImageWithRetry(
        url,
        fetchStrategy: fetchStrategy ??
            (Uri uri, FetchFailure? failure) async {
              if (!url.startsWith('http') || (failure != null && failure.httpStatusCode == 404)) {
                return FetchInstructions.giveUp(uri: uri);
              } else {
                return FetchInstructions.attempt(uri: uri, timeout: const Duration(seconds: 5));
              }
            },
      );
    }
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.onTap,
    required this.borderColor,
    required this.borderWidth,
    required this.circle,
  });

  final double width;
  final double height;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final bool circle;
  final GestureTapCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final BorderRadius circleBorderRadius = BorderRadius.circular(height);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: circle == true ? circleBorderRadius : borderRadius,
        border: Border.all(color: borderColor ?? Colors.transparent, width: borderWidth),
      ),
      child: MyInk(
        onTap: onTap,
        borderRadius: circle == true ? circleBorderRadius : borderRadius,
        child: ClipRRect(
          borderRadius: circle == true ? circleBorderRadius : borderRadius,
          child: child,
        ),
      ),
    );
  }
}
