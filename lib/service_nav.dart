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
