import 'package:flutter/material.dart';

import '../helpers.dart';

class ServiceNav {
  static String? currentRoute;

  static final List<NavigatorObserver> navigatorObservers = <NavigatorObserver>[
    MyNavigatorObserver(),
    // FirebaseAnalyticsObserver(analytics: firebaseAnalytics),
  ];

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? name = route.settings.name;
    logger.i('Push: $name');
    ServiceNav.currentRoute = name;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? name = previousRoute?.settings.name;
    logger.i('Pop: $name');
    ServiceNav.currentRoute = name;
  }
}

////Helpers
void pop() {
  final NavigatorState? nav = ServiceNav.navigatorKey.currentState;
  if (nav != null) {
    return nav.pop();
  }
}

Future<dynamic> push({Widget? page, bool goToFirstRoute = false, bool replacement = false, bool transparent = false}) {
  final NavigatorState? nav = ServiceNav.navigatorKey.currentState;
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
