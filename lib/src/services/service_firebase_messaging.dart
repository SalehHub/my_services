//firebaseMessaging
import '../../my_services.dart';

enum FirebaseMessagingPlace {
  getInitialMessage,
  onMessageOpenedApp,
  onMessage,
}

typedef OnFirebaseNotification = Function(WidgetRef ref, RemoteMessage? message, FirebaseMessagingPlace s);

class ServiceFirebaseMessaging {
  // static const ServiceFirebaseMessaging _s = ServiceFirebaseMessaging._();
  // factory ServiceFirebaseMessaging() => _s;
  // const ServiceFirebaseMessaging._();
  const ServiceFirebaseMessaging();
  //
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    try {
      return (await _firebaseMessaging.getToken());
    } on PlatformException catch (e, s) {
      logger.e(e, error: e, stackTrace: s);
    } catch (e, s) {
      logger.e(e, error: e, stackTrace: s);
    }
    return Future.value(null);
  }

  StreamSubscription<String> onTokenRefresh(Function(String) fun) => _firebaseMessaging.onTokenRefresh.listen(fun);

  Future<NotificationSettings?> requestPermission() async {
    try {
      return (await _firebaseMessaging.requestPermission());
    } on PlatformException catch (e, s) {
      logger.e(e, error: e, stackTrace: s);
    } catch (e, s) {
      logger.e(e, error: e, stackTrace: s);
    }
    return Future.value(null);
  }

  Future<void> registerFirebaseMessaging(WidgetRef ref, {required OnFirebaseNotification onFirebaseNotification}) async {
    final RemoteMessage? message = await _firebaseMessaging.getInitialMessage();
    await onFirebaseNotification(ref, message, FirebaseMessagingPlace.getInitialMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onFirebaseNotification(ref, message, FirebaseMessagingPlace.onMessageOpenedApp);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      onFirebaseNotification(ref, message, FirebaseMessagingPlace.onMessage);
    });
  }

  static Function? _initialMessage;
  void setInitialMessage(Function initialMessage) => _initialMessage = initialMessage;
  void callInitialMessage() {
    if (_initialMessage != null) {
      _initialMessage!();
      _initialMessage = null;
    }
  }
}
