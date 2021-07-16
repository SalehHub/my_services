import 'package:firebase_messaging/firebase_messaging.dart';

import '../my_services.dart';

enum FirebaseMessagingPlace {
  getInitialMessage,
  onMessageOpenedApp,
  onMessage,
}

typedef OnFirebaseNotification = Function(RemoteMessage? message, FirebaseMessagingPlace s, {WidgetRef ref});

class ServiceFirebaseMessaging {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<String?> getToken() => _firebaseMessaging.getToken();

  static Future<NotificationSettings> requestPermission() => _firebaseMessaging.requestPermission();

  static Future<void> registerFirebaseMessaging(WidgetRef ref, {required OnFirebaseNotification onFirebaseNotification}) async {
    final RemoteMessage? message = await _firebaseMessaging.getInitialMessage();
    await onFirebaseNotification(message, FirebaseMessagingPlace.getInitialMessage, ref: ref);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onFirebaseNotification(message, FirebaseMessagingPlace.onMessageOpenedApp, ref: ref);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      onFirebaseNotification(message, FirebaseMessagingPlace.onMessage, ref: ref);
    });
  }
}
