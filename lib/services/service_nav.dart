import '../my_services.dart';

class ServiceNav {
  String? _currentRoute;
  String? get currentRoute => _currentRoute;
  setCurrentRoute(String? v) => _currentRoute = v;

  final List<NavigatorObserver> navigatorObservers = <NavigatorObserver>[
    MyNavigatorObserver(),
  ];

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => navigatorKey.currentContext!;
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? name = route.settings.name;
    // if (name != null) {
    //   logger.i('Push: $name');
    // }
    MyServices.services.nav.setCurrentRoute(name);

    //
    Function(String?)? onPush = MyServices.appEvents.onPush;
    if (onPush != null) {
      onPush(name);
    }
    //
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? name = previousRoute?.settings.name;
    // if (name != null) {
    //   logger.i('Pop: $name');
    // }
    MyServices.services.nav.setCurrentRoute(name);

    //
    Function(String?)? onPop = MyServices.appEvents.onPop;
    if (onPop != null) {
      onPop(name);
    }
    //
  }
}

////Helpers
void pop<T extends Object?>([T? result]) {
  final NavigatorState? nav = MyServices.services.nav.navigatorKey.currentState;
  if (nav != null) {
    return nav.pop<T>(result);
  }
}

void popToHome() {
  final NavigatorState? nav = MyServices.services.nav.navigatorKey.currentState;
  if (nav != null) {
    return nav.popUntil((Route<dynamic> route) => route.isFirst);
  }
}

Future<dynamic> push({Widget? page, bool goToFirstRoute = false, bool replacement = false, bool transparent = false}) {
  final NavigatorState? nav = MyServices.services.nav.navigatorKey.currentState;
  if (nav != null) {
    final String name = page.runtimeType.toString();

    final MaterialPageRoute pageRoute = MaterialPageRoute<dynamic>(
      settings: RouteSettings(name: name),
      builder: (BuildContext c) => page!,
    );
    final TransparentRoute transparentPageRoute = TransparentRoute(
      settings: RouteSettings(name: name),
      builder: (BuildContext c) => page!,
    );

    if (goToFirstRoute == true) {
      nav.popUntil((Route<dynamic> route) => route.isFirst);
    }

    if (replacement == true) {
      return nav.pushReplacement(transparent ? transparentPageRoute : pageRoute);
    } else {
      return nav.push<dynamic>(transparent ? transparentPageRoute : pageRoute);
    }
  }
  return Future<void>.value();
}

class TransparentRoute<T> extends PageRoute<T> {
  TransparentRoute({
    required this.builder,
    required RouteSettings settings,
  }) : super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}
