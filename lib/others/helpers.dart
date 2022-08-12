import '../my_services.dart';

final Logger logger = Logger();

class Helpers {
  const Helpers._();
  static const Helpers _s = Helpers._();
  factory Helpers() => _s;

  TextDirection getTextDirection(String text) => isRTL(text) ? TextDirection.rtl : TextDirection.ltr;

  TextAlign getTextAlign(String text) => isRTL(text) ? TextAlign.right : TextAlign.left;

  TextAlign getTextAlignByLang(BuildContext context) => MyServices.services.locale.isAr(context) ? TextAlign.right : TextAlign.left;

  bool isRTL(String text) => Bidi.detectRtlDirectionality(text);

  String getUuid() => const Uuid().v4();

  bool isLandScape(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Orientation pageOrientation = mediaQueryData.orientation;
    final bool isPageOrientationLandScape = pageOrientation == Orientation.landscape;
    return isPageOrientationLandScape;
  }

  double getPageWidth(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size.width;
  }

  double getPageHeight(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size.height;
  }

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  List chunk(List list, int chunkSize) {
    List chunks = [];
    int len = list.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;
      chunks.add(list.sublist(i, size > len ? len : size));
    }
    return chunks;
  }

  List<Shadow> getTextStroke(double strokeWidth, Color strokeColor) {
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

  String indianToArabicNumbers(String text) {
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

  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  bool isArabicText(String text) {
    const String arabicLetters = 'ةجحخهعغفقثصضشسيبلاتنمكورزدذطظؤآءئإأ';
    for (final String c in text.split('')) {
      if (arabicLetters.contains(c)) {
        return true;
      }
    }

    return false;
  }

//////////

  double bytesToMegabytes(int sizeInBits) {
    return sizeInBits / (1024 * 1000);
  }

  String getFileSizeForHuman(String filepath, [int decimals = 3]) {
    final File file = File(filepath);
    return bytesToFileSizeForHuman(file.lengthSync(), decimals);
  }

  String bytesToFileSizeForHuman(int bytes, [int decimals = 3]) {
    if (bytes <= 0) {
      return '0 B';
    }
    const List<String> suffixes = <String>['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final int i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

//////////

  Future<void> waitForSeconds([int seconds = 2]) => Future<void>.delayed(Duration(seconds: seconds));

  Future<void> waitForMilliseconds([int milliseconds = 200]) => Future<void>.delayed(Duration(milliseconds: milliseconds));

  ///////

  Future<Directory?> _getApplicationDocumentsDirectory() async {
    if (!kIsWeb) {
      return getApplicationDocumentsDirectory();
    }
    return null;
  }

  static String? _applicationDocumentsDirectoryPath;
  static bool _printed = false;

  Future<String?> getApplicationDocumentsPath() async {
    if (_printed == false && _applicationDocumentsDirectoryPath != null) {
      logger.d(_applicationDocumentsDirectoryPath);
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

  String getTimeAgo(DateTime time, [String? langCode]) {
    if (langCode == null) {
      Locale locale = Localizations.localeOf(MyServices.context);
      langCode = locale.languageCode.toLowerCase();
    }

    final LookupMessages lookupMessages = _lookupMessagesMap[langCode] ?? EnMessages();

    try {
      setLocaleMessages(langCode, lookupMessages);
      final String timeAgo = format(time, locale: langCode);
      return timeAgo;
    } catch (e) {
      logger.e(e);
    }
    return '';
  }

  //start-mapLauncher
  Future<void> openMap(double lat, double lng, String? title) async {
    MyServicesLocalizationsData labels = getMyServicesLabels(MyServices.context);

    final Coords coords = Coords(lat, lng);
    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

    if (availableMaps.length == 1) {
      return await availableMaps.first.showMarker(coords: coords, title: title ?? "");
    }

    _buildIcon(map) {
      //start-flutterSvg
      return SvgPicture.asset(map.icon, fit: BoxFit.cover, height: 30, width: 30);
      //end-flutterSvg
      // ignore: dead_code
      if (map == MapType.google) {
        return const Icon(Mdi.googleMaps, size: 30);
      } else {
        return const Icon(Mdi.mapMarkerCircle, size: 30);
      }
    }

    MyServices.services.dialog.show(
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
              shape: MyServices.services.theme.circularBorderRadius,
              leading: ClipRRect(borderRadius: MyServices.services.theme.borderRadius, child: _buildIcon(map)),
              title: Text(mapName),
              onTap: () => map.showMarker(coords: coords, title: title ?? ""),
            ),
          );
        }).toList());
  }
  //end-mapLauncher

}

//////Theme Helpers

ThemeData getTheme(BuildContext context) => Theme.of(context);

TextTheme getTextTheme(BuildContext context) => getTheme(context).textTheme;

ColorScheme getColorScheme(BuildContext context) => getTheme(context).colorScheme;

bool isDark(BuildContext context) => getTheme(context).brightness == Brightness.dark;

bool isLight(BuildContext context) => getTheme(context).brightness == Brightness.light;

Color getColor(BuildContext context, {Color colorWhenDark = Colors.white, Color colorWhenLight = Colors.black}) => isDark(context) ? colorWhenDark : colorWhenLight;

Color whiteWhenDarkBlackWhenLight(BuildContext context) => getColor(context, colorWhenDark: Colors.white, colorWhenLight: Colors.black);

Color blackWhenDarkWhiteWhenLight(BuildContext context) => getColor(context, colorWhenDark: Colors.black, colorWhenLight: Colors.white);
