import '../my_services.dart';

final Logger logger = Logger();

class Helpers {
  static TextDirection getTextDirection(String text) => isRTL(text) ? TextDirection.rtl : TextDirection.ltr;
  static TextAlign getTextAlign(String text) => isRTL(text) ? TextAlign.right : TextAlign.left;
  static TextAlign getTextAlignByLang(BuildContext context) => ServiceLocale.isAr(context) ? TextAlign.right : TextAlign.left;

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

  static double getPageHeight(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size.height;
  }

  static String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static List chunk(List list, int chunkSize) {
    List chunks = [];
    int len = list.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;
      chunks.add(list.sublist(i, size > len ? len : size));
    }
    return chunks;
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
  static bool _printed = false;

  static Future<String?> getApplicationDocumentsPath() async {
    if (_printed == false && _applicationDocumentsDirectoryPath != null) {
      logger.i(_applicationDocumentsDirectoryPath);
      _printed = true;
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
      final BuildContext? context = ServiceNav.context;
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

  //start-mapLauncher
  static Future<void> openMap(double lat, double lng, String? title, [BuildContext? context]) async {
    final Coords coords = Coords(lat, lng);
    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

    if (availableMaps.length == 1) {
      return await availableMaps.first.showMarker(coords: coords, title: title ?? "");
    }

    MyServicesLocalizationsData labels = getMyServicesLabels((ServiceNav.context ?? context)!);

    _buildIcon(map) {
      //start-flutterSvg
      return SvgPicture.asset(map.icon, fit: BoxFit.cover, height: 30, width: 30);
      //end-flutterSvg
      if (map == MapType.google) {
        return const Icon(Mdi.googleMaps, size: 30);
      } else {
        return const Icon(Mdi.mapMarkerCircle, size: 30);
      }
    }

    ServiceDialog.show(
        title: labels.chooseMapApp,
        children: availableMaps.map((map) {
          String mapName = "";

          if (map.mapType == MapType.apple) {
            mapName = labels.appleMaps;
          } else if (map.mapType == MapType.google) {
            mapName = labels.googleMaps;
          } else {
            mapName = map.mapName;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            child: ListTile(
              shape: ServiceTheme.circularBorderRadius10,
              leading: ClipRRect(borderRadius: ServiceTheme.borderRadius, child: _buildIcon(map)),
              title: Text(mapName),
              onTap: () => map.showMarker(coords: coords, title: title ?? ""),
            ),
          );
        }).toList());
  }

  //end-mapLauncher

}
