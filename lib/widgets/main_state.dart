import '../my_services.dart';

abstract class _MainStateData<T extends ConsumerStatefulWidget> extends ConsumerState<T> with WidgetsBindingObserver {
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

abstract class MainStateTemplate<T extends ConsumerStatefulWidget> extends _MainStateData<T>
    with SafeSetStateMixin, SearchMixin, BannersMixin, HeadLoadingsMixin, LoadingsMixin, TabsMixin, NestedScrollViewStateKeyMixin, LoadMoreMixin, ScaffoldKeyMixin, DrawerMixin, BindingObserverMixin {
  //

  List<Widget> bodyChildren = <Widget>[];
  List<Widget> get appBarActions => <Widget>[];

  Widget? floatingBottomWidget;
  Widget? underAppBarWidget;

  WillPopCallback? onBack;

  @protected
  bool get emptyData => pageLoading == false && bodyChildren.isEmpty;
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
        bottom: _isValidTabBar && showTabBar ? _buildAppBarBottom() : null,
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

  Widget? appBarLeading;

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
    } else if (drawerIcon != null && hasDrawer) {
      return drawerIcon;
    }
    return null;
  }

  PreferredSizeWidget? _buildAppBarBottom() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(35),
      child: IgnorePointer(
        ignoring: ignoreTabBarTap,
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: tabs!,
        ),
      ),
    );
  }

  void _refreshThemeStyle() {
    MyS.services.debounce.debounce(() {
      // logger.w("Service Theme Set System Ui Overlay Style");
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
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _myInitState());
  }

  void _myInitState() {
    if (homePage) {
      //start-firebaseMessaging
      if (MyServices.appConfig.withFCM) {
        MyServices.services.firebaseMessaging.requestPermission();

        if (MyServices.appEvents.onFirebaseNotification != null) {
          MyServices.services.firebaseMessaging.registerFirebaseMessaging(ref, onFirebaseNotification: MyServices.appEvents.onFirebaseNotification!);
        }
        if (MyServices.appEvents.onFCMTokenRefresh != null) {
          MyServices.services.firebaseMessaging.onTokenRefresh((token) => MyServices.appEvents.onFCMTokenRefresh!(token, ref, context));
        }
      }
      //end-firebaseMessaging

      //
    }

    init();
  }

  Future<void> init() async {}

  Future<void> onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    if (homePage && MyServices.appEvents.onLocaleChange != null) {
      MyServices.providers.onLocaleChange(ref, (previous, next) {
        MyServices.appEvents.onLocaleChange!(previous, next, ref, context);

        logger.w("Previous:${previous?.languageCode ?? ""}\nNext:${next?.languageCode ?? ""}");
      });
    }

    if (onBack == null && !homePage) {
      return buildScaffold();
    }

    return WillPopScope(
      onWillPop: onBack == null && homePage
          ? () {
              MyServices.services.snackBar.showYesQuestion(questionText: getMyServicesLabels(context).areYouSureYouWantToCloseTheApp, onYes: SystemNavigator.pop);
              return Future<bool>.value(false);
            }
          : onBack,
      child: buildScaffold(),
    );
  }

  Container buildScaffold() {
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Scaffold(
              drawer: drawer,
              key: scaffoldKey,
              body: NestedScrollView(
                key: globalKeyNestedScrollView,
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
          if (pageHeadLoading) pageHeadLoadingWidget,
        ],
      ),
    );
  }

  Widget buildScaffoldBody(BuildContext context) {
    return Center(child: isTabView == false ? buildPage(context) : buildTabView(context));
  }

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

        if (moreLoading) const SliverToBoxAdapter(child: MyProgressIndicator(margin: EdgeInsets.all(20))),

        const SliverPadding(padding: EdgeInsets.only(top: 20)),

        //bottom banner
        if (!hideBottomBanner) SliverToBoxAdapter(child: bottomBanner),

        const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
      ],
    );

    if (showRefreshIndicator) {
      return RefreshIndicator(
        color: getColorScheme(context).onPrimary,
        backgroundColor: getColorScheme(context).primary,
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
      if (showPageLoading || startPageInLoadingState) stopPageLoading();
      if (showActionBarLoading) stopActionBarLoading();
    }
  }
}

mixin ScaffoldKeyMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}
mixin NestedScrollViewStateKeyMixin {
  final GlobalKey<NestedScrollViewState> globalKeyNestedScrollView = GlobalKey<NestedScrollViewState>();
}

mixin DrawerMixin<T extends StatefulWidget> on State<T>, ScaffoldKeyMixin {
  Widget? drawer;
  Widget? drawerIcon;
  bool get isDrawerOpen => scaffoldKey.currentState?.isDrawerOpen ?? false;
  bool get hasDrawer => scaffoldKey.currentState?.hasDrawer ?? false;
  void openDrawer() => scaffoldKey.currentState?.openDrawer();
}

