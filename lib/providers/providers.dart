import '../my_services.dart';
import 'general_state_provider.dart';

class Providers {
  // static GeneralState _readGeneralState(dynamic ref) => ref.read(generalStateProvider);
  GeneralStateNotifier _readGeneralStateNotifier(dynamic ref) => ref.read(generalStateProvider.notifier);

  Future<void> setAccessToken(dynamic ref, String? value) => _readGeneralStateNotifier(ref).setAccessToken(value);
  Future<void> setThemeMode(dynamic ref, BuildContext context, ThemeMode value) => _readGeneralStateNotifier(ref).setThemeMode(context, value);
  Future<void> setLocale(dynamic ref, Locale value) => _readGeneralStateNotifier(ref).setLocale(value);
  Future<void> toggleThemeMode(dynamic ref, BuildContext context) => _readGeneralStateNotifier(ref).toggleThemeMode(context);
  //
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
  void onLocaleChange(WidgetRef ref, Function(Locale? previous, Locale? next) listener) {
    ref.listen<Locale?>(generalStateProvider.select((s) => s.locale), listener);
  }

  //
  String? watchNotificationToken(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.notificationToken));
  String? readNotificationToken(dynamic ref) => ref.read(generalStateProvider).notificationToken;
  //
  String? watchAppBuild(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData?.appBuild));
  String? readAppBuild(dynamic ref) => ref.read(generalStateProvider).appDeviceData?.appBuild;
  //
  // AppDeviceData? watchAppDeviceData(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData));
  // AppDeviceData? readAppDeviceData(dynamic ref) => ref.read(generalStateProvider).appDeviceData;
  //
  // String? watchAppVersion(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData?.appVersion));
  // String? readAppVersion(dynamic ref) => ref.read(generalStateProvider).appDeviceData?.appVersion;
  //
}
