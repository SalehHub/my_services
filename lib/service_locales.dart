import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization.dart';

class ServiceLocale {
  ///Arabic added by default
  static List<Locale> supportedLocales([List<Locale> others = const []]) => <Locale>[
        const Locale('ar'),
        ...localizedLabels.keys.toList(),
        ...others,
      ];

  static List<LocalizationsDelegate<dynamic>> localizationsDelegates([List<LocalizationsDelegate<dynamic>> others = const []]) => <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        const MyServicesLocalizationsDelegate(),
        ...others,
      ];
}
