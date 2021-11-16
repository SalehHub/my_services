import '../my_services.dart';

class ServiceLocale {
  static Locale defaultLocale = const Locale('ar');
  static List<Locale> supportedLocales = [defaultLocale];

  //we can not use ServiceNav.context in here
  static String currentLocaleLangCode(BuildContext context) {
    return currentLocale(context).languageCode;
  }

  //we can not use ServiceNav.context in here
  static Locale currentLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  // static Locale? localeResolutionCallback(Locale? locale, Iterable<Locale> supportedLocales) {
  //   return locale != null && isSupportedLocale(locale) ? Locale(locale.languageCode) : defaultLocale;
  // }

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

  static bool isAr(BuildContext context) {
    return currentLocaleLangCode(context) == 'ar';
  }

  static bool isEn(BuildContext context) {
    return currentLocaleLangCode(context) == 'en';
  }
}
