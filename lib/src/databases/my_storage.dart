import '../../my_services.dart';

class MyStorageKeys {
  const MyStorageKeys();

  final String accessTokenKey = 'accessToken';
  final String isFirstAppRun = 'isFirstAppRunKey';
  final String isFirstAppBuildRun = 'isFirstAppBuildRunKey';
  final String localeKey = 'locale';
  final String themeModeKey = 'themeMode';
  final String generalStateKey = 'generalStateKey';
}

abstract class MyStorage {
  const MyStorage();

  Future<dynamic> getDatabase();

  Future<String?> query(String key, [int? minutes]);

  Future<int?> liveInMinutes(String key);

  Future<dynamic> get(String key, [int? minutes]);

  Future<bool> set(String key, dynamic value, {bool replaceExist = true});

  Future<bool> delete(String key);

  //

  Future<bool> setAccessToken(String? accessToken, {bool replaceExist = true});

  Future<bool> setLocale(Locale locale, {bool replaceExist = true});

  Future<bool> setThemeMode(ThemeMode themeMode, {bool replaceExist = true});

  //

  Future<bool> getIsFirstAppRun();

  Future<bool> getIsFirstAppBuildRun(String build);

  Future<String?> getAccessToken();

  Future<Locale> getLocale();

  Future<ThemeMode> getThemeMode();

  // Future setGeneralState(Map<String, dynamic>? value);

  // Future<GeneralState?> getGeneralState();
}
