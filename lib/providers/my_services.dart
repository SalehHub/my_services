import '../my_services.dart';

class MyServices {
  const MyServices._();
  static const MyServices _s = MyServices._();
  factory MyServices() => _s;

  //
  static MyStorage storage = MyStorageSQLite(); //MyStorageHive();
  static final Helpers helpers = Helpers();
  static final _Services services = _Services();
  static final _Providers providers = _Providers();

  // App Config
  static AppConfig appConfig = AppConfig();

  // App Events
  static AppEvents appEvents = AppEvents();
}

class _Providers {
  const _Providers._();
  static const _Providers _s = _Providers._();
  factory _Providers() => _s;
  //
  // static GeneralState _readGeneralState(dynamic ref) => ref.read(generalStateProvider);
  GeneralStateNotifier _readGeneralStateNotifier(dynamic ref) => ref.read(generalStateProvider.notifier);
  Future<void> setAccessToken(dynamic ref, String? value) => _readGeneralStateNotifier(ref).setAccessToken(value);
  Map<String, dynamic> asMap(Ref ref) => _readGeneralStateNotifier(ref).asMap;
  //
  String? watchAccessToken(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.accessToken));
  String? readAccessToken(dynamic ref) => ref.read(generalStateProvider).accessToken;
  //
  ThemeMode? watchThemeMode(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.themeMode));
  ThemeMode? readThemeMode(dynamic ref) => ref.read(generalStateProvider).themeMode;
  //
  bool watchIsFirstAppBuildRun(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.isFirstAppBuildRun));
  bool readIsFirstAppBuildRun(dynamic ref) => ref.read(generalStateProvider).isFirstAppBuildRun;
  //
  bool watchIsFirstAppRun(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.isFirstAppRun));
  bool readIsFirstAppRun(dynamic ref) => ref.read(generalStateProvider).isFirstAppRun;
  //
  Locale? watchLocale(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.locale));
  Locale? readLocale(dynamic ref) => ref.read(generalStateProvider).locale;
  //
  String? watchNotificationToken(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.notificationToken));
  String? readNotificationToken(dynamic ref) => ref.read(generalStateProvider).notificationToken;
  //
  AppDeviceData? watchAppDeviceData(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData));
  AppDeviceData? readAppDeviceData(dynamic ref) => ref.read(generalStateProvider).appDeviceData;
  //
}

class _Services {
  _Services._();
  static final _Services _s = _Services._();
  factory _Services() => _s;
  //
  final ServiceURLLauncher urlLauncher = ServiceURLLauncher();
  final ServiceTheme theme = ServiceTheme();
  final ServiceSnackBar snackBar = ServiceSnackBar();
  final ServiceNav nav = ServiceNav();
  final ServiceLocale locale = ServiceLocale();
  final ServiceLoader loader = ServiceLoader();

  final ServiceDialog dialog = ServiceDialog();
  final ServiceDebounce debounce = ServiceDebounce();
  final ServiceColor color = ServiceColor();
  final ServiceAppDevice appDevice = ServiceAppDevice();
  final ServiceApi api = ServiceApi();

  final ServiceShare share = ServiceShare(); //sharePlus
  final ServiceImagePicker imagePicker = ServiceImagePicker(); //imagePicker
  final ServiceFirebaseCrashlytics firebaseCrashlytics = ServiceFirebaseCrashlytics(); //firebaseCrashlytics
  final ServiceFirebaseMessaging firebaseMessaging = ServiceFirebaseMessaging(); //firebaseMessaging
  final ServiceDynamicLink dynamicLink = ServiceDynamicLink(); //appLinks
  final ServiceAppBadger appBadger = ServiceAppBadger(); //flutterAppBadger
  ServiceGoogleMapsCluster googleMapsCluster(ref) => ServiceGoogleMapsCluster(ref); //googleMaps
}
