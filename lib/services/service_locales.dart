import '../my_services.dart';

class ServiceLocale {
  Locale _defaultLocale = const Locale('ar');
  List<Locale> _supportedLocales = [const Locale('ar')];

  void setDefaultLocale(Locale v) => _defaultLocale = v;
  void setSupportedLocales(List<Locale> v) => _supportedLocales = v;

  Locale get defaultLocale => _defaultLocale;
  List<Locale> get supportedLocales => _supportedLocales;

  Widget getLocalSettingsSectionWidget() {
    return Builder(builder: (context) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Text(getMyServicesLabels(context).appLanguage, style: getTextTheme(context).headline6),
          const Divider(),
          Text(getMyServicesLabels(context).yourPhoneSettingsWillBeOpenedToChangeTheAppLanguage, style: getTextTheme(context).caption),
          ...supportedLocales.map((Locale _locale) {
            return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return RadioListTile<Locale>(
                secondary: getLanguageIcon(_locale),
                title: Text(
                  getLanguageLabel(_locale),
                  style: getTextTheme(context).bodyText2,
                ),
                value: _locale,
                groupValue: currentLocale(context), // watchLocale(ref),
                onChanged: (Locale? value) {
                  AppSettings.openNotificationSettings(); //appSettings

                  // if (value != null) {
                  //   setLocale(ref, value);
                  // }
                },
              );
            });
          }).toList(),
          const SizedBox(height: 20),
        ],
      );
    });
  }

  Widget getLanguageIcon(Locale locale, {double width = 25}) {
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

  String getLanguageLabel(Locale locale) {
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
  String currentLocaleLangCode(BuildContext context) => currentLocale(context).languageCode;

  //we can not use ServiceNav.context in here
  Locale currentLocale(BuildContext context) => Localizations.localeOf(context);

  List<LocalizationsDelegate<dynamic>> localizationsDelegates([List<LocalizationsDelegate<dynamic>> others = const []]) => <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        const MyServicesLocalizationsDelegate(),
        ...others,
      ];

  bool isSupportedLocale(Locale locale) => supportedLocales.where((l) => l.languageCode == locale.languageCode).isNotEmpty;

  bool isAr(BuildContext context) => currentLocaleLangCode(context) == 'ar';

  bool isEn(BuildContext context) => currentLocaleLangCode(context) == 'en';

  void toggleArEn(BuildContext context, ref) {
    isAr(context) ? setLocaleToEn(ref) : setLocaleToAr(ref);
  }

  //providers
  // Locale? watchLocale(WidgetRef ref) => MyServices.providers.watchLocale(ref);
  // Locale? readLocale(dynamic ref) => MyServices.providers.readLocale(ref);

  void onLocaleChange(WidgetRef ref, Function(Locale? previous, Locale? next) listener) {
    MyServices.providers.onLocaleChange(ref, (previous, next) => listener);
  }

  //  void setLocaleWithoutSaving(dynamic ref, Locale value) {
  //   if (isSupportedLocale(value)) {
  //     MyServices.providers.setLocaleWithoutSaving(value);
  //   } else {
  //     logger.e("Unsupported locale");
  //   }
  // }

  void setLocale(dynamic ref, Locale value) {
    if (isSupportedLocale(value)) {
      MyServices.providers.setLocale(ref, value);
    } else {
      logger.e("Unsupported locale");
    }
  }

  void setLocaleToAr(dynamic ref) {
    if (isSupportedLocale(const Locale('ar'))) {
      MyServices.providers.setLocale(ref, const Locale('ar'));
    } else {
      logger.e("Unsupported locale");
    }
  }

  void setLocaleToEn(dynamic ref) {
    if (isSupportedLocale(const Locale('en'))) {
      MyServices.providers.setLocale(ref, const Locale('en'));
    } else {
      logger.e("Unsupported locale");
    }
  }
}
