import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'helpers.dart';

class ServiceAppBadger {
  static Future<void> updateBadgeCount(int count) async {
    try {
      if (await FlutterAppBadger.isAppBadgeSupported()) {
        FlutterAppBadger.updateBadgeCount(count);
      }
    } on PlatformException catch (e, s) {
      logger.e(e, e, s);
    } catch (e, s) {
      logger.e(e, e, s);
    }
  }

  static void removeBadge() => FlutterAppBadger.removeBadge();
}
