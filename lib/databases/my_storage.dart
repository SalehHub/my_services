import '../my_services.dart';

class MyStorageKeys {
  String accessTokenKey = 'accessToken';
  String isFirstAppRun = 'isFirstAppRunKey';
  String isFirstAppBuildRun = 'isFirstAppBuildRunKey';
  String localeKey = 'locale';
  String themeModeKey = 'themeMode';
}

abstract class MyStorage {
  Future<dynamic> getDatabase();

  Future<String?> query(String key, [int? minutes]);

  Future<int?> liveInMinutes(String key);

  Future<dynamic> get(String key, [int? minutes]);

  Future<bool> set(String key, String? value, {bool replaceExist = true});

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
}
