import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../icons.dart';

class NoNotificationPermissionCard extends StatefulWidget {
  const NoNotificationPermissionCard({Key? key}) : super(key: key);

  @override
  _NoNotificationPermissionCardState createState() => _NoNotificationPermissionCardState();
}

class _NoNotificationPermissionCardState extends State<NoNotificationPermissionCard> with WidgetsBindingObserver {
  NotificationSettings settings = const NotificationSettings(
    authorizationStatus: AuthorizationStatus.authorized,
    alert: AppleNotificationSetting.enabled,
    badge: AppleNotificationSetting.enabled,
    announcement: AppleNotificationSetting.enabled,
    notificationCenter: AppleNotificationSetting.enabled,
    carPlay: AppleNotificationSetting.enabled,
    lockScreen: AppleNotificationSetting.enabled,
    sound: AppleNotificationSetting.enabled,
    showPreviews: AppleShowPreviewSetting.always,
  );

  Future<void> init() async {
    settings = await FirebaseMessaging.instance.getNotificationSettings();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      init();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      return GestureDetector(
        onTap: AppSettings.openNotificationSettings,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.purple.shade900, width: 2),
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue.shade600,
          ),
          child: Row(
            children: const <Widget>[
              Expanded(
                child: Text(
                  'الاشعارات للتطبيق معطلة من إعدادات الجهاز',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              IconButton(
                color: Colors.white,
                onPressed: AppSettings.openNotificationSettings,
                icon: Icon(iconSettings),
              )
            ],
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
