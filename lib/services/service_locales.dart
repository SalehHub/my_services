import '../my_services.dart';
import '../providers/general_state_provider.dart';

class ServiceLocale {
  static Locale defaultLocale = const Locale('ar');
  static List<Locale> supportedLocales = [defaultLocale];

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
    MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(ServiceNav.context!);
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

  //providers
  static Locale? watchLocale(WidgetRef ref) => ref.watch(generalStateProvider.select((s) => s.locale));
  static void setLocaleWithoutSaving(dynamic ref, Locale value) {
    if (isSupportedLocale(value)) {
      ref.read(generalStateProvider.notifier).setLocaleWithoutSaving(value);
    } else {
      logger.e("Unsupported locale");
    }
  }

  static void setLocale(dynamic ref, Locale value) {
    if (isSupportedLocale(value)) {
      ref.read(generalStateProvider.notifier).setLocale(value);
    } else {
      logger.e("Unsupported locale");
    }
  }
}
