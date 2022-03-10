import '../my_services.dart';

class Providers {
  // static GeneralState _readGeneralState(dynamic ref) => ref.read(generalStateProvider);
  GeneralStateNotifier _readGeneralStateNotifier(dynamic ref) => ref.read(generalStateProvider.notifier);
  Future<void> setAccessToken(dynamic ref, String? value) => _readGeneralStateNotifier(ref).setAccessToken(value);
  void toggleThemeMode(dynamic ref, BuildContext context) => _readGeneralStateNotifier(ref).toggleThemeMode(context);
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
