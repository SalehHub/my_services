import '../my_services.dart';

class MyServices {
  const MyServices._();
  static const MyServices _s = MyServices._();
  factory MyServices() => _s;

  //
  static MyStorage storage = MyStorageSQLite(); //MyStorageHive();
  static final Helpers helpers = Helpers();
  static final Services services = Services();
  static final Providers providers = Providers();

  // App Config
  static AppConfig appConfig = AppConfig();

  // App Events
  static AppEvents appEvents = AppEvents();
}

class Providers {
  const Providers._();
  static const Providers _s = Providers._();
  factory Providers() => _s;
  //
  // static GeneralState _readGeneralState(dynamic ref) => ref.read(generalStateProvider);
  static GeneralStateNotifier _readGeneralStateNotifier(dynamic ref) => ref.read(generalStateProvider.notifier);
  static Future<void> setAccessToken(dynamic ref, String? value) => _readGeneralStateNotifier(ref).setAccessToken(value);
  static Map<String, dynamic> asMap(Ref ref) => _readGeneralStateNotifier(ref).asMap;
  //
  static String? watchAccessToken(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.accessToken));
  static String? readAccessToken(dynamic ref) => ref.read(generalStateProvider).accessToken;
  //
  static ThemeMode? watchThemeMode(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.themeMode));
  static ThemeMode? readThemeMode(dynamic ref) => ref.read(generalStateProvider).themeMode;
  //
  static bool watchIsFirstAppBuildRun(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.isFirstAppBuildRun));
  static bool readIsFirstAppBuildRun(dynamic ref) => ref.read(generalStateProvider).isFirstAppBuildRun;
  //
  static bool watchIsFirstAppRun(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.isFirstAppRun));
  static bool readIsFirstAppRun(dynamic ref) => ref.read(generalStateProvider).isFirstAppRun;
  //
  static Locale? watchLocale(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.locale));
  static Locale? readLocale(dynamic ref) => ref.read(generalStateProvider).locale;
  //
  static String? watchNotificationToken(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.notificationToken));
  static String? readNotificationToken(dynamic ref) => ref.read(generalStateProvider).notificationToken;
  //
  static AppDeviceData? watchAppDeviceData(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData));
  static AppDeviceData? readAppDeviceData(dynamic ref) => ref.read(generalStateProvider).appDeviceData;
  //
}

class Services {
  const Services._();
  static const Services _s = Services._();
  factory Services() => _s;
  //
  static final ServiceURLLauncher urlLauncher = ServiceURLLauncher();
  static final ServiceTheme theme = ServiceTheme();
  static final ServiceSnackBar snackBar = ServiceSnackBar();
  static final ServiceNav nav = ServiceNav();
  static final ServiceLocale locale = ServiceLocale();
  static final ServiceLoader loader = ServiceLoader();

  static final ServiceDialog dialog = ServiceDialog();
  static final ServiceDebounce debounce = ServiceDebounce();
  static final ServiceColor color = ServiceColor();
  static final ServiceAppDevice appDevice = ServiceAppDevice();
  static final ServiceApi api = ServiceApi();

  static final ServiceShare share = ServiceShare(); //sharePlus
  static final ServiceImagePicker imagePicker = ServiceImagePicker(); //imagePicker
  static final ServiceFirebaseCrashlytics firebaseCrashlytics = ServiceFirebaseCrashlytics(); //firebaseCrashlytics
  static final ServiceFirebaseMessaging firebaseMessaging = ServiceFirebaseMessaging(); //firebaseMessaging
  static final ServiceDynamicLink dynamicLink = ServiceDynamicLink(); //appLinks
  static final ServiceAppBadger appBadger = ServiceAppBadger(); //flutterAppBadger
  static ServiceGoogleMapsCluster googleMapsCluster(ref) => ServiceGoogleMapsCluster(ref); //googleMaps
}
