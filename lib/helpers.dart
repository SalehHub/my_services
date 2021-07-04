import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart';

import 'models/app_device_data.dart';
import 'my_services.dart';

final Logger logger = Logger();

class Helpers {
  static TextDirection getTextDirection(String text) => isRTL(text) ? TextDirection.rtl : TextDirection.ltr;

  static bool isRTL(String text) => Bidi.detectRtlDirectionality(text);

  static bool isLandScape(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Orientation pageOrientation = mediaQueryData.orientation;
    final bool isPageOrientationLandScape = pageOrientation == Orientation.landscape;
    return isPageOrientationLandScape;
  }

  static double getPageWidth(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size.width;
  }

  static List<Shadow> getTextStroke(double strokeWidth, Color strokeColor) {
    return [
      // bottomLeft
      Shadow(
        offset: Offset(-strokeWidth, -strokeWidth),
        color: strokeColor,
        blurRadius: 1,
      ),
      Shadow(
        // bottomRight
        offset: Offset(strokeWidth, -strokeWidth),
        color: strokeColor,
        blurRadius: 1,
      ),
      Shadow(
        // topRight
        offset: Offset(strokeWidth, strokeWidth),
        color: strokeColor,
        blurRadius: 1,
      ),
      Shadow(
        // topLeft
        offset: Offset(-strokeWidth, strokeWidth),
        color: strokeColor,
        blurRadius: 1,
      ),
    ];
  }

  static String indianToArabicNumbers(String text) {
    return text
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');
    //return text;
  }

  static void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static bool isArabicText(String text) {
    const String arabicLetters = 'ةجحخهعغفقثصضشسيبلاتنمكورزدذطظؤآءئإأ';
    for (final String c in text.split('')) {
      if (arabicLetters.contains(c)) {
        return true;
      }
    }

    return false;
  }

//////////

  static String getFileSize(String filepath, [int decimals = 3]) {
    final File file = File(filepath);
    final int bytes = file.lengthSync();
    if (bytes <= 0) {
      return '0 B';
    }
    const List<String> suffixes = <String>['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final int i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

//////////

  static Future<void> waitForSeconds([int seconds = 2]) => Future<void>.delayed(Duration(seconds: seconds));

  static Future<void> waitForMilliseconds([int milliseconds = 200]) => Future<void>.delayed(Duration(milliseconds: milliseconds));

///////
  static Future<Directory?> _getApplicationDocumentsDirectory() async {
    if (!kIsWeb) {
      return getApplicationDocumentsDirectory();
    }
    return null;
  }

  static String? _applicationDocumentsDirectoryPath;
  static bool printed = false;

  static Future<String?> getApplicationDocumentsPath() async {
    if (printed == false && _applicationDocumentsDirectoryPath != null) {
      logger.i(_applicationDocumentsDirectoryPath);
      printed = true;
    }
    return _applicationDocumentsDirectoryPath ??= (await _getApplicationDocumentsDirectory())?.path;
  }

  static final Map<String, LookupMessages> _lookupMessagesMap = {
    'ar': ArMessages(),
    'ar_short': ArShortMessages(),
    //
    'en': EnMessages(),
    'en_short': EnShortMessages(),
    //
    'es': EsMessages(),
    'es_short': EsShortMessages(),
    //
    'fr': FrMessages(),
    'fr_short': FrShortMessages(),
    //
    'tr': TrMessages(),
  };

  static String getTimeAgo(DateTime time, [String? langCode]) {
    String? _langCode = langCode;

    if (_langCode == null) {
      final BuildContext? context = ServiceNav.navigatorKey.currentContext;
      Locale? locale;
      if (context != null) {
        locale = Localizations.localeOf(context);
      }

      _langCode = locale?.languageCode.toLowerCase() ?? 'en';
    }

    final LookupMessages lookupMessages = _lookupMessagesMap[_langCode] ?? EnMessages();

    try {
      setLocaleMessages(_langCode, lookupMessages);
      final String timeAgo = format(time, locale: _langCode);
      return timeAgo;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

//////

  static Future<AppDeviceData> getAppAndDeviceData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    late String deviceId;
    late String osVersion;
    late String deviceModel;

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.androidId;
      osVersion = androidInfo.version.release;
      deviceModel = androidInfo.model;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor;
      osVersion = iosInfo.systemVersion;
      deviceModel = iosInfo.model;
    }

    return AppDeviceData(
      deviceID: deviceId,
      appVersion: packageInfo.version,
      appBuild: packageInfo.buildNumber,
      osVersion: osVersion,
      deviceModel: deviceModel,
    );
  }

  //////

  static void showTextSnackBar({
    String text = '',
    Color? backgroundColor,
    double elevation = 3.0,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    EdgeInsets margin = const EdgeInsets.all(10),
    int seconds = 3,
    GestureTapCallback? onTap,
  }) {
    //Scaffold.of(context)
    showSnackBar(
      margin: margin,
      backgroundColor: backgroundColor ?? Colors.green.shade800,
      elevation: elevation,
      behavior: behavior,
      seconds: seconds,
      content: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  static void hideSnackBar() {
    final BuildContext? context = ServiceNav.navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  static void showSnackBar({
    required Widget content,
    Color? backgroundColor = Colors.black,
    double elevation = 3.0,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    EdgeInsets margin = const EdgeInsets.all(10),
    int seconds = 3,
  }) {
    try {
      final BuildContext? context = ServiceNav.navigatorKey.currentContext;
      if (context != null) {
        //Scaffold.of(context)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: seconds),
            margin: margin,
            backgroundColor: backgroundColor,
            elevation: elevation,
            behavior: behavior,
            content: content,
          ),
        );
      }
    } catch (e, s) {
      logger.e(e, e, s);
    }
  }
}

// class PackageDeviceData {
//   PackageDeviceData({required this.appVersion, required this.appBuild, this.deviceID, this.osVersion, this.deviceModel});
//
//   final String appVersion;
//   final String appBuild;
//   final String? deviceID;
//   final String? osVersion;
//   final String? deviceModel;
//
//   @override
//   String toString() {
//     return 'PackageDeviceData{appVersion: $appVersion, appBuild: $appBuild, deviceID: $deviceID, osVersion: $osVersion, deviceModel: $deviceModel}';
//   }
// }
