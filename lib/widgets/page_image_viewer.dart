import '../my_services.dart';

class PageImageViewer extends ConsumerStatefulWidget {
  const PageImageViewer({
    Key? key,
    this.title = '',
    required this.image,
    this.imageList = const [],
    this.popupMenuButton,
    this.showDotIndicators = true,
  }) : super(key: key);
  final String title;
  final List<String> imageList;
  final String image;
  final MyPopupMenu? popupMenuButton;
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

  List<String> imageList = [];

  String get selectedImage => imageList[index];

  int index = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  List<Widget> get appBarActions {
    return widget.popupMenuButton != null ? [widget.popupMenuButton!] : [];
  }

  @override
  Future<void> init() async {
    startPageLoading();

    await Helpers.waitForMilliseconds(20);

    if (widget.imageList.isEmpty) {
      imageList = [widget.image];
    } else {
      imageList = widget.imageList;
      int f = imageList.indexWhere((element) => element == widget.image);
      if (f == -1) {
        index = 0;
      }
      index = f;
      pageController = PageController(initialPage: index);
    }

    stopPageLoading();
  }

  @override
  List<Widget> get bodyChildren => [
        SliverToBoxAdapter(child: buildIndicators()),
        //
        SliverToBoxAdapter(
          child: SizedBox(height: pageHeight - 100, child: buildImages()),
        ),
        //
      ];

  Widget buildIndicators() {
    if (widget.showDotIndicators == false || imageList.length < 2) {
      return const SizedBox();
    }

    return Container(
      height: 20,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 50, right: 50, top: 0, bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(offset: const Offset(0, 0), color: Colors.black.withOpacity(0.1))],
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: AnimatedSmoothIndicator(
        count: imageList.length,
        activeIndex: index,
        effect: WormEffect(
          spacing: 1,
          dotWidth: 7,
          dotHeight: 7,
          activeDotColor: Theme.of(context).toggleableActiveColor,
        ),
      ),
    );
  }

  Widget buildImages() {
    return PhotoViewGallery.builder(
      itemCount: imageList.length,
      pageController: pageController,
      onPageChanged: (i) => setState(() => index = i),
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(imageList[index]),
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
    );
  }
}
