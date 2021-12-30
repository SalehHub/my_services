import '../my_services.dart';

class ImageData {
  final String url;
  final String? title;
  final Widget? footerWidget;
  final Widget? popupMenu;

  ImageData({required this.url, this.title, this.footerWidget, this.popupMenu});
}

class PageImageViewer extends ConsumerStatefulWidget {
  const PageImageViewer({Key? key, required this.image, this.imageList = const [], this.showDotIndicators = true}) : super(key: key);
  final List<ImageData> imageList;
  final ImageData image;
  final bool showDotIndicators;

  @override
  _PageImageViewerState createState() => _PageImageViewerState();
}

class _PageImageViewerState extends MainStateTemplate<PageImageViewer> {
  MyServicesLocalizationsData get labels => getMyServicesLabels(context);

  @override
  bool get showRefreshIndicator => false;

  @override
  bool get hideTopBanner => true;

  @override
  bool get hideBottomBanner => true;

  @override
  String get title => selectedImage?.title ?? "";

  List<ImageData> imageList = [];
  bool get hasImages => imageList.isNotEmpty;

  ImageData? get selectedImage => (imageList.isEmpty) ? null : imageList[index];

  Widget? get popupMenu => hasImages ? imageList[index].popupMenu : null;
  bool get hasPopupMenu => popupMenu != null;

  Widget? get footerWidget => hasImages ? imageList[index].footerWidget : null;
  bool get hasFooter => footerWidget != null;

  int index = 0;
  PageController pageController = PageController(initialPage: 0);
  PhotoViewScaleStateController? scaleStateController = PhotoViewScaleStateController();

  double get imageHeight {
    if (isPageOrientationLandScape) {
      return pageHeight - 100;
    }

    if (hasFooter) {
      return pageWidth;
    }

    return pageHeight - 150;
  }

  double get loadingImageHeight {
    if (isPageOrientationLandScape) {
      return pageHeight - 100;
    }

    if (widget.image.footerWidget != null) {
      return pageWidth;
    }

    return pageHeight - 150;
  }

  @override
  List<Widget> get appBarActions {
    return hasPopupMenu ? [popupMenu!] : [];
  }

  @override
  Widget get pageLoadingWidget => Center(
        child: Hero(
          tag: widget.image.url,
          child: MyLoadingImage(
            fit: BoxFit.contain,
            url: widget.image.url,
            radius: 10,
            width: double.infinity,
            height: loadingImageHeight,
          ),
        ),
      );

  @override
  // ignore: overridden_fields
  bool pageLoading = true;

  @override
  Future<void> init() async {
    // await Helpers.waitForMilliseconds(5000);

    if (widget.imageList.isEmpty) {
      imageList = [widget.image];
    } else {
      imageList = widget.imageList;
      int selectedIndex = imageList.indexWhere((element) => element.url == widget.image.url);
      if (selectedIndex == -1) {
        index = 0;
      }
      index = selectedIndex;
      pageController = PageController(initialPage: index);
    }

    stopPageLoading();
  }

  @override
  List<Widget> get bodyChildren {
    return [
      //
      SliverToBoxAdapter(child: SizedBox(height: imageHeight, child: buildImages())),
      SliverToBoxAdapter(child: buildIndicators()),
      //
      if (footerWidget != null) SliverToBoxAdapter(child: footerWidget),
      //
    ];
  }

  Widget buildIndicators() {
    if (widget.showDotIndicators == false || imageList.length < 2) {
      return const SizedBox();
    }

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 3),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      width: 5.0 * imageList.length,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(offset: const Offset(0, 0), color: Colors.black.withOpacity(0.1))],
        color: getTheme(context).scaffoldBackgroundColor.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
        child: ClipRect(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: AnimatedSmoothIndicator(
            count: imageList.length,
            activeIndex: index,
            onDotClicked: (index) => pageController.jumpToPage(index),
            effect: WormEffect(spacing: 1, dotWidth: 7, dotHeight: 7, activeDotColor: getTheme(context).toggleableActiveColor),
          ),
        ),
      ),
    );
  }

  Widget buildImages() {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: PhotoViewGallery.builder(
        itemCount: imageList.length,
        pageController: pageController,
        onPageChanged: (i) => setState(() => index = i),
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            heroAttributes: PhotoViewHeroAttributes(tag: imageList[index].url),
            imageProvider: CachedNetworkImageProvider(imageList[index].url),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(color: getTheme(context).scaffoldBackgroundColor),
        loadingBuilder: (BuildContext context, ImageChunkEvent? event) => const MyProgressIndicator(),
      ),
    );
  }
}
