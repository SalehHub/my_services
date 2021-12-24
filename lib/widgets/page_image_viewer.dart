import '../my_services.dart';

class ImageData {
  final String url;
  final Widget? footerWidget;
  final Widget? popupMenu;

  ImageData({required this.url, this.footerWidget, this.popupMenu});
}

class PageImageViewer extends ConsumerStatefulWidget {
  const PageImageViewer({Key? key, this.title = '', required this.image, this.imageList = const [], this.showDotIndicators = true}) : super(key: key);
  final String title;
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
  String get title => widget.title;

  List<ImageData> imageList = [];
  bool get hasImages => imageList.isNotEmpty;

  ImageData get selectedImage => imageList[index];

  Widget? get popupMenu => hasImages ? imageList[index].popupMenu : null;
  bool get hasPopupMenu => popupMenu != null;

  Widget? get footerWidget => hasImages ? imageList[index].footerWidget : null;
  bool get hasFooter => footerWidget != null;

  int index = 0;
  PageController pageController = PageController(initialPage: 0);

  double get imageHeight {
    if (isPageOrientationLandScape) {
      return pageHeight - 100;
    }

    if (hasFooter) {
      return pageWidth;
    }

    return pageHeight - 150;
  }

  @override
  List<Widget> get appBarActions {
    return hasPopupMenu ? [popupMenu!] : [];
  }

  @override
  Future<void> init() async {
    startPageLoading();

    await Helpers.waitForMilliseconds(20);

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
  List<Widget> get bodyChildren => [
        //
        SliverToBoxAdapter(child: SizedBox(height: imageHeight, child: buildImages())),
        SliverToBoxAdapter(child: buildIndicators()),
        //
        if (footerWidget != null) SliverToBoxAdapter(child: footerWidget),
        //
      ];

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
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: PhotoViewGallery.builder(
        itemCount: imageList.length,
        pageController: pageController,
        onPageChanged: (i) => setState(() => index = i),
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            heroAttributes: PhotoViewHeroAttributes(tag: imageList[index].url),
            imageProvider: CachedNetworkImageProvider(imageList[index].url),
            // Contained = the smallest possible size to fit one dimension of the screen
            minScale: PhotoViewComputedScale.contained * 0.8,
            // Covered = the smallest possible size to fit the whole screen
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        // Set the background color to the "classic white"
        backgroundDecoration: BoxDecoration(color: getTheme(context).canvasColor),
        loadingBuilder: (BuildContext context, ImageChunkEvent? event) => const MyProgressIndicator(),
      ),
    );
  }
}
