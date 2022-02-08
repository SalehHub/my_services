import '../my_services.dart';
import '../providers/general_state_provider.dart';

class ServiceTheme {
  static Color? lightAccentColor;
  static Color? darkAccentColor;

  static Color? lightBgColor;
  static Color? darkBgColor;
  static Color? lightCardColor;
  static Color? darkCardColor;
  static BorderRadius borderRadius = const BorderRadius.all(Radius.zero);

  static const double elevation = 2;
  static RoundedRectangleBorder circularBorderRadius10 = RoundedRectangleBorder(borderRadius: borderRadius);

  static final Color _darkScaffoldBackgroundColor = darkBgColor ?? ThemeData.dark().scaffoldBackgroundColor;
  static final Color _lightScaffoldBackgroundColor = lightBgColor ?? ThemeData.light().scaffoldBackgroundColor;

  static SystemUiOverlayStyle get _lightSystemUiOverlayStyle {
    if (kIsWeb) {
      return SystemUiOverlayStyle.light;
    }

    if (Platform.isIOS) {
      return SystemUiOverlayStyle.light;
    }

    return SystemUiOverlayStyle(
      statusBarColor: _darkScaffoldBackgroundColor,
      systemNavigationBarColor: _darkScaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }

  static SystemUiOverlayStyle get _darkSystemUiOverlayStyle {
    if (kIsWeb) {
      return SystemUiOverlayStyle.dark;
    }

    if (Platform.isIOS) {
      return SystemUiOverlayStyle.dark;
    }

    return SystemUiOverlayStyle(
      statusBarColor: _lightScaffoldBackgroundColor,
      systemNavigationBarColor: _lightScaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  static void setSystemUiOverlayStyle(ThemeMode? value, BuildContext context) {
    if (value == ThemeMode.dark) {
      SystemChrome.setSystemUIOverlayStyle(_lightSystemUiOverlayStyle);
    } else if (value == ThemeMode.light) {
      SystemChrome.setSystemUIOverlayStyle(_darkSystemUiOverlayStyle);
    } else {
      Future<void>.delayed(const Duration(milliseconds: 300), () {
        if (isDark(context)) {
          SystemChrome.setSystemUIOverlayStyle(_lightSystemUiOverlayStyle);
        } else {
          SystemChrome.setSystemUIOverlayStyle(_darkSystemUiOverlayStyle);
        }
      });
    }
  }

  static TextTheme _modifyTextHeight(TextTheme textTheme) {
    // return textTheme;
    const double height = 1.8;
    const double letterSpacing = 0.1;
    final TextStyle? bodyText1 = textTheme.bodyText1?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? bodyText2 = textTheme.bodyText2?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? caption = textTheme.caption?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? overline = textTheme.overline?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline1 = textTheme.headline1?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline2 = textTheme.headline2?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline3 = textTheme.headline3?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline4 = textTheme.headline4?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline5 = textTheme.headline5?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline6 = textTheme.headline6?.copyWith(height: height, letterSpacing: letterSpacing);
    return textTheme.copyWith(
      bodyText1: bodyText1,
      bodyText2: bodyText2,
      caption: caption,
      overline: overline,
      headline1: headline1,
      headline2: headline2,
      headline3: headline3,
      headline4: headline4,
      headline5: headline5,
      headline6: headline6,
    );
  }

  static ThemeData _getThemeData(ThemeData mainThemeData, [Color? accentColor, Color? bgColor, Color? cardColor]) {
    final bool isDark = mainThemeData.brightness == Brightness.dark;
    final TextTheme textTheme = _modifyTextHeight(GoogleFonts.tajawalTextTheme(mainThemeData.textTheme));

    // final Color? primaryColor = isDark ? null : Colors.white;
    final Color iconColor = isDark ? Colors.white : (accentColor ?? Colors.black);

    final ThemeData themeData = mainThemeData.copyWith(
      scaffoldBackgroundColor: bgColor,
      toggleableActiveColor: accentColor,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      canvasColor: cardColor,
      //
      colorScheme: mainThemeData.colorScheme.copyWith(primary: accentColor),
      iconTheme: mainThemeData.iconTheme.copyWith(color: accentColor),
      listTileTheme: mainThemeData.listTileTheme.copyWith(
        shape: circularBorderRadius10,
        iconColor: iconColor,
      ),
      //
      checkboxTheme: mainThemeData.checkboxTheme.copyWith(
        shape: circularBorderRadius10,
      ),
      dialogTheme: mainThemeData.dialogTheme.copyWith(
        backgroundColor: bgColor,
        elevation: elevation,
        shape: circularBorderRadius10.copyWith(side: const BorderSide(width: 0.5, color: Colors.grey)),
      ),
      cardTheme: mainThemeData.cardTheme.copyWith(
        shape: circularBorderRadius10,
        color: cardColor ?? bgColor,
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
      drawerTheme: mainThemeData.drawerTheme.copyWith(
        backgroundColor: bgColor,
        shape: circularBorderRadius10,
        elevation: elevation,
      ),
      popupMenuTheme: mainThemeData.popupMenuTheme.copyWith(
        color: bgColor,
        shape: circularBorderRadius10.copyWith(side: const BorderSide(width: 0.5, color: Colors.grey)),
        elevation: elevation,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: textTheme.bodyText1,
          primary: accentColor,
          shape: circularBorderRadius10,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: textTheme.bodyText1,
          primary: accentColor,
          shape: circularBorderRadius10,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: textTheme.bodyText1,
          primary: accentColor,
          shape: circularBorderRadius10,
        ),
      ),
      tabBarTheme: mainThemeData.tabBarTheme.copyWith(
        indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 2, color: accentColor ?? const Color(0xFF000000))),
      ),
      floatingActionButtonTheme: mainThemeData.floatingActionButtonTheme.copyWith(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: elevation,
      ),
      appBarTheme: mainThemeData.appBarTheme.copyWith(
        backgroundColor: bgColor, //cardColor ?? bgColor ?? primaryColor,
        elevation: 0.5,
        titleTextStyle: textTheme.bodyText2,
        iconTheme: IconThemeData(color: iconColor),
        shape: circularBorderRadius10.copyWith(
          side: BorderSide(
            color: isDark
                ? ServiceColor.getShade(
                    bgColor ?? Colors.transparent,
                    darker: true,
                    value: 0.02,
                  )
                : Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      progressIndicatorTheme: mainThemeData.progressIndicatorTheme.copyWith(
        refreshBackgroundColor: bgColor,
      ),
      snackBarTheme: mainThemeData.snackBarTheme.copyWith(
        behavior: SnackBarBehavior.floating,
        backgroundColor: bgColor,
        // contentTextStyle: GoogleFonts.tajawal(),
        elevation: elevation,
        shape: circularBorderRadius10.copyWith(side: const BorderSide(width: 0.5, color: Colors.grey)),
      ),
    );

    return themeData;
  }

  static ThemeData lightTheme() => _getThemeData(ThemeData.light(), lightAccentColor, lightBgColor, lightCardColor);

  static ThemeData darkTheme() => _getThemeData(ThemeData.dark(), darkAccentColor, darkBgColor, darkCardColor);

  //provider
  static ThemeMode? watchThemeMode(WidgetRef ref) => ref.watch(generalStateProvider.select((s) => s.themeMode));
  static ThemeMode? readThemeMode(WidgetRef ref) => ref.read(generalStateProvider).themeMode;
  static void setThemeMode(dynamic ref, BuildContext context, ThemeMode value) => ref.read(generalStateProvider.notifier).setThemeMode(context, value);
  static void toggleThemeMode(dynamic ref, BuildContext context) => ref.read(generalStateProvider.notifier).toggleThemeMode(context);

  static String getThemeLabel(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      return getMyServicesLabels(ServiceNav.context!).dependsOnSystem;
    } else if (themeMode == ThemeMode.dark) {
      return getMyServicesLabels(ServiceNav.context!).darkMode;
    } else if (themeMode == ThemeMode.light) {
      return getMyServicesLabels(ServiceNav.context!).lightMode;
    }

    return "";
  }

  static IconData getThemeIcon(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      return Mdi.cellphone;
    } else if (themeMode == ThemeMode.dark) {
      return Mdi.weatherNight;
    } else if (themeMode == ThemeMode.light) {
      return Mdi.weatherSunny;
    }

    return Mdi.cellphone;
  }
}

//////Theme Helpers

ThemeData getTheme(BuildContext context) => Theme.of(context);

TextTheme getTextTheme(BuildContext context) => getTheme(context).textTheme;

bool isDark(BuildContext context) => getTheme(context).brightness == Brightness.dark;

bool isLight(BuildContext context) => getTheme(context).brightness == Brightness.light;

Color getColor(BuildContext context, {Color colorWhenDark = Colors.white, Color colorWhenLight = Colors.black}) => isDark(context) ? colorWhenDark : colorWhenLight;
Color whiteWhenDarkBlackWhenLight(BuildContext context) => getColor(context, colorWhenDark: Colors.white, colorWhenLight: Colors.black);
Color blackWhenDarkWhiteWhenLight(BuildContext context) => getColor(context, colorWhenDark: Colors.black, colorWhenLight: Colors.white);
