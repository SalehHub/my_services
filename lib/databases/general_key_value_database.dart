import '../my_services.dart';

Database? _database;

class GeneralKeyValueDatabase {
  static Future<Database> getDatabase() async {
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

  // static const String tableName = 'GeneralKeyValue';
  // static const String databaseCreatingQuery = 'CREATE TABLE $tableName (key TEXT PRIMARY KEY, value TEXT, createdAt INTEGER)';
  // static const int databaseVersion = 1;
  // static const String databaseName = '${tableName}DB.db';

  static const String tableName = 'keyValue';
  static const String databaseCreatingQuery = 'CREATE TABLE $tableName (key TEXT PRIMARY KEY, value TEXT, createdAt INTEGER)';
  static const int databaseVersion = 1;
  static const String databaseName = 'keyValueDB.db';

  static const String accessTokenKey = 'accessToken';
  static const String isFirstAppRun = 'isFirstAppRunKey';
  static const String isFirstAppBuildRun = 'isFirstAppBuildRunKey';
  static const String localeKey = 'locale';
  static const String themeModeKey = 'themeMode';

  static Future<int?> count() async {
    final database = await getDatabase();
    return Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM $tableName'),
    );
  }

  static Future<int> set(String key, String? value, {bool replaceExist = true}) {
    return getDatabase().then((Database database) {
      return database.insert(
        tableName,
        <String, Object?>{
          'key': key,
          'value': value,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: replaceExist ? ConflictAlgorithm.replace : ConflictAlgorithm.ignore,
      );
    });
  }

  static Future<int> setAccessToken(String? accessToken, {bool replaceExist = true}) {
    return set(accessTokenKey, accessToken, replaceExist: replaceExist);
  }

  static Future<int> setLocale(Locale locale, {bool replaceExist = true}) {
    return set(localeKey, locale.languageCode);
  }

  static Future<int> setThemeMode(ThemeMode themeMode, {bool replaceExist = true}) {
    return set(themeModeKey, themeMode.toString());
  }

  static Future<dynamic> get(String key) async {
    final String? value = await query(key);
    if (value != null) {
      return jsonDecode(value);
    }
    return null;
  }

  static Future<bool> getIsFirstAppRun() async {
    final String? data = await query(isFirstAppRun);

    if (data == null) {
      await set(isFirstAppRun, 'false');
      return true;
    }

    return false;
  }

  static Future<bool> getIsFirstAppBuildRun(String build) async {
    //final String build = readAppState(context).appDeviceData.appBuild;
    final String _key = isFirstAppBuildRun + build;

    final String? data = await query(_key);

    if (data == null) {
      await set(_key, 'false');
      return true;
    }

    return false;
  }

  static Future<String?> getAccessToken() async {
    return query(accessTokenKey);
  }

  static Future<Locale> getLocale() async {
    try {
      final String? value = await query(localeKey);
      if (value == null) {
        final Locale? deviceLocale = WidgetsBinding.instance?.window.locales.first;
        if (deviceLocale != null && ServiceLocale.isSupportedLocale(deviceLocale)) {
          return Locale(deviceLocale.languageCode);
        }
      } else {
        if (ServiceLocale.isSupportedLocale(Locale(value))) {
          return Locale(value);
        }
      }
    } catch (e, s) {
      logger.e(e, e, s);
    }
    return ServiceLocale.defaultLocale;
  }

  static Future<ThemeMode> getThemeMode() async {
    final String? value = await query(themeModeKey);
    if (value != null) {
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
    return ThemeMode.system;
  }

  static Future<String?> query(String key) async {
    final Database database = await getDatabase();

    final List<Map<String, Object?>> maps = await database.query(
      tableName,
      where: 'key = ?',
      whereArgs: <String>[key],
    );
    if (maps.isNotEmpty) {
      return maps.first['value'] as String?;
    }
    return null;
  }

  static Future<int> delete(String key) {
    return getDatabase().then((Database database) {
      return database.delete(
        tableName,
        where: 'key = ?',
        whereArgs: <String>[key],
      );
    });
  }
}
