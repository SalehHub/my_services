import '../my_services.dart';

abstract class _MainStateData<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  /////Theme
  ThemeData get theme => Theme.of(context);

  TextTheme get textTheme => theme.textTheme;

  bool get isDarkTheme => theme.brightness == Brightness.dark;

  //////PageSize
  MediaQueryData get mediaQueryData => MediaQuery.of(context);

  MyServicesLocalizationsData get myServicesLabels => getMyServicesLabels(context);

  Orientation get pageOrientation => mediaQueryData.orientation;

  bool get isPageOrientationLandScape => pageOrientation == Orientation.landscape;

  bool get isPageOrientationPortrait => pageOrientation == Orientation.portrait;

  Size get pageSize => mediaQueryData.size;

  double get pageHeight => pageSize.height;

  double get pageWidth => pageSize.width;
}

abstract class MainStateTemplate<T extends ConsumerStatefulWidget> extends _MainStateData<T> with SaveSetStateMixin, SearchMixin, BannersMixin, LoadingsMixin, TabsMixin {
  //
  List<Widget> bodyChildren = <Widget>[];
  List<Widget> get appBarActions => <Widget>[];

  Widget? drawer;
  Widget? floatingBottomWidget;
  Widget? underAppBarWidget;

  WillPopCallback? onBack;

  @protected
  bool get emptyData => bodyChildren.isEmpty;
  String get emptyDataLabel => myServicesLabels.thereAreNoDataYet;
  IconData emptyDataIcon = iconNoData;

  List<Widget> get _appBarActionsWithProgress {
    if (!emptyData && actionBarLoading) {
      return [Container(margin: const EdgeInsets.all(8), height: 24, width: 24, child: const CupertinoActivityIndicator())];
    }
    return appBarActions;
  }

  String title = '';
  TextStyle? titleStyle;

  bool homePage = false;
  bool showAppBar = true;
  bool showRefreshIndicator = true;

  //bad don't do this
  //bool get startPageInLoadingState => pageLoading;

  Object? error;
  StackTrace? stackTrace;

  Widget get appBarTitle {
    return Text(title, textDirection: MyServices.helpers.getTextDirection(title), style: titleStyle, maxLines: 1);
  }

  Widget appBar(bool innerBoxIsScrolled) {
    if (showSearchAppBar == true) {
      return searchInput;
    }

    /// theme from [ServiceTheme] appBarTheme
    // return SliverCard(
    //   clipBehavior: Clip.antiAlias,
    //   elevation: 0,
    //   margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    //   shape: ServiceTheme.circularBorderRadius10,
    //   sliver:

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      sliver: SliverAppBar(
        toolbarHeight: 50,
        centerTitle: true,
        bottom: _isValidTabBar ? _buildAppBarBottom() : null,
        title: appBarTitle,
        leading: _buildAppBarLeading(),
        actions: _buildAppBarActions(),
        floating: true,
        snap: true,
        forceElevated: true,
      ),
    );

