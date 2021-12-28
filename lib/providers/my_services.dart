import '../my_services.dart';
import 'general_state_provider.dart';

class MyServices {
  MyServices._();

  static ThemeMode? watchThemeMode(WidgetRef ref) => ref.watch(generalStateProvider.select((s) => s.themeMode));
  static Locale? watchLocale(WidgetRef ref) => ref.watch(generalStateProvider.select((s) => s.locale));
  static String? watchAppBuild(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData?.appBuild));
  static bool watchIsFirstAppRun(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.isFirstAppRun));

  static ThemeMode? readThemeMode(WidgetRef ref) => _readGeneralState(ref).themeMode;
  static String? readAppBuild(dynamic ref) => _readGeneralState(ref).appDeviceData?.appBuild;
  static bool readIsFirstAppRun(WidgetRef ref) => _readGeneralState(ref).isFirstAppRun;
  static String? readAccessToken(dynamic ref) => _readGeneralState(ref).accessToken;

  static Future<void> setAccessToken(dynamic ref, String? value) => _readGeneralStateNotifier(ref).setAccessToken(value);
  static void setLocaleWithoutSaving(dynamic ref, Locale value) => _readGeneralStateNotifier(ref).setLocaleWithoutSaving(value);
  static void setThemeMode(dynamic ref, BuildContext context, ThemeMode value) => _readGeneralStateNotifier(ref).setThemeMode(context, value);
  static void setLocale(dynamic ref, Locale value) => _readGeneralStateNotifier(ref).setLocale(value);

  static Map<String, dynamic> asMap(Ref ref) => _readGeneralStateNotifier(ref).asMap;

  static GeneralStateNotifier _readGeneralStateNotifier(dynamic ref) => ref.read(generalStateProvider.notifier);
  static GeneralState _readGeneralState(dynamic ref) => ref.read(generalStateProvider);
}
