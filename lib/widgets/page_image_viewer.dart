import '../my_services.dart';

class PageImageViewer extends ConsumerStatefulWidget {
  const PageImageViewer({Key? key, this.title = '', required this.imageList}) : super(key: key);
  final String title;
  final List<String> imageList;

  @override
  _PageImageViewerState createState() => _PageImageViewerState();
}

class _PageImageViewerState extends MainStateTemplate<PageImageViewer> {
  MyServicesLocalizationsData get labels => getMyServicesLabels(context);

  @override
  bool get hideTopBanner => true;

  @override
  bool get hideBottomBanner => true;

  @override
  String get title => widget.title;

  @override
  List<Widget> get bodyChildren => [
        SliverToBoxAdapter(
          child: SizedBox(height: pageHeight - 100, child: buildImages()),
        )
      ];

  Widget buildImages() {
    return PhotoViewGallery.builder(
      itemCount: widget.imageList.length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(widget.imageList[index]),
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
