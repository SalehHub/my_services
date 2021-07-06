import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../localization.dart';

class ServiceLocale {
  static Locale defaultLocale = const Locale('ar');
  static List<Locale> supportedLocales = [defaultLocale];

  // static void setDefaultLocale(Locale locale) {
  //   defaultLocale = locale;
  // }
  //
  // static void setSupportedLocales(List<Locale> value) {
  //   supportedLocales = value;
  // }

  ///Arabic added by default
  // static List<Locale> supportedLocales([List<Locale> others = const []]) => <Locale>[
  //       defaultLocale,
  //       ...localizedLabels.keys.toList(),
  //       ...others,
  //     ];

  static List<LocalizationsDelegate<dynamic>> localizationsDelegates([List<LocalizationsDelegate<dynamic>> others = const []]) => <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        const MyServicesLocalizationsDelegate(),
        ...others,
      ];

  static bool isSupportedLocale(Locale locale) {
    return supportedLocales.where((l) => l.languageCode == locale.languageCode).isNotEmpty;
  }
}
