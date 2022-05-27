import '../my_services.dart';

class ServiceTheme {
  // const ServiceTheme _s = ServiceTheme._();
  // factory ServiceTheme() => _s;
  // const ServiceTheme._();
  //
  static const double elevation = 2;

  MyThemeData _dark = MyThemeData.dark;
  MyThemeData _light = MyThemeData.light;

  BorderRadius _borderRadius = const BorderRadius.all(Radius.zero);
  BorderRadius get borderRadius => _borderRadius;
  RoundedRectangleBorder get circularBorderRadius => RoundedRectangleBorder(borderRadius: _borderRadius);

  void setDark(MyThemeData v) => _dark = v;

  void setLight(MyThemeData v) => _light = v;

  void setBorderRadius(BorderRadius v) => _borderRadius = v;

  // MyThemeData theme([BuildContext? context]) => isDark(context ?? ServiceNav.context) ? _dark : _light;

  ThemeData get lightTheme => _getThemeData(ThemeData.light());

  ThemeData get darkTheme => _getThemeData(ThemeData.dark());

  SystemUiOverlayStyle get _lightSystemUiOverlayStyle {
    if (kIsWeb) {
      return SystemUiOverlayStyle.light;
    }

    if (Platform.isIOS) {
      return SystemUiOverlayStyle.light;
    }

    return SystemUiOverlayStyle(
      statusBarColor: _dark.background,
      systemNavigationBarColor: _dark.background,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }

  SystemUiOverlayStyle get _darkSystemUiOverlayStyle {
    if (kIsWeb) {
      return SystemUiOverlayStyle.dark;
    }

    if (Platform.isIOS) {
      return SystemUiOverlayStyle.dark;
    }

    return SystemUiOverlayStyle(
      statusBarColor: _light.background,
      systemNavigationBarColor: _light.background,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  void setSystemUiOverlayStyle(ThemeMode? value, BuildContext context) {
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

  TextTheme _modifyTextHeight(TextTheme textTheme) {
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

  ThemeData _getThemeData(ThemeData mainThemeData) {
    final bool isDark = mainThemeData.brightness == Brightness.dark;

    MyThemeData myThemeData = isDark ? _dark : _light;

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
      canvasColor: colorScheme.background, //used for dropdownitem bg color
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: iconTheme,
      appBarTheme: mainThemeData.appBarTheme.copyWith(
        backgroundColor: myThemeData.appBar?.backgroundColor ?? colorScheme.background,
        elevation: myThemeData.appBar?.elevation ?? 0,
        titleTextStyle: textTheme.bodyText2?.copyWith(color: colorScheme.onBackground),
        iconTheme: iconTheme,
        shape: myThemeData.appBar?.shape ?? circularBorderRadius,
      ),
      chipTheme: mainThemeData.chipTheme.copyWith(
        backgroundColor: colorScheme.primary,
        deleteIconColor: colorScheme.onPrimary,
        labelStyle: textTheme.bodyText2?.copyWith(color: colorScheme.onPrimary),
      ),
      listTileTheme: mainThemeData.listTileTheme.copyWith(
        shape: circularBorderRadius,
        iconColor: iconTheme.color,
      ),
      //
      checkboxTheme: mainThemeData.checkboxTheme.copyWith(
        shape: circularBorderRadius,
      ),
      inputDecorationTheme:mainThemeData.inputDecorationTheme.copyWith(
      alignLabelWithHint: true,
      isDense: true,
      border:  OutlineInputBorder(borderRadius: borderRadius),
      ),
      dialogTheme: mainThemeData.dialogTheme.copyWith(
        backgroundColor: colorScheme.background,
        elevation: elevation,
        shape: circularBorderRadius.copyWith(side: const BorderSide(width: 0.5, color: Colors.grey)),
      ),
      cardTheme: mainThemeData.cardTheme.copyWith(
        shape: circularBorderRadius,
        color: colorScheme.surface,
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
      drawerTheme: mainThemeData.drawerTheme.copyWith(
        backgroundColor: colorScheme.background,
        shape: circularBorderRadius,
        elevation: elevation,
      ),
      popupMenuTheme: mainThemeData.popupMenuTheme.copyWith(
        color: colorScheme.surface,
        shape: circularBorderRadius.copyWith(side: const BorderSide(width: 0.5, color: Colors.grey)),
        elevation: elevation,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: textTheme.bodyText1,
          shape: circularBorderRadius,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: colorScheme.primary,
          onPrimary: colorScheme.onPrimary,
          textStyle: textTheme.bodyText1,
          shape: circularBorderRadius,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: textTheme.bodyText1,
          shape: circularBorderRadius,
        ),
      ),
      tabBarTheme: mainThemeData.tabBarTheme.copyWith(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: colorScheme.primary),
        ),
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
        shape: circularBorderRadius.copyWith(side: BorderSide(width: 0.5, color: colorScheme.onInverseSurface)),
      ),
    );

    return themeData;
  }

  //provider
  ThemeMode? watchThemeMode(WidgetRef ref) => MyServices.providers.watchThemeMode(ref);
  ThemeMode? readThemeMode(WidgetRef ref) => MyServices.providers.readThemeMode(ref);

  void setThemeMode(dynamic ref, BuildContext context, ThemeMode value) => MyServices.providers.setThemeMode(ref, context, value);
  void toggleThemeMode(dynamic ref, BuildContext context) => MyServices.providers.toggleThemeMode(ref, context);

  Widget getThemeSettingsSectionWidget() {
    return Builder(builder: (context) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Text(getMyServicesLabels(context).appTheme, style: getTextTheme(context).headline6),
          const Divider(),
          Consumer(builder: (BuildContext context, ref, Widget? child) {
            final ThemeMode? themeMode = watchThemeMode(ref);

            return RadioListTile<ThemeMode>(
              secondary: const Icon(iconCellphone),
              title: Text(getMyServicesLabels(context).dependsOnSystem, style: getTextTheme(context).bodyText2),
              value: ThemeMode.system,
              groupValue: themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  setThemeMode(ref, context, value);
                }
              },
            );
          }),
          Consumer(builder: (BuildContext context, ref, Widget? child) {
            final ThemeMode? themeMode = watchThemeMode(ref);
            return RadioListTile<ThemeMode>(
              secondary: const Icon(iconLight),
              title: Text(getMyServicesLabels(context).lightMode, style: getTextTheme(context).bodyText2),
              value: ThemeMode.light,
              groupValue: themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  setThemeMode(ref, context, value);
                }
              },
            );
          }),
          Consumer(builder: (BuildContext context, ref, Widget? child) {
            final ThemeMode? themeMode = watchThemeMode(ref);
            return RadioListTile<ThemeMode>(
              secondary: const Icon(iconDark),
              title: Text(getMyServicesLabels(context).darkMode, style: getTextTheme(context).bodyText2),
              value: ThemeMode.dark,
              groupValue: themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  setThemeMode(ref, context, value);
                }
              },
            );
          }),
          const SizedBox(height: 20),
        ],
      );
    });
  }

  String getThemeLabel(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      return getMyServicesLabels(ServiceNav.context).dependsOnSystem;
    } else if (themeMode == ThemeMode.dark) {
      return getMyServicesLabels(ServiceNav.context).darkMode;
    } else if (themeMode == ThemeMode.light) {
      return getMyServicesLabels(ServiceNav.context).lightMode;
    }

    return "";
  }

  IconData getThemeIcon(ThemeMode themeMode) {
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
