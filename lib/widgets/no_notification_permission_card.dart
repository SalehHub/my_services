//firebaseMessaging
import '../my_services.dart';

class NoNotificationPermissionCard extends StatefulWidget {
  const NoNotificationPermissionCard({super.key});

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
    timeSensitive: AppleNotificationSetting.enabled,
    criticalAlert: AppleNotificationSetting.enabled,
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
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      final labels = getMyServicesLabels(context);

      return GestureDetector(
        onTap: () {
          AppSettings.openNotificationSettings(); //appSettings
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.purple.shade900, width: 2),
            borderRadius: MyServices.services.theme.borderRadius,
            color: getColorScheme(context).primary,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  labels.notificationsAreDisabledForThisApp,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const IconButton(
                color: Colors.white,
                onPressed: null,
                icon: Icon(iconSettings, color: Colors.white),
              )
            ],
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
