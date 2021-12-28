import '../my_services.dart';
import '../providers/general_state_provider.dart';

typedef Overrides = Future<List<Override>> Function();

class AppLauncher {
  GeneralState _generalState = GeneralState();
  List<Override> _readyOverrides = [];

  static bool appWithFirebase = true;
  static bool appWithCrashlytics = true;
  static bool appWithFCM = true;

  //static bool appInitGeneralState = true;

  final bool testing;

  final Locale defaultLocale;
  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate<dynamic>> delegates;

  final bool withFirebase;
  final bool withCrashlytics;
  final bool withFCM;

  final bool initGeneralState;

  final Color? lightAccentColor;
  final Color? darkAccentColor;

  final Overrides? overrides;

  AppLauncher({
    //locale
    this.defaultLocale = const Locale('ar'),
    this.supportedLocales = const [Locale('ar'), Locale('en')],
    this.delegates = const [],
    //theme
    this.lightAccentColor,
    this.darkAccentColor,
    //firebase
    this.withFirebase = true,
    this.withCrashlytics = true,
    this.withFCM = true,
    //providers
    this.initGeneralState = true,
    this.overrides,
    //testing
    this.testing = false,
  }) {
    appWithFirebase = withFirebase;
    appWithCrashlytics = withFirebase && withCrashlytics;
    appWithFCM = withFirebase && withFCM;
    //appInitGeneralState = initGeneralState;

    ServiceTheme.lightAccentColor = lightAccentColor;
    ServiceTheme.darkAccentColor = darkAccentColor;

    ServiceLocale.defaultLocale = defaultLocale;
    ServiceLocale.supportedLocales = supportedLocales;
  }

  Future<void> prepare() async {
    if (!testing) {
      WidgetsFlutterBinding.ensureInitialized();
    }

    if (appWithFirebase) {
      await Firebase.initializeApp();
    }

    if (appWithCrashlytics) {
      await ServiceFirebaseCrashlytics.register();
    }

    if (initGeneralState) {
      _generalState = await getGeneralState();
    }

    if (overrides != null) {
      _readyOverrides = await overrides!();
    }
  }

  //for testing
  Widget mainWidget({required Widget homePage, String title = ''}) {
    return ProviderScope(
      overrides: [
        initialGeneralStateProvider.overrideWithValue(_generalState),
        ..._readyOverrides,
      ],
      child: AppStart(title: title, homePage: homePage, delegates: delegates),
    );
  }

  void run({required Widget homePage, String title = ''}) {
    runApp(mainWidget(homePage: homePage, title: title));
  }
}

class AppStart extends StatelessWidget {
  const AppStart({
    Key? key,
    required this.delegates,
    required this.title,
    required this.homePage,
  }) : super(key: key);

  final List<LocalizationsDelegate<dynamic>> delegates;
  final String title;
  final Widget homePage;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final ThemeMode? themeMode = MyServices.watchThemeMode(ref);
      final Locale? locale = MyServices.watchLocale(ref);

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        //
        localizationsDelegates: ServiceLocale.localizationsDelegates(delegates),
        supportedLocales: ServiceLocale.supportedLocales,
        locale: locale,
        //
        themeMode: themeMode,
        theme: ServiceTheme.lightTheme(),
        darkTheme: ServiceTheme.darkTheme(),
        //
        home: homePage,
        builder: (BuildContext context, Widget? child) => Unfocus(child: child),
        //
        initialRoute: '/',
        navigatorKey: ServiceNav.navigatorKey,
        navigatorObservers: ServiceNav.navigatorObservers,
      );
    });
  }
}

// bool appWithFirebase = true;
// bool appWithCrashlytics = true;
// bool appInitGeneralState = true;
// bool appWithFCM = true;
//
// Future<void> myServicesRunApp({
//   required Locale defaultLocale,
//   required List<Locale> supportedLocales,
//   required String title,
//   required Widget homePage,
//   bool withFirebase = true,
//   bool withCrashlytics = true,
//   bool withFCM = true,
//   bool initGeneralState = true,
//   Color? lightAccentColor,
//   Color? darkAccentColor,
//   Overrides? overrides,
//   List<LocalizationsDelegate<dynamic>> delegates = const [],
// }) async {
//   appWithFirebase = withFirebase;
//   appWithCrashlytics = withCrashlytics;
//   appWithFCM = withFCM;
//   appInitGeneralState = initGeneralState;
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   ServiceTheme.lightAccentColor = lightAccentColor;
//   ServiceTheme.darkAccentColor = darkAccentColor;
//
//   ServiceLocale.defaultLocale = defaultLocale;
//   ServiceLocale.supportedLocales = supportedLocales;
//   GeneralState generalState = GeneralState();
//
//   if (withFirebase) {
//     await Firebase.initializeApp();
//   }
//
//   if (withFirebase && withCrashlytics) {
//     await ServiceFirebaseCrashlytics.register();
//   }
//
//   if (initGeneralState) {
//     generalState = await getGeneralState();
//   }
//
//   runApp(
//     ProviderScope(
//       overrides: [
//         initialGeneralStateProvider.overrideWithValue(generalState),
//         if (overrides != null) ...await overrides(),
//       ],
//       child: AppStart(
//         title: title,
//         homePage: homePage,
//         delegates: delegates,
//       ),
//     ),
//   );
// }
