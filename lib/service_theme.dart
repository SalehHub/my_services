import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceTheme {
  static final Color _darkScaffoldBackgroundColor = ThemeData.dark().scaffoldBackgroundColor;
  static final Color _lightScaffoldBackgroundColor = ThemeData.light().scaffoldBackgroundColor;

  static SystemUiOverlayStyle get _lightSystemUiOverlayStyle {
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

  static void setSystemUiOverlayStyle(ThemeMode value, BuildContext context) {
    if (value == ThemeMode.dark) {
      SystemChrome.setSystemUIOverlayStyle(_lightSystemUiOverlayStyle);
    } else if (value == ThemeMode.light) {
      SystemChrome.setSystemUIOverlayStyle(_darkSystemUiOverlayStyle);
    } else {
      Future<void>.delayed(const Duration(milliseconds: 500), () {
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
    final TextStyle? bodyText1 = textTheme.bodyText1?.copyWith(height: height);
    final TextStyle? bodyText2 = textTheme.bodyText2?.copyWith(height: height);
    final TextStyle? caption = textTheme.caption?.copyWith(height: height);
    final TextStyle? overline = textTheme.overline?.copyWith(height: height);
    final TextStyle? headline1 = textTheme.headline1?.copyWith(height: height);
    final TextStyle? headline2 = textTheme.headline2?.copyWith(height: height);
    final TextStyle? headline3 = textTheme.headline3?.copyWith(height: height);
    final TextStyle? headline4 = textTheme.headline4?.copyWith(height: height);
    final TextStyle? headline5 = textTheme.headline5?.copyWith(height: height);
    final TextStyle? headline6 = textTheme.headline6?.copyWith(height: height);
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

  static ThemeData _getThemeData(ThemeData mainThemeData, [Color? accentColor]) {
    final bool isDark = mainThemeData.brightness == Brightness.dark;
    final TextTheme textThemeLight = _modifyTextHeight(GoogleFonts.tajawalTextTheme(mainThemeData.textTheme));

    final ThemeData lightTheme = mainThemeData.copyWith(
      toggleableActiveColor: accentColor,
      textTheme: textThemeLight,
      colorScheme: mainThemeData.colorScheme.copyWith(primary: accentColor),
      primaryTextTheme: textThemeLight,
      primaryColor: isDark ? null : Colors.white,
      iconTheme: mainThemeData.iconTheme.copyWith(color: accentColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(textStyle: textThemeLight.bodyText1, primary: accentColor),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(textStyle: textThemeLight.bodyText1, primary: accentColor),
      ),
      tabBarTheme: mainThemeData.tabBarTheme.copyWith(
        labelColor: accentColor,
        unselectedLabelColor: accentColor?.withOpacity(0.7),
        indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 2, color: accentColor ?? const Color(0xFF000000))),
      ),
      floatingActionButtonTheme: mainThemeData.floatingActionButtonTheme.copyWith(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 15,
      ),
      appBarTheme: mainThemeData.appBarTheme.copyWith(
        textTheme: textThemeLight,
        elevation: 2,
        iconTheme: IconThemeData(color: !isDark ? Colors.black : Colors.white),
      ),
      snackBarTheme: mainThemeData.snackBarTheme.copyWith(
        contentTextStyle: GoogleFonts.tajawal(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    return lightTheme;
  }

  static ThemeData lightTheme([Color? accentColor = const Color(0xf000b050)]) => _getThemeData(ThemeData.light(), accentColor);

  static ThemeData darkTheme([Color accentColor = const Color(0xf000b050)]) => _getThemeData(ThemeData.dark(), accentColor);
}

//////Theme Helpers

ThemeData getTheme(BuildContext context) => Theme.of(context);

TextTheme getTextTheme(BuildContext context) => getTheme(context).textTheme;

bool isDark(BuildContext context) => getTheme(context).brightness == Brightness.dark;

bool isLight(BuildContext context) => getTheme(context).brightness == Brightness.light;

Color getTextColor(BuildContext context, [Color colorWhenDark = Colors.white, Color colorWhenLight = Colors.black]) => isDark(context) ? colorWhenDark : colorWhenLight;
