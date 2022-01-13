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

abstract class MainStateTemplate<T extends ConsumerStatefulWidget> extends _MainStateData<T> {
  List<Widget> bodyChildren = <Widget>[];
  Widget? drawer;

  @protected
  bool get emptyData => bodyChildren.isEmpty;

  List<Widget> get appBarActions => <Widget>[];

  List<Widget> get _appBarActionsWithProgress => <Widget>[
        if (!emptyData && actionBarLoading) Container(margin: const EdgeInsets.all(8), height: 24, width: 24, child: const CupertinoActivityIndicator()) else ...appBarActions,
      ];

  String title = '';
  TextStyle? titleStyle;

  bool pageLoading = false;

  bool hideTopBanner = false;
  bool hideBottomBanner = false;
  Widget topBanner = const SizedBox();
  Widget bottomBanner = const SizedBox();
  Widget? underAppBarWidget;

  Widget get pageLoadingWidget => MyProgressIndicator(margin: EdgeInsets.symmetric(vertical: pageHeight / 3));

  bool actionBarLoading = false;
  Widget? appBarLeading;

  String get noDataLabel => myServicesLabels.thereAreNoDataYet;
  IconData noDataIcon = iconNoData;

  Object? error;
  StackTrace? stackTrace;

  bool showSearch = false;
  ValueChanged<String>? onSearchChanged;
  GestureTapCallback? onSearchClear;

  Widget get searchInput => SliverToBoxAdapter(
        child: MyTextInput(
          controller: searchController,
          textInputAction: TextInputAction.search,
          margin: const EdgeInsets.all(10),
          prefixIcon: const BackButton(),
          suffixIcon: searchController.text == "" ? const Icon(iconSearch) : GestureDetector(onTap: onSearchClear, child: const Icon(Mdi.closeCircle)),
          labelText: myServicesLabels.search,
          onChanged: onSearchChanged,
        ),
      );

  bool showAppBar = true;
  bool showRefreshIndicator = true;
  final TextEditingController searchController = TextEditingController();

  Widget get appBarTitle {
    return Text(title, textDirection: Helpers.getTextDirection(title), style: titleStyle, maxLines: 1);
  }

  //tab view
  List<Widget>? get tabs => null;
  bool isTabView = false;

  TabController? _tabController;

  // TabController? get tabController => _tabController;

  void setTabController(TabController tabController, {bool replace = false}) {
    if (replace) {
      _tabController = tabController;
    } else {
      _tabController ??= tabController;
    }
  }

  bool get _isValidTabBar => _isValidTabView && tabs != null && (tabs ?? []).length > 1;

  bool get _isValidTabView => isTabView && _tabController != null;

  Widget appBar(bool innerBoxIsScrolled) {
    if (showSearch == true) {
      return searchInput;
    }

    /// theme from [ServiceTheme] appBarTheme
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
  }

  List<Widget> _buildAppBarActions() {
    return _appBarActionsWithProgress.map((e) {
      return Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
      ServiceTheme.setSystemUiOverlayStyle(ThemeMode.system, context);
    }, 'changeDependenciesSetSystemUiOverlayStyle', 300);
  }

  @override
  @protected
  void didChangeDependencies() {
    _refreshThemeStyle();
    super.didChangeDependencies();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @protected
  void startPageLoading() {
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

  @override
  @protected
  void initState() {
    super.initState();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => init());
    } else {
      init();
    }
  }

  void init() {}

  Future<void> onRefresh() async {}

  @override
  Widget build(BuildContext context) {
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
              return Center(child: isTabView == false ? buildBody(context) : buildTabView(context));
            }),
          ),
        ),
      ),
    );
  }

  Widget buildTabView(BuildContext context) {
    if (!pageLoading && error == null && emptyData) {
      return PageEmptyWidget(noDataIcon: noDataIcon, noDataLabel: noDataLabel);
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

  Widget buildBody(BuildContext context) {
    var customScrollView = CustomScrollView(
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
          SliverToBoxAdapter(child: PageEmptyWidget(margin: const EdgeInsets.all(20), noDataIcon: noDataIcon, noDataLabel: noDataLabel))
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
