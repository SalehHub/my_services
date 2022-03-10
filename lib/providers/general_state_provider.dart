import '../my_services.dart';

final initialGeneralStateProvider = Provider<GeneralState>((ref) => throw UnimplementedError(''));
final generalStateProvider = StateNotifierProvider<GeneralStateNotifier, GeneralState>((ref) {
  return GeneralStateNotifier(ref.watch(initialGeneralStateProvider), ref);
});

class GeneralStateNotifier extends StateNotifier<GeneralState> {
  GeneralStateNotifier(GeneralState state, this.ref) : super(state);
  final Ref ref;

  Map<String, dynamic> get asMap => <String, dynamic>{
        // 'notification_token': state.notificationToken,
        'notificationToken': state.notificationToken,
        // 'device_id': state.appDeviceData?.deviceID,
        'deviceID': state.appDeviceData?.deviceID,
        // 'access_token': state.accessToken,
        'accessToken': state.accessToken,
        // 'lang': state.locale?.languageCode,
        'appLang': state.locale?.languageCode,
        // 'themeMode': state.themeMode.toString(),
        'appThemeMode': state.themeMode.toString(),
        //
        'appBuild': state.appDeviceData?.appBuild,
        'deviceModel': state.appDeviceData?.deviceModel,
        'deviceOSVersion': state.appDeviceData?.deviceOSVersion,
        'deviceOS': state.appDeviceData?.deviceOS,
        'isFirstAppRun': state.isFirstAppRun,
        'isFirstAppBuildRun': state.isFirstAppBuildRun,
      };

  ///app
  void setAccessToken(String? value) async {
    state = state.copyWith(accessToken: value);
    // await MyServices.storage.setAccessToken(value);
  }

  void setThemeMode(BuildContext context, ThemeMode value) {
    state = state.copyWith(themeMode: value);
    ServiceTheme.setSystemUiOverlayStyle(value, context);
    // MyServices.storage.setThemeMode(value);
  }

  void toggleThemeMode(BuildContext context) {
    if (isDark(context)) {
      setThemeMode(context, ThemeMode.light);
    } else {
      setThemeMode(context, ThemeMode.dark);
    }
  }

  void setLocale(Locale value) {
    setLocaleWithoutSaving(value);
    // MyServices.storage.setLocale(value);
  }

  void setLocaleWithoutSaving(Locale value) {
    state = state.copyWith(locale: value);
  }
}

Future<GeneralState> getGeneralState() async {
  logger.w('Getting GeneralState ...');

  String? notificationToken;
  String? accessToken;
  Locale? locale;
  ThemeMode? themeMode;
  bool isFirstAppRun = false;
  bool isFirstAppBuildRun = false;
  late AppDeviceData appDeviceData;

  await Future.wait<dynamic>(
    <Future<dynamic>>[
      //-----------------------------------------------------------------//

      MyServices.helpers.getApplicationDocumentsPath().then<dynamic>((_) async {
        appDeviceData = await ServiceAppDevice.getAppAndDeviceData();
        //
        isFirstAppRun = await MyServices.storage.getIsFirstAppRun();
        isFirstAppBuildRun = await MyServices.storage.getIsFirstAppBuildRun(appDeviceData.appBuild);
        //
        accessToken = await MyServices.storage.getAccessToken();
        //
        locale = await MyServices.storage.getLocale();
        //
        themeMode = await MyServices.storage.getThemeMode();
      }),

      //-----------------------------------------------------------------//

      if (MyServices.appConfig.withFCM) ServiceFirebaseMessaging.getToken().then<String?>((String? value) => notificationToken = value), //firebaseMessaging

      //-----------------------------------------------------------------//
    ],
  );

  final GeneralState generalState = GeneralState(
    accessToken: accessToken,
    notificationToken: notificationToken,
    appDeviceData: appDeviceData,
    //
    locale: locale,
    themeMode: themeMode,
    //
    isFirstAppRun: isFirstAppRun,
    isFirstAppBuildRun: isFirstAppBuildRun,
  );

  return generalState;
}

class GeneralStateSaver extends ProviderObserver {
  const GeneralStateSaver();

  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    if (newValue is GeneralState && previousValue is GeneralState) {
      if (newValue != previousValue) {
        //theme
        if (newValue.themeMode != null && newValue.themeMode != previousValue.themeMode) {
          MyServices.storage.setThemeMode(newValue.themeMode!);
          logger.w("New themeMode Saved");
        }
        //locale
        if (newValue.locale != null && newValue.locale != previousValue.locale) {
          MyServices.storage.setLocale(newValue.locale!);
          logger.w("New locale Saved");
        }
        //accessToken
        if (newValue.accessToken != previousValue.accessToken) {
          MyServices.storage.setAccessToken(newValue.accessToken);
          logger.w("New accessToken Saved");
        }
      }
    }
  }
}
