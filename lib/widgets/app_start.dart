import '../my_services.dart';
import '../providers/general_state_provider.dart';

typedef Overrides = Future<List<Override>> Function();

class AppLauncher {
  GeneralState _generalState = GeneralState();
  List<Override> _readyOverrides = [];
  //
  static bool _appWithFirebase = true;
  static bool get appWithFirebase => _appWithFirebase;
  static bool _appWithCrashlytics = true;
  static bool get appWithCrashlytics => _appWithCrashlytics;
  static bool _appWithFCM = true;
  static bool get appWithFCM => _appWithFCM;
  //

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

  final Color? lightBgColor;
  final Color? darkBgColor;

  final Color? lightCardColor;
  final Color? darkCardColor;

  final Overrides? overrides;
  final List<ProviderObserver>? observers;

  AppLauncher({
    //locale
    this.defaultLocale = const Locale('ar'),
    this.supportedLocales = const [Locale('ar'), Locale('en')],
    this.delegates = const [],
    //theme
    this.lightAccentColor = const Color(0xff219ebc),
    this.darkAccentColor = const Color(0xff219ebc),
    //
    this.lightBgColor = const Color(0xffffffff),
    this.darkBgColor = const Color(0xff161B1F),
    //
    this.darkCardColor = const Color(0xff161B1F),
    this.lightCardColor = const Color(0xffffffff),
    //firebase
    this.withFirebase = true,
    this.withCrashlytics = true,
    this.withFCM = true,
    //providers
    this.initGeneralState = true,
    this.overrides,
    this.observers,
    //testing
    this.testing = false,
  }) {
    _appWithFirebase = withFirebase;
    _appWithCrashlytics = withFirebase && withCrashlytics;
    _appWithFCM = withFirebase && withFCM;

    ServiceTheme.lightAccentColor = lightAccentColor;
    ServiceTheme.darkAccentColor = darkAccentColor;

    ServiceTheme.lightBgColor = lightBgColor;
    ServiceTheme.darkBgColor = darkBgColor;

    ServiceTheme.lightCardColor = lightCardColor;
    ServiceTheme.darkCardColor = darkCardColor;

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
      observers: this.observers,
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
  const AppStart({Key? key, required this.delegates, required this.title, required this.homePage}) : super(key: key);

  final List<LocalizationsDelegate<dynamic>> delegates;
  final String title;
  final Widget homePage;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        //
        localizationsDelegates: ServiceLocale.localizationsDelegates(delegates),
        supportedLocales: ServiceLocale.supportedLocales,
        locale: ServiceLocale.watchLocale(ref),
        //
        themeMode: ServiceTheme.watchThemeMode(ref),
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
