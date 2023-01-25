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
  Future<bool> set(String key, dynamic value, {bool replaceExist = true}) async {
    try {
      await getDatabase().then((database) {
        database.put(key, <dynamic, dynamic>{
          'key': key,
          'value': jsonEncode(value),
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        });
      });
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Future<dynamic> get(String key, [int? minutes]) async {
    final String? value = await query(key, minutes);
    if (value != null) {
      try {
        return jsonDecode(value);
      } on FormatException catch (e, s) {
        logger.e(e, e, s);
        return value;
      } catch (e, s) {
        logger.e(e, e, s);
      }
    }
    return null;
  }

  @override
  Future<int?> liveInMinutes(String key) async {
    final maps = (await getDatabase()).get(key, defaultValue: <dynamic, dynamic>{});

    if (maps.isNotEmpty) {
      final createdAt = maps['createdAt'] as int?;
      if (createdAt != null) {
        return DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(createdAt)).inMinutes;
      }
    }
    return null;
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
        if (createdAt != null) {
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
          int difference = DateTime.now().difference(dateTime).inMinutes;
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

  @override
  Future<bool> setAccessToken(String? accessToken, {bool replaceExist = true}) => set(accessTokenKey, accessToken, replaceExist: replaceExist);

  @override
  Future<bool> setLocale(Locale locale, {bool replaceExist = true}) => set(localeKey, locale.languageCode, replaceExist: replaceExist);

  @override
  Future<bool> setThemeMode(ThemeMode themeMode, {bool replaceExist = true}) => set(themeModeKey, themeMode.toString(), replaceExist: replaceExist);

  @override
  Future<bool> getIsFirstAppRun() async {
    final bool? data = await get(isFirstAppRun);

    if (data == null) {
      await set(isFirstAppRun, false);
      return true;
    }

    return false;
  }

  @override
  Future<bool> getIsFirstAppBuildRun(String build) async {
    final String key = isFirstAppBuildRun + build;
    final bool? data = await get(key);

    if (data == null) {
      await set(key, false);
      return true;
    }

    return false;
  }

  @override
  Future<String?> getAccessToken() async => await get(accessTokenKey);

  @override
  Future<Locale> getLocale() async {
    try {
      //if no stored locale then try to get device locale if it is supported
      final Locale deviceLocale = WidgetsBinding.instance.window.locales.first;

      if (MyServices.appConfig.nativeLocaleChange) {
        if (MyServices.services.locale.isSupportedLocale(deviceLocale)) {
          return Locale(deviceLocale.languageCode);
        }
      } else {
        final String? value = await get(localeKey);
        if (value != null && MyServices.services.locale.isSupportedLocale(Locale(value))) {
          return Locale(value);
        }
      }

      //

      if (MyServices.services.locale.isSupportedLocale(deviceLocale)) {
        return Locale(deviceLocale.languageCode);
      }
    } catch (e, s) {
      logger.e(e, e, s);
    }

    return MyServices.services.locale.defaultLocale;
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final String? value = await get(themeModeKey);
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

  // @override
  // Future setGeneralState(Map<String, dynamic>? value) => set(generalStateKey, value == null ? null : jsonEncode(value));

  // @override
  // Future<GeneralState?> getGeneralState() async {
  //   try {
  //     final Map<String, dynamic>? data = await get(generalStateKey, 3);
  //     if (data != null) {
  //       return GeneralState.fromJson(data);
  //     }
  //   } catch (e, s) {
  //     logger.e(e, e, s);
  //   }
  //   return null;
  // }
}
