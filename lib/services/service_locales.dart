import '../my_services.dart';

class ServiceLocale {
  static const ServiceLocale _s = ServiceLocale._();
  factory ServiceLocale() => _s;
  const ServiceLocale._();
  //
  static Locale defaultLocale = const Locale('ar');
  static List<Locale> supportedLocales = [defaultLocale];

  static Widget getLocalSettingsSectionWidget() {
    return Builder(builder: (context) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Text(getMyServicesLabels(context).appLanguage, style: getTextTheme(context).headline6),
          const Divider(),
          ...ServiceLocale.supportedLocales.map((Locale _locale) {
            return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return RadioListTile<Locale>(
                secondary: ServiceLocale.getLanguageIcon(_locale),
                title: Text(
                  ServiceLocale.getLanguageLabel(_locale),
                  style: getTextTheme(context).bodyText2,
                ),
                value: _locale,
                groupValue: ServiceLocale.watchLocale(ref),
                onChanged: (Locale? value) {
                  if (value != null) {
                    ServiceLocale.setLocale(ref, value);
                  }
                },
              );
            });
          }).toList(),
          const SizedBox(height: 20),
        ],
      );
    });
  }

  static Widget getLanguageIcon(Locale locale, {double width = 25}) {
    if (locale.languageCode == 'ar') {
      return Image.asset('flags/sa.png', width: width, package: 'my_services');
    } else if (locale.languageCode == 'en') {
      return Image.asset('flags/us.png', width: width, package: 'my_services');
    } else if (locale.languageCode == 'tr') {
      return Image.asset('flags/tr.png', width: width, package: 'my_services');
    } else if (locale.languageCode == 'fr') {
      return Image.asset('flags/fr.png', width: width, package: 'my_services');
    } else if (locale.languageCode == 'es') {
      return Image.asset('flags/sp.png', width: width, package: 'my_services');
    }

    return const SizedBox();
  }

  static String getLanguageLabel(Locale locale) {
    MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(ServiceNav.context);
    if (locale.languageCode == 'ar') {
      return myServicesLabels.arabic;
    } else if (locale.languageCode == 'en') {
      return myServicesLabels.english;
    } else if (locale.languageCode == 'tr') {
      return myServicesLabels.turkish;
    } else if (locale.languageCode == 'fr') {
      return myServicesLabels.french;
    } else if (locale.languageCode == 'es') {
      return myServicesLabels.spanish;
    }
    return '';
  }

  //we can not use ServiceNav.context in here
  static String currentLocaleLangCode(BuildContext context) => currentLocale(context).languageCode;

  //we can not use ServiceNav.context in here
  static Locale currentLocale(BuildContext context) => Localizations.localeOf(context);

  static List<LocalizationsDelegate<dynamic>> localizationsDelegates([List<LocalizationsDelegate<dynamic>> others = const []]) => <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        const MyServicesLocalizationsDelegate(),
        ...others,
      ];

  static bool isSupportedLocale(Locale locale) => supportedLocales.where((l) => l.languageCode == locale.languageCode).isNotEmpty;

  static bool isAr(BuildContext context) => currentLocaleLangCode(context) == 'ar';

  static bool isEn(BuildContext context) => currentLocaleLangCode(context) == 'en';

  static void toggleArEn(BuildContext context, ref) {
    isAr(context) ? setLocaleToEn(ref) : setLocaleToAr(ref);
  }

  //providers
  static Locale? watchLocale(WidgetRef ref) => MyServices.providers.watchLocale(ref);
  static Locale? readLocale(dynamic ref) => MyServices.providers.readLocale(ref);

  static void onLocaleChange(WidgetRef ref, Function(Locale? previous, Locale? next) listener) {
    MyServices.providers.onLocaleChange(ref, (previous, next) => listener);
  }

  // static void setLocaleWithoutSaving(dynamic ref, Locale value) {
  //   if (isSupportedLocale(value)) {
  //     MyServices.providers.setLocaleWithoutSaving(value);
  //   } else {
  //     logger.e("Unsupported locale");
  //   }
  // }

  static void setLocale(dynamic ref, Locale value) {
    if (isSupportedLocale(value)) {
      MyServices.providers.setLocale(ref, value);
    } else {
      logger.e("Unsupported locale");
    }
  }

  static void setLocaleToAr(dynamic ref) {
    if (isSupportedLocale(const Locale('ar'))) {
      MyServices.providers.setLocale(ref, const Locale('ar'));
    } else {
      logger.e("Unsupported locale");
    }
  }

  static void setLocaleToEn(dynamic ref) {
    if (isSupportedLocale(const Locale('en'))) {
      MyServices.providers.setLocale(ref, const Locale('en'));
    } else {
      logger.e("Unsupported locale");
    }
  }
}
