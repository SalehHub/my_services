//firebaseCrashlytics
import '../my_services.dart';

class ServiceFirebaseCrashlytics {
  static final FirebaseCrashlytics _firebaseCrashlytics = FirebaseCrashlytics.instance;

  static final RawReceivePort _rawReceivePort = RawReceivePort((List<dynamic> errorAndStacktrace) async {
    await _firebaseCrashlytics.recordError(errorAndStacktrace.first, errorAndStacktrace.last as StackTrace);
  });

  static Future<void> register() async {
    if (kDebugMode) {
      await _firebaseCrashlytics.setCrashlyticsCollectionEnabled(false);
    } else {
      await _firebaseCrashlytics.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = _firebaseCrashlytics.recordFlutterError;
      Isolate.current.addErrorListener(_rawReceivePort.sendPort);
    }
  }

  static Future<void> setUserIdentifier(String identifier) async {
    if (!kIsWeb) {
      //TODO: remove when web get supported
      return _firebaseCrashlytics.setUserIdentifier(identifier);
    }
  }
}
