import '../my_services.dart';

typedef Overrides = Future<List<Override>> Function();

bool appWithFirebase = true;
bool appWithCrashlytics = true;
bool appInitGeneralState = true;
bool appWithFCM = true;

Future<void> myServicesRunApp({
  required Locale defaultLocale,
  required List<Locale> supportedLocales,
  required String title,
  required Widget homePage,
  bool withFirebase = true,
  bool withCrashlytics = true,
  bool withFCM = true,
  bool initGeneralState = true,
  Color? lightAccentColor,
  Color? darkAccentColor,
  Overrides? overrides,
  List<LocalizationsDelegate<dynamic>> delegates = const [],
}) async {
  appWithFirebase = withFirebase;
  appWithCrashlytics = withCrashlytics;
  appWithFCM = withFCM;
  appInitGeneralState = initGeneralState;

  WidgetsFlutterBinding.ensureInitialized();

  ServiceTheme.lightAccentColor = lightAccentColor;
  ServiceTheme.darkAccentColor = darkAccentColor;

  ServiceLocale.defaultLocale = defaultLocale;
  ServiceLocale.supportedLocales = supportedLocales;
  GeneralState generalState = GeneralState();

  if (withFirebase) {
    await Firebase.initializeApp();
  }

  if (withFirebase && withCrashlytics) {
    await ServiceFirebaseCrashlytics.register();
  }

  if (initGeneralState) {
    generalState = await getGeneralState();
  }

  runApp(
    ProviderScope(
      overrides: [
        initialGeneralStateProvider.overrideWithValue(generalState),
        if (overrides != null) ...await overrides(),
      ],
      child: AppStart(
        title: title,
        homePage: homePage,
        delegates: delegates,
      ),
    ),
  );
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
      final ThemeMode? themeMode = watchThemeMode(ref);
      final Locale? locale = watchLocale(ref);

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
