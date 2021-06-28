import 'package:flutter/material.dart';

import 'helpers.dart';

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

Future<dynamic> push({Widget? page, bool goToFirstRoute = false, bool replacement = false}) {
  final NavigatorState? nav = ServiceNav.navigatorKey.currentState;
  if (nav != null) {
    final String name = page.runtimeType.toString();
    if (goToFirstRoute == false) {
      if (replacement == true) {
        return nav.pushReplacement(
          MaterialPageRoute<dynamic>(
            settings: RouteSettings(name: name),
            builder: (BuildContext c) => page!,
          ),
        );
      }

      return nav.push<dynamic>(
        MaterialPageRoute<dynamic>(
          settings: RouteSettings(name: name),
          builder: (BuildContext c) => page!,
        ),
      );
    } else {
      nav.popUntil((Route<dynamic> route) => route.isFirst);
      return nav.pushReplacement(
        MaterialPageRoute<dynamic>(
          settings: RouteSettings(name: name),
          builder: (BuildContext c) => page!,
        ),
      );
    }
  }
  return Future<void>.value();
}
