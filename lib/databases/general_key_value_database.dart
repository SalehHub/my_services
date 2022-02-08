import '../my_services.dart';

class GeneralKeyValueDatabase {
  GeneralKeyValueDatabase._();

  factory GeneralKeyValueDatabase() => _singleton;
  static final GeneralKeyValueDatabase _singleton = GeneralKeyValueDatabase._();

  static MyStorage get _myStorage {
    return MyStorageHive(); //hive
    // ignore: dead_code
    return MyStorageSQLite(); //sqflite
  }

  static Future getDatabase() => _myStorage.getDatabase();
  static Future get(String key, [int? minutes]) => _myStorage.get(key, minutes);
  static Future<bool> set(String key, String? value, {bool replaceExist = true}) => _myStorage.set(key, value, replaceExist: replaceExist);
  static Future<String?> query(String key, [int? minutes]) => _myStorage.query(key, minutes);
  static Future<bool> delete(String key) => _myStorage.delete(key);
  static Future<int?> liveInMinutes(String key) => _myStorage.liveInMinutes(key);
  static Future setGeneralState(Map<String, dynamic>? value) => _myStorage.setGeneralState(value);
  static Future<GeneralState?> getGeneralState() => _myStorage.getGeneralState();

//TODO: remove this in favor of setGeneralState
  static Future<String?> getAccessToken() => _myStorage.getAccessToken();
//TODO: remove this in favor of setGeneralState
  static Future<bool> getIsFirstAppBuildRun(String build) => _myStorage.getIsFirstAppBuildRun(build);
//TODO: remove this in favor of setGeneralState
  static Future<bool> getIsFirstAppRun() => _myStorage.getIsFirstAppRun();
//TODO: remove this in favor of setGeneralState
  static Future<Locale> getLocale() => _myStorage.getLocale();
//TODO: remove this in favor of setGeneralState
  static Future<ThemeMode> getThemeMode() => _myStorage.getThemeMode();
//TODO: remove this in favor of setGeneralState
  static Future<bool> setAccessToken(String? accessToken, {bool replaceExist = true}) => _myStorage.setAccessToken(accessToken, replaceExist: true);
//TODO: remove this in favor of setGeneralState
  static Future<bool> setLocale(Locale locale, {bool replaceExist = true}) => _myStorage.setLocale(locale, replaceExist: replaceExist);
//TODO: remove this in favor of setGeneralState
  static Future<bool> setThemeMode(ThemeMode themeMode, {bool replaceExist = true}) => _myStorage.setThemeMode(themeMode, replaceExist: replaceExist);
}
