import '../my_services.dart';

class ServiceLocale {
  const ServiceLocale();

  static Locale _defaultLocale = const Locale('ar');
  Locale get defaultLocale => _defaultLocale;

  static List<Locale> _supportedLocales = [const Locale('ar')];
  List<Locale> get supportedLocales => _supportedLocales;

  static final Set<LocalizationsDelegate<dynamic>> _delegates = {
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    const MyServicesLocalizationsDelegate(),
  };
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => _delegates.toList();

  void setDefaultLocale(Locale v) => _defaultLocale = v;
  void setSupportedLocales(List<Locale> v) => _supportedLocales = v;

  Widget getLocalSettingsSectionWidget() {
    return Builder(builder: (context) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Text(getMyServicesLabels(context).appLanguage, style: getTextTheme(context).titleLarge),
          const Divider(),
          //when nativeLocaleChange is true, show helper text
          if (MyServices.appConfig.nativeLocaleChange) Text(getMyServicesLabels(context).yourPhoneSettingsWillBeOpenedToChangeTheAppLanguage, style: getTextTheme(context).bodySmall),
          //
          ...supportedLocales.map((Locale locale) {
            return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return RadioListTile<Locale>(
                secondary: getLanguageIcon(locale),
                title: Text(
                  getLanguageLabel(locale),
                  style: getTextTheme(context).bodyMedium,
                ),
                value: locale,
                groupValue: currentLocale(context), // watchLocale(ref),
                onChanged: (Locale? value) {
                  if (MyServices.appConfig.nativeLocaleChange) {
                    AppSettings.openNotificationSettings(); //appSettings
                  } else {
                    if (value != null) {
                      MyServices.providers.setLocale(value);
                    }
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
    MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(MyServices.context);
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

  void addLocalizationsDelegates([List<LocalizationsDelegate<dynamic>> others = const []]) {
    _delegates.addAll(others);
  }

  bool isSupportedLocale(Locale locale) => supportedLocales.where((l) => l.languageCode == locale.languageCode).isNotEmpty;

  bool isAr(BuildContext context) => currentLocaleLangCode(context) == 'ar';

  bool isEn(BuildContext context) => currentLocaleLangCode(context) == 'en';

  void toggleArEn(BuildContext context) {
    isAr(context) ? setLocaleToEn() : setLocaleToAr();
  }

  // void onLocaleChange(WidgetRef ref, Function(Locale? previous, Locale? next) listener) {
  //   MyServices.providers.onLocaleChange(ref, (previous, next) => listener);
  // }

  //  void setLocaleWithoutSaving(dynamic ref, Locale value) {
  //   if (isSupportedLocale(value)) {
  // MyServices.providers.setLocaleWithoutSaving(value);
  //   } else {
  //     logger.e("Unsupported locale");
  //   }
  // }

  void setLocaleToAr() => MyServices.providers.setLocale(const Locale('ar'));

  void setLocaleToEn() => MyServices.providers.setLocale(const Locale('en'));
}
