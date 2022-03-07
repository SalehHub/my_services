//sqflite
import '../my_services.dart';

class MyStorageSQLite extends MyStorageKeys implements MyStorage {
  MyStorageSQLite._();
  static final MyStorageSQLite _s = MyStorageSQLite._();
  factory MyStorageSQLite() => _s;

  static Database? _database;
  static const String tableName = 'keyValue';
  static const String databaseCreatingQuery = 'CREATE TABLE $tableName (key TEXT PRIMARY KEY, value TEXT, createdAt INTEGER)';
  static const int databaseVersion = 1;
  static const String databaseName = 'keyValueDB.db';

  @override
  Future getDatabase() async {
    if (_database == null) {
      final applicationDocumentsDirectoryPath = await Helpers.getApplicationDocumentsPath();
      final keyValueDatabasePath = '${applicationDocumentsDirectoryPath!}/$databaseName';
      _database ??= await openDatabase(
        keyValueDatabasePath,
        version: databaseVersion,
        onCreate: (Database db, int version) async {
          await db.execute(databaseCreatingQuery);
        },
      );
    }
    return _database!;
  }

  Future<int?> count() async {
    return Sqflite.firstIntValue(
      await (await getDatabase()).rawQuery('SELECT COUNT(*) FROM $tableName'),
    );
  }

  @override
  Future<bool> set(String key, String? value, {bool replaceExist = true}) async {
    try {
      await getDatabase().then((database) {
        database.insert(
          tableName,
          <String, Object?>{
            'key': key,
            'value': value,
            'createdAt': DateTime.now().millisecondsSinceEpoch,
          },
          conflictAlgorithm: replaceExist ? ConflictAlgorithm.replace : ConflictAlgorithm.ignore,
        );
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
      return jsonDecode(value);
    }
    return null;
  }

  @override
  Future<int?> liveInMinutes(String key) async {
    final List<Map<String, Object?>> maps = await (await getDatabase()).query(
      tableName,
      where: 'key = ?',
      whereArgs: <String>[key],
    );
    if (maps.isNotEmpty) {
      final createdAt = maps.first['createdAt'] as int?;
      if (createdAt != null) {
        return DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(createdAt)).inMinutes;
      }
    }
    return null;
  }

  @override
  Future<String?> query(String key, [int? minutes]) async {
    final List<Map<String, Object?>> maps = await (await getDatabase()).query(
      tableName,
      where: 'key = ?',
      whereArgs: <String>[key],
    );
    if (maps.isNotEmpty) {
      String? value = maps.first['value'] as String?;
      if (minutes == null) {
        return value;
      }

      int? createdAt = maps.first['createdAt'] as int?;
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
    return null;
  }

  @override
  Future<bool> delete(String key) async {
    try {
      await getDatabase().then((database) {
        database.delete(
          tableName,
          where: 'key = ?',
          whereArgs: <String>[key],
        );
      });
    } catch (e) {
      return false;
    }
    return true;
  }

//TODO: remove this in favor of setGeneralState
  // @override
  // Future<bool> setAccessToken(String? accessToken, {bool replaceExist = true}) {
  //   return set(accessTokenKey, accessToken, replaceExist: replaceExist);
  // }

//TODO: remove this in favor of setGeneralState
  // @override
  // Future<bool> setLocale(Locale locale, {bool replaceExist = true}) {
  //   return set(localeKey, locale.languageCode, replaceExist: replaceExist);
  // }

//TODO: remove this in favor of setGeneralState
  // @override
  // Future<bool> setThemeMode(ThemeMode themeMode, {bool replaceExist = true}) {
  //   return set(themeModeKey, themeMode.toString(), replaceExist: replaceExist);
  // }

//TODO: remove this in favor of setGeneralState
  @override
  Future<bool> getIsFirstAppRun() async {
    final String? data = await query(isFirstAppRun);

    if (data == null) {
      await set(isFirstAppRun, 'false');
      return true;
    }

    return false;
  }

//TODO: remove this in favor of setGeneralState
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

//TODO: remove this in favor of setGeneralState
  @override
  Future<String?> getAccessToken() async {
    return query(accessTokenKey);
  }

//TODO: remove this in favor of setGeneralState
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

//TODO: remove this in favor of setGeneralState
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
  Future setGeneralState(Map<String, dynamic>? value) {
    return set(generalStateKey, value == null ? null : jsonEncode(value));
  }

  @override
  Future<GeneralState?> getGeneralState() async {
    try {
      final Map<String, dynamic>? data = await get(generalStateKey, 3);
      if (data != null) {
        return GeneralState.fromJson(data);
      }
    } catch (e, s) {
      logger.e(e, e, s);
    }
    return null;
  }
}
