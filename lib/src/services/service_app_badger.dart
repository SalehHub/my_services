//flutterAppBadger
import '../../my_services.dart';

class ServiceAppBadger {
  // static const ServiceAppBadger _s = ServiceAppBadger._();
  // factory ServiceAppBadger() => _s;
  // const ServiceAppBadger._();
  const ServiceAppBadger();
  //
  Future<void> updateBadgeCount(int count) async {
    try {
      //TODO: remove when supported
      if (!kIsWeb && !Platform.isMacOS) {
        if (await FlutterAppBadger.isAppBadgeSupported()) {
          FlutterAppBadger.updateBadgeCount(count);
        }
      }
    } on PlatformException catch (e, s) {
      logger.e(e, error: e, stackTrace: s);
    } catch (e, s) {
      logger.e(e, error: e, stackTrace: s);
    }
  }

  void removeBadge() {
    if (!kIsWeb) {
      FlutterAppBadger.removeBadge();
    }
  }
}
