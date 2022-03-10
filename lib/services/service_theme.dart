import '../my_services.dart';

class ServiceTheme {
  static const ServiceTheme _s = ServiceTheme._();
  factory ServiceTheme() => _s;
  const ServiceTheme._();
  //
  static const double elevation = 2;

  static MyThemeData dark = MyThemeData.dark;
  static MyThemeData light = MyThemeData.light;

  static MyThemeData theme([BuildContext? context]) => isDark(context ?? ServiceNav.context) ? dark : light;

  static BorderRadius borderRadius = const BorderRadius.all(Radius.zero);
  static RoundedRectangleBorder circularBorderRadius10 = RoundedRectangleBorder(borderRadius: borderRadius);

  static ThemeData lightTheme() => _getThemeData(ThemeData.light());
  static ThemeData darkTheme() => _getThemeData(ThemeData.dark());

  static final Color _darkScaffoldBackgroundColor = dark.background;
  static final Color _lightScaffoldBackgroundColor = light.background;

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

  static ThemeData _getThemeData(ThemeData mainThemeData) {
    final bool isDark = mainThemeData.brightness == Brightness.dark;

    MyThemeData myThemeData = isDark ? dark : light;

    final TextTheme textTheme = _modifyTextHeight(GoogleFonts.tajawalTextTheme(mainThemeData.textTheme));

    final iconTheme = mainThemeData.iconTheme.copyWith(color: myThemeData.primary);

    final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: myThemeData.primary, brightness: mainThemeData.brightness).copyWith(
      background: myThemeData.background,
      onBackground: myThemeData.onBackground,
      //
      primary: myThemeData.primary,
      onPrimary: myThemeData.onPrimary,
      //
      secondary: myThemeData.primary,
      onSecondary: myThemeData.onPrimary,
      //
      surface: myThemeData.card,
      onSurface: myThemeData.onCard,
      //
      tertiary: myThemeData.success,
      onTertiary: myThemeData.onSuccess,
      //
      error: myThemeData.error,
      onError: myThemeData.onError,
    );

    final ThemeData themeData = mainThemeData.copyWith(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      toggleableActiveColor: colorScheme.primary, //TODO: [https://github.com/flutter/flutter/pull/95870]
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: iconTheme,
      appBarTheme: mainThemeData.appBarTheme.copyWith(
        backgroundColor: myThemeData.appBar?.backgroundColor ?? colorScheme.background,
        elevation: myThemeData.appBar?.elevation ?? 0,
        titleTextStyle: textTheme.bodyText2?.copyWith(color: colorScheme.onBackground),
        iconTheme: iconTheme,
        shape: myThemeData.appBar?.shape ?? circularBorderRadius10,
      ),
      chipTheme: mainThemeData.chipTheme.copyWith(
        backgroundColor: colorScheme.primary,
        deleteIconColor: colorScheme.onPrimary,
        labelStyle: textTheme.bodyText2?.copyWith(color: colorScheme.onPrimary),
      ),
      listTileTheme: mainThemeData.listTileTheme.copyWith(
        shape: circularBorderRadius10,
        iconColor: iconTheme.color,
      ),
      //
      checkboxTheme: mainThemeData.checkboxTheme.copyWith(
        shape: circularBorderRadius10,
      ),
      dialogTheme: mainThemeData.dialogTheme.copyWith(
        backgroundColor: colorScheme.background,
        elevation: elevation,
        shape: circularBorderRadius10.copyWith(side: const BorderSide(width: 0.5, color: Colors.grey)),
      ),
      cardTheme: mainThemeData.cardTheme.copyWith(
        shape: circularBorderRadius10,
        color: colorScheme.surface,
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
      drawerTheme: mainThemeData.drawerTheme.copyWith(
        // backgroundColor: colorScheme.surface,
        shape: circularBorderRadius10,
        elevation: elevation,
      ),
      popupMenuTheme: mainThemeData.popupMenuTheme.copyWith(
        color: colorScheme.surface,
        shape: circularBorderRadius10.copyWith(side: const BorderSide(width: 0.5, color: Colors.grey)),
        elevation: elevation,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: textTheme.bodyText1,
          shape: circularBorderRadius10,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: textTheme.bodyText1,
          shape: circularBorderRadius10,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: textTheme.bodyText1,
          shape: circularBorderRadius10,
        ),
      ),
      tabBarTheme: mainThemeData.tabBarTheme.copyWith(
        indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
          width: 2,
          // color: accentColor,
        )),
      ),
      floatingActionButtonTheme: mainThemeData.floatingActionButtonTheme.copyWith(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: elevation,
      ),

      progressIndicatorTheme: mainThemeData.progressIndicatorTheme.copyWith(
        refreshBackgroundColor: colorScheme.surface,
        color: colorScheme.onSurface,
      ),
      snackBarTheme: mainThemeData.snackBarTheme.copyWith(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.surface,
        contentTextStyle: textTheme.subtitle1?.copyWith(color: colorScheme.onInverseSurface),
        elevation: elevation,
        shape: circularBorderRadius10.copyWith(side: BorderSide(width: 0.5, color: colorScheme.onInverseSurface)),
      ),
    );

    return themeData;
  }

  //provider
  static ThemeMode? watchThemeMode(WidgetRef ref) => MyServices.providers.watchThemeMode(ref);
  static ThemeMode? readThemeMode(WidgetRef ref) => MyServices.providers.readThemeMode(ref);
  static void setThemeMode(dynamic ref, BuildContext context, ThemeMode value) => MyServices.providers.setThemeMode(ref, context, value);
  static void toggleThemeMode(dynamic ref, BuildContext context) => MyServices.providers.toggleThemeMode(ref, context);

  static String getThemeLabel(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      return getMyServicesLabels(ServiceNav.context).dependsOnSystem;
    } else if (themeMode == ThemeMode.dark) {
      return getMyServicesLabels(ServiceNav.context).darkMode;
    } else if (themeMode == ThemeMode.light) {
      return getMyServicesLabels(ServiceNav.context).lightMode;
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

ColorScheme getColorScheme(BuildContext context) => getTheme(context).colorScheme;

bool isDark(BuildContext context) => getTheme(context).brightness == Brightness.dark;

bool isLight(BuildContext context) => getTheme(context).brightness == Brightness.light;

Color getColor(BuildContext context, {Color colorWhenDark = Colors.white, Color colorWhenLight = Colors.black}) => isDark(context) ? colorWhenDark : colorWhenLight;
Color whiteWhenDarkBlackWhenLight(BuildContext context) => getColor(context, colorWhenDark: Colors.white, colorWhenLight: Colors.black);
Color blackWhenDarkWhiteWhenLight(BuildContext context) => getColor(context, colorWhenDark: Colors.black, colorWhenLight: Colors.white);
