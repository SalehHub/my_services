//hive
import '../my_services.dart';

class MyStorageHive extends MyStorageKeys implements MyStorage {
  MyStorageHive._();

  factory MyStorageHive() => _singleton;
  static final MyStorageHive _singleton = MyStorageHive._();

  static Box<Map<dynamic, dynamic>>? _box;

  @override
  Future getDatabase() async {
    if (_box == null) {
      await Hive.initFlutter();
      _box = await Hive.openBox<Map<dynamic, dynamic>>('app4');
    }
    return _box!;
  }

  @override
  Future<bool> set(String key, String? value, {bool replaceExist = true}) async {
    try {
      await getDatabase().then((database) {
        database.put(key, <dynamic, dynamic>{
          'key': key,
          'value': value,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        });
      });
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> setAccessToken(String? accessToken, {bool replaceExist = true}) {
    return set(accessTokenKey, accessToken, replaceExist: replaceExist);
  }

  @override
  Future<bool> setLocale(Locale locale, {bool replaceExist = true}) {
    return set(localeKey, locale.languageCode, replaceExist: replaceExist);
  }

  @override
  Future<bool> setThemeMode(ThemeMode themeMode, {bool replaceExist = true}) {
    return set(themeModeKey, themeMode.toString(), replaceExist: replaceExist);
  }

  @override
  Future<dynamic> get(String key, [int? minutes]) async {
    final String? value = await query(key, minutes);
    if (value != null) {
      return jsonDecode(value);
    }
    return null;
  }

  @override
  Future<bool> getIsFirstAppRun() async {
    final String? data = await query(isFirstAppRun);

    if (data == null) {
      await set(isFirstAppRun, 'false');
      return true;
    }

    return false;
  }

  @override
  Future<bool> getIsFirstAppBuildRun(String build) async {
    final String _key = isFirstAppBuildRun + build;
    final String? data = await query(_key);

    if (data == null) {
      await set(_key, 'false');
      return true;
    }

    return false;
  }

  @override
  Future<String?> getAccessToken() async {
    return query(accessTokenKey);
  }

  @override
  Future<Locale> getLocale() async {
    try {
      final String? value = await query(localeKey);
      if (value != null && ServiceLocale.isSupportedLocale(Locale(value))) {
        return Locale(value);
      }
      //if no stored locale then try to get device locale if it is supported
      final Locale? deviceLocale = WidgetsBinding.instance?.window.locales.first;
      if (deviceLocale != null && ServiceLocale.isSupportedLocale(deviceLocale)) {
        return Locale(deviceLocale.languageCode);
      }
    } catch (e, s) {
      logger.e(e, e, s);
    }
    return ServiceLocale.defaultLocale;
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final String? value = await query(themeModeKey);
    if (value == ThemeMode.light.toString()) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      return ThemeMode.light;
    } else if (value == ThemeMode.dark.toString()) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  @override
  Future<String?> query(String key, [int? minutes]) async {
    try {
      final maps = (await getDatabase()).get(key, defaultValue: <dynamic, dynamic>{});
      if (maps.isNotEmpty) {
        String? value = maps['value'] as String?;
        if (minutes == null) {
          return value;
        }

        int? createdAt = maps['createdAt'] as int?;
        print(createdAt);
        if (createdAt != null) {
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
          int difference = DateTime.now().difference(dateTime).inMinutes;
          print(difference);
          if (difference > minutes) {
            delete(key);
            return null;
          } else {
            return value;
          }
        }
      }
    } catch (e, s) {
      logger.e(e, e, s);
    }
    return null;
  }

  @override
  Future<bool> delete(String key) async {
    try {
      await getDatabase().then((database) {
        return database.delete(key);
      });
    } catch (e) {
      return false;
    }
    return true;
  }
}