    // );
  }

  List<Widget> _buildAppBarActions() {
    return _appBarActionsWithProgress.map((e) {
      return Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: MyServices.services.theme.borderRadius,
        child: e,
      );
    }).toList();
  }

  Widget? _buildAppBarLeading() {
    if (appBarLeading != null) {
      return Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        ),
        child: appBarLeading,
      );
    }
    return null;
  }

  PreferredSizeWidget? _buildAppBarBottom() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(35),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: tabs!,
      ),
    );
  }

  void _refreshThemeStyle() {
    ServiceDebounce.debounce(() {
      logger.w("Service Theme Set System Ui Overlay Style");
      if (mounted) {
        MyServices.services.theme.setSystemUiOverlayStyle(ThemeMode.system, context);
      }
    }, 'changeDependenciesSetSystemUiOverlayStyle', 300);
  }

  @override
  @protected
  void didChangeDependencies() {
    _refreshThemeStyle();
    super.didChangeDependencies();
  }

  @override
  @protected
  void initState() {
    if (startPageInLoadingState) {
      pageLoading = true;
    }

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _myInitState());
  }

  void _myInitState() {
    if (homePage) {
      if (MyServices.appConfig.withFCM) {
        ServiceFirebaseMessaging.requestPermission(); //firebaseMessaging

        if (MyServices.appEvents.onFCMTokenRefresh != null) {
          ServiceFirebaseMessaging.onTokenRefresh((token) => MyServices.appEvents.onFCMTokenRefresh!(token, ref, context)); //firebaseMessaging
        }
      }

      if (MyServices.appEvents.onDynamicLink != null) {
        ServiceDynamicLink.register((Uri uri) => MyServices.appEvents.onDynamicLink!(uri, ref, context)); //appLinks
      }
    }

    init();
  }

  void init() {}

  Future<void> onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    if (homePage && MyServices.appEvents.onLocaleChange != null) {
      MyServices.providers.onLocaleChange(ref, (previous, next) {
        MyServices.appEvents.onLocaleChange!(previous, next, ref, context);

        logger.w("Previous:${previous?.languageCode ?? ""}\nNext:${next?.languageCode ?? ""}");
      });
    }

    if (onBack == null) {
      return buildScaffold();
    }

    return WillPopScope(
      onWillPop: onBack,
      child: buildScaffold(),
    );
  }

  Container buildScaffold() {
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          drawer: drawer,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                if (showAppBar)
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: appBar(innerBoxIsScrolled),
                  )
                else
                  const SliverToBoxAdapter(child: SizedBox())
              ];
            },
            body: Builder(builder: (context) {
              if (floatingBottomWidget != null) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    buildScaffoldBody(context),
                    Positioned(bottom: 0, child: floatingBottomWidget!),
                  ],
                );
              }
              return buildScaffoldBody(context);
            }),
          ),
        ),
      ),
    );
  }

  Center buildScaffoldBody(BuildContext context) => Center(child: isTabView == false ? buildPage(context) : buildTabView(context));

  Widget buildTabView(BuildContext context) {
    if (!pageLoading && error == null && emptyData) {
      return PageEmptyWidget(icon: emptyDataIcon, label: emptyDataLabel);
    }

    if (pageLoading || !_isValidTabView) {
      return pageLoadingWidget;
    }

    if (!pageLoading && error != null && emptyData) {
      return FutureErrorWidget(err: error);
    }

    int i = 0;
    return TabBarView(
      controller: _tabController,
      children: bodyChildren.map((e) {
        i++;
        if (showRefreshIndicator) {
          return RefreshIndicator(
            displacement: 55,
            onRefresh: i == 1 ? onRefresh : () async {},
            child: e,
          );
        } else {
          return e;
        }
      }).toList(),
    );
  }

  Widget buildPage(BuildContext context) {
    final customScrollView = CustomScrollView(
      slivers: <Widget>[
        if (showAppBar) SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),

        if (underAppBarWidget != null) underAppBarWidget!,

        //top banner
        if (!hideTopBanner) SliverToBoxAdapter(child: topBanner),

        //show loading
        if (pageLoading)
          SliverToBoxAdapter(child: pageLoadingWidget)

        //no data
        else if (pageLoading == false && error == null && emptyData == true)
          SliverToBoxAdapter(child: PageEmptyWidget(margin: const EdgeInsets.all(20), icon: emptyDataIcon, label: emptyDataLabel))
        // error
        else if (!pageLoading && error != null && emptyData)
          SliverToBoxAdapter(child: FutureErrorWidget(err: error))
        else
          ...bodyChildren,

        const SliverPadding(padding: EdgeInsets.only(top: 50)),

        //bottom banner
        if (!hideBottomBanner) SliverToBoxAdapter(child: bottomBanner),

        const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
      ],
    );

    if (showRefreshIndicator) {
      return RefreshIndicator(
        displacement: 55,
        onRefresh: onRefresh,
        child: customScrollView,
      );
    }
    return customScrollView;
  }

  Future<void> loaderFunction(AsyncCallback fn, {bool showPageLoading = true, bool showActionBarLoading = true}) async {
    try {
      if (showPageLoading) startPageLoading();
      if (showActionBarLoading) startActionBarLoading();
      await fn();
    } catch (e, s) {
      error = e;
      stackTrace = s;
      logger.e(e, e, s);
    } finally {
      if (showPageLoading) stopPageLoading();
      if (showActionBarLoading) stopActionBarLoading();
    }
  }
}

mixin TabsMixin<T extends StatefulWidget> on State<T> {
  //tab view
  List<Widget>? get tabs => null;
  bool isTabView = false;

  TabController? _tabController;

  void setTabController(TabController tabController, {bool replace = false}) {
    if (replace) {
      _tabController = tabController;
    } else {
      _tabController ??= tabController;
    }
  }

  bool get _isValidTabView => isTabView && _tabController != null;

  bool get _isValidTabBar => _isValidTabView && tabs != null && (tabs ?? []).length > 1;
}

mixin LoadingsMixin<T extends StatefulWidget> on State<T> {
  bool pageLoading = false;
  bool startPageInLoadingState = false;
  bool actionBarLoading = false;
  Widget? appBarLeading;
  Widget get pageLoadingWidget => MyProgressIndicator(margin: EdgeInsets.symmetric(vertical: MyServices.helpers.getPageHeight(context) / 3));

  @protected
  void startPageLoading() {
    print("startPageLoading mixin");
    setState(() => pageLoading = true);
  }

  @protected
  void stopPageLoading() {
    setState(() => pageLoading = false);
  }

  @protected
  void startActionBarLoading() {
    setState(() => actionBarLoading = true);
  }

  @protected
  void stopActionBarLoading() {
    setState(() => actionBarLoading = false);
  }
}

mixin BannersMixin<T extends StatefulWidget> on State<T> {
  bool hideTopBanner = false;
  bool hideBottomBanner = false;

  Widget topBanner = const SizedBox();
  Widget bottomBanner = const SizedBox();
}

mixin SaveSetStateMixin<T extends StatefulWidget> on State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      print("SaveSetStateMixin");
      super.setState(fn);
    }
  }
}
mixin SearchMixin<T extends StatefulWidget> on State<T> {
  bool showSearchAppBar = false;

  ValueChanged<String>? onSearchChanged;
  ValueChanged<String>? onSearchSubmitted;
  GestureTapCallback? onSearchClear;

  final TextEditingController searchController = TextEditingController();

  Widget get searchInput => SliverToBoxAdapter(
        child: MyTextInput(
          controller: searchController,
          textInputAction: TextInputAction.search,
          margin: const EdgeInsets.all(10),
          prefixIcon: const BackButton(),
          suffixIcon: searchController.text == "" ? const Icon(iconSearch) : GestureDetector(onTap: onSearchClear, child: const Icon(Mdi.closeCircle)),
          labelText: getMyServicesLabels(context).search,
          onChanged: onSearchChanged,
          onFieldSubmitted: onSearchSubmitted,
          floatingLabel: true,
        ),
      );
}
