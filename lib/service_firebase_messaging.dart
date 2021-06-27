import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

enum FirebaseMessagingPlace {
  getInitialMessage,
  onMessageOpenedApp,
  onMessage,
}

typedef OnFirebaseNotification = Function(BuildContext context, RemoteMessage? message, FirebaseMessagingPlace s);

class ServiceFirebaseMessaging {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<String?> getToken() => _firebaseMessaging.getToken();

  static Future<NotificationSettings> requestPermission() => _firebaseMessaging.requestPermission();

  static Future<void> registerFirebaseMessaging(BuildContext context, {required OnFirebaseNotification onFirebaseNotification}) async {
    final RemoteMessage? message = await _firebaseMessaging.getInitialMessage();
    await onFirebaseNotification(context, message, FirebaseMessagingPlace.getInitialMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onFirebaseNotification(context, message, FirebaseMessagingPlace.onMessageOpenedApp);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      onFirebaseNotification(context, message, FirebaseMessagingPlace.onMessage);
    });
  }
}
