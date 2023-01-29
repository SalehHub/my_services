import '../my_services.dart';

class ServiceTheme {
  const ServiceTheme();

  static const double elevation = 2;

  static MyThemeData _dark = MyThemeData.dark;
  static MyThemeData _light = MyThemeData.light;
  static bool _useMaterial3 = true;

  static BorderRadius _borderRadius = const BorderRadius.all(Radius.zero);
  BorderRadius get borderRadius => _borderRadius;

  RoundedRectangleBorder get circularBorderRadius => RoundedRectangleBorder(borderRadius: _borderRadius);

  void setDark(MyThemeData v) => _dark = v;

  void setLight(MyThemeData v) => _light = v;
  void setUseMaterial3(bool v) => _useMaterial3 = v;

  void setBorderRadius(BorderRadius v) => _borderRadius = v;

  // MyThemeData theme([BuildContext? context]) => isDark(context ?? MyServices.context) ? _dark : _light;

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
    final TextStyle? bodyText1 = textTheme.bodyLarge?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? bodyText2 = textTheme.bodyMedium?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? caption = textTheme.bodySmall?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? overline = textTheme.labelSmall?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline1 = textTheme.displayLarge?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline2 = textTheme.displayMedium?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline3 = textTheme.displaySmall?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline4 = textTheme.headlineMedium?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline5 = textTheme.headlineSmall?.copyWith(height: height, letterSpacing: letterSpacing);
    final TextStyle? headline6 = textTheme.titleLarge?.copyWith(height: height, letterSpacing: letterSpacing);
    return textTheme.copyWith(
      bodyLarge: bodyText1,
      bodyMedium: bodyText2,
      bodySmall: caption,
      labelSmall: overline,
      displayLarge: headline1,
      displayMedium: headline2,
      displaySmall: headline3,
      headlineMedium: headline4,
      headlineSmall: headline5,
      titleLarge: headline6,
    );
  }

  ThemeData _getThemeData(ThemeData mainThemeData) {
    final bool isDark = mainThemeData.brightness == Brightness.dark;

    MyThemeData myThemeData = isDark ? _dark : _light;
    MyThemeData myThemeDataInverse = !isDark ? _dark : _light;

    final TextTheme textTheme = _modifyTextHeight(GoogleFonts.tajawalTextTheme(mainThemeData.textTheme));

    final iconTheme = mainThemeData.iconTheme.copyWith(color: myThemeData.primary);

    final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: myThemeData.primary, brightness: mainThemeData.brightness).copyWith(
      background: myThemeData.background,
      onBackground: myThemeData.onBackground,
      //
      inverseSurface: _dark.background,
      onInverseSurface: _light.background,
      //
      primary: myThemeData.primary,
      onPrimary: myThemeData.onPrimary,
      //
      primaryContainer: myThemeDataInverse.primary,
      onPrimaryContainer: myThemeDataInverse.onPrimary,
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
      useMaterial3: _useMaterial3,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      canvasColor: colorScheme.background, //used for dropdownitem bg color
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: iconTheme,
      appBarTheme: mainThemeData.appBarTheme.copyWith(
        backgroundColor: myThemeData.appBar?.backgroundColor ?? colorScheme.background,
        elevation: myThemeData.appBar?.elevation ?? 0,
        titleTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground),
        iconTheme: iconTheme,
        shape: myThemeData.appBar?.shape ?? circularBorderRadius,
      ),
      chipTheme: mainThemeData.chipTheme.copyWith(
        backgroundColor: colorScheme.primary,
        deleteIconColor: colorScheme.onPrimary,
        labelStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary),
      ),
      listTileTheme: mainThemeData.listTileTheme.copyWith(
        shape: circularBorderRadius,
        iconColor: iconTheme.color,
      ),
      switchTheme: mainThemeData.switchTheme.copyWith(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected) ? colorScheme.onTertiary : Colors.grey;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected) ? colorScheme.tertiary : Colors.grey.shade200;
        }),
      ),
      radioTheme: mainThemeData.radioTheme.copyWith(
        fillColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected) ? colorScheme.onTertiary : Colors.grey;
        }),
      ),

      checkboxTheme: mainThemeData.checkboxTheme.copyWith(
        shape: circularBorderRadius,
        fillColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected) ? colorScheme.primary : Colors.grey;
        }),
        checkColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected) ? colorScheme.onPrimary : Colors.grey;
        }),
      ),
      inputDecorationTheme: mainThemeData.inputDecorationTheme.copyWith(
        alignLabelWithHint: true,
        isDense: true,
        border: OutlineInputBorder(borderRadius: borderRadius),
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
          textStyle: textTheme.bodyLarge,
          shape: circularBorderRadius,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: textTheme.bodyLarge,
          shape: circularBorderRadius,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: textTheme.bodyLarge,
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
        color: isDark ? _light.onPrimary : _light.primary,
        circularTrackColor: isDark ? _light.primary : _dark.background,
      ),

      snackBarTheme: mainThemeData.snackBarTheme.copyWith(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.surface,
        contentTextStyle: textTheme.titleMedium?.copyWith(color: colorScheme.onInverseSurface),
        elevation: elevation,
        shape: circularBorderRadius.copyWith(side: BorderSide(width: 0.5, color: colorScheme.onInverseSurface)),
      ),
    );

    return themeData;
  }

  Widget getThemeSettingsSectionWidget() {
    return Builder(builder: (context) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Text(getMyServicesLabels(context).appTheme, style: getTextTheme(context).titleLarge),
          const Divider(),
          Consumer(builder: (BuildContext context, ref, Widget? child) {
            final ThemeMode? themeMode = MyServices.providers.watchThemeMode(ref);

            return RadioListTile<ThemeMode>(
              secondary: const Icon(iconCellphone),
              title: Text(getMyServicesLabels(context).dependsOnSystem, style: getTextTheme(context).bodyMedium),
              value: ThemeMode.system,
              groupValue: themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  MyServices.providers.setThemeMode(context, value);
                }
              },
            );
          }),
          Consumer(builder: (BuildContext context, ref, Widget? child) {
            final ThemeMode? themeMode = MyServices.providers.watchThemeMode(ref);
            return RadioListTile<ThemeMode>(
              secondary: const Icon(iconLight),
              title: Text(getMyServicesLabels(context).lightMode, style: getTextTheme(context).bodyMedium),
              value: ThemeMode.light,
              groupValue: themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  MyServices.providers.setThemeMode(context, value);
                }
              },
            );
          }),
          Consumer(builder: (BuildContext context, ref, Widget? child) {
            final ThemeMode? themeMode = MyServices.providers.watchThemeMode(ref);
            return RadioListTile<ThemeMode>(
              secondary: const Icon(iconDark),
              title: Text(getMyServicesLabels(context).darkMode, style: getTextTheme(context).bodyMedium),
              value: ThemeMode.dark,
              groupValue: themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  MyServices.providers.setThemeMode(context, value);
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
      return getMyServicesLabels(MyServices.context).dependsOnSystem;
    } else if (themeMode == ThemeMode.dark) {
      return getMyServicesLabels(MyServices.context).darkMode;
    } else if (themeMode == ThemeMode.light) {
      return getMyServicesLabels(MyServices.context).lightMode;
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