mixin LoadMoreMixin<T extends StatefulWidget> on State<T>, NestedScrollViewStateKeyMixin {
  bool moreLoading = false;
  double moreTrigger = 0.8;
  AsyncCallback? loadMore;
  bool moreData = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _addLoadMoreListener());
  }

  void _addLoadMoreListener() {
    if (loadMore != null) {
      globalKeyNestedScrollView.currentState?.innerController.addListener(() async {
        var pageScrollController = globalKeyNestedScrollView.currentState?.innerController;

        double maxScrollExtent = pageScrollController?.position.maxScrollExtent ?? 0;
        var nextPageTrigger = moreTrigger * maxScrollExtent;
        double pixels = pageScrollController?.position.pixels ?? 0;
        if (pixels > nextPageTrigger && moreLoading == false && moreData == true) {
          setState(() => moreLoading = true);
          if (loadMore != null) {
            await loadMore!();
            double maxScrollExtent = pageScrollController?.position.maxScrollExtent ?? 0;
            nextPageTrigger = moreTrigger * maxScrollExtent;
            setState(() => moreLoading = false);
          }
        }
      });
    }
  }
}

mixin TabsMixin<T extends StatefulWidget> on State<T> {
  //tab view
  List<Widget>? get tabs => null;
  bool isTabView = false;
  bool showTabBar = true;
  bool ignoreTabBarTap = false;

  TabController? _tabController;
  TabController? get tabController => _tabController;

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
  Widget get pageLoadingWidget => MyProgressIndicator(margin: EdgeInsets.symmetric(vertical: MyServices.helpers.getPageHeight(context) / 3));

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
  void initState() {
    if (startPageInLoadingState) {
      pageLoading = true;
    }
    super.initState();
  }
}

mixin HeadLoadingsMixin<T extends StatefulWidget> on State<T> {
  bool pageHeadLoading = false;
  bool startPageInHeadLoadingState = false;

  Widget get pageHeadLoadingWidget => Container(
        color: getTheme(context).scaffoldBackgroundColor,
        child: MyProgressIndicator(
          margin: EdgeInsets.symmetric(vertical: MyServices.helpers.getPageHeight(context) / 3),
        ),
      );

  @protected
  void startPageHeadLoading() {
    setState(() => pageHeadLoading = true);
  }

  @protected
  void stopPageHeadLoading() {
    setState(() => pageHeadLoading = false);
  }
}

mixin BannersMixin<T extends StatefulWidget> on State<T> {
  bool hideTopBanner = true;
  bool hideBottomBanner = true;

  Widget topBanner = const SizedBox();
  Widget bottomBanner = const SizedBox();
}

mixin SafeSetStateMixin<T extends StatefulWidget> on State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

mixin BindingObserverMixin<T extends StatefulWidget> on State<T>, WidgetsBindingObserver {
  Function? onResumed;
  bool _firstResume = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (onResumed != null) {
      if (state == AppLifecycleState.resumed) {
        if (_firstResume) {
          _firstResume = false;
          return;
        }

        onResumed?.call();
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (onResumed != null) {
      WidgetsBinding.instance.addObserver(this);
    }
  }

  @override
  void dispose() {
    if (onResumed != null) {
      WidgetsBinding.instance.removeObserver(this);
    }

    super.dispose();
  }
}

mixin SearchMixin<T extends StatefulWidget> on State<T> {
  bool showSearchAppBar = false;
  String searchTerm = "";

  ValueChanged<String>? onSearchChanged;
  ValueChanged<String>? onSearchSubmitted;
  GestureTapCallback? onSearchClear;
  VoidCallback? onSearchBackPressed;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void focusSearchInput() => _searchFocusNode.requestFocus();

  Widget get searchInput => SliverToBoxAdapter(
        child: MyTextInput(
          focusNode: _searchFocusNode,
          value: searchTerm,
          textInputAction: TextInputAction.search,
          margin: const EdgeInsets.all(6),
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: BackButton(
            onPressed: () {
              if (onSearchBackPressed != null) {
                onSearchBackPressed!();
              } else {
                Navigator.maybePop(context);
              }
            },
          ),
          suffixIcon: searchTerm == "" ? const Icon(iconSearch) : GestureDetector(onTap: onSearchClear, child: const Icon(Mdi.closeCircle)),
          labelText: getMyServicesLabels(context).search,
          onChanged: onSearchChanged,
          onFieldSubmitted: onSearchSubmitted,
          floatingLabel: true,
        ),
      );
}
