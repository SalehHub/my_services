import '../my_services.dart';

class MyLoadingImage extends StatelessWidget {
  const MyLoadingImage({
    Key? key,
    required this.url,
    this.blurHash,
    this.width = 150,
    this.height = 150,
    this.radius = 0,
    this.onTap,
    this.borderColor,
    this.borderWidth = 0,
    this.circle = false,
    this.useCacheImage = false,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.fetchStrategy,
    this.errorBuilder,
    this.placeholderBuilder,
  }) : super(key: key);

  final String url;
  final String? blurHash;
  final double width;
  final double height;
  final Color? borderColor;
  final double borderWidth;
  final double radius;
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

  ImageProvider get cachedImage => CachedNetworkImageProvider(url);

  ImageProvider get retryImage => NetworkImageWithRetry(url, fetchStrategy: fetchStrategy ?? defaultFetchStrategy);

  ImageProvider get image => useCacheImage ? cachedImage : retryImage;

  Future<FetchInstructions> Function(Uri uri, FetchFailure? failure) get defaultFetchStrategy => (Uri uri, FetchFailure? failure) async {
        if (!url.startsWith('http') || (failure != null && failure.httpStatusCode == 404)) {
          return FetchInstructions.giveUp(uri: uri);
        } else {
          return FetchInstructions.attempt(uri: uri, timeout: const Duration(seconds: 5));
        }
      };

  BorderRadius get circleBorderRadius => BorderRadius.circular(height);

  BorderRadius get borderRadius => BorderRadius.circular(radius);

  Widget get placeHolder => buildImageContainer(
        Image(
          width: width,
          height: height,
          image: BlurHashImage(blurHash ?? 'LUMiyF-=_N?a#PD*IUslj^RPt6RP'),
          fit: fit,
        ),
      );

  OctoPlaceholderBuilder get defaultPlaceholderBuilder => (BuildContext context) => placeHolder;

  OctoErrorBuilder get defaultErrorBuilder => (BuildContext context, Object error, StackTrace? stackTrace) => placeHolder;

  // PlaceholderWidgetBuilder get defaultPlaceholderBuilder => (BuildContext context, _) => placeHolder;
  // LoadingErrorWidgetBuilder get defaultErrorBuilder => (BuildContext context, _, __) => placeHolder;

  Widget buildImageContainer(Widget child) {
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
          borderRadius: circle == true ? circleBorderRadius : BorderRadius.circular(radius - borderWidth),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      alignment: alignment,
      width: width,
      height: height,
      fit: fit,
      imageBuilder: (BuildContext context, Widget child) => buildImageContainer(child),
      image: image,
      placeholderBuilder: placeholderBuilder ?? defaultPlaceholderBuilder,
      errorBuilder: errorBuilder ?? defaultErrorBuilder,
    );
  }
}
