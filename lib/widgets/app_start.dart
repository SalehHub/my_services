import '../my_services.dart';
import '../providers/general_state_provider.dart';

typedef Overrides = Future<List<Override>> Function();

class AppLauncher {
  GeneralState _generalState = GeneralState();
  List<Override> _readyOverrides = [];

  final bool testing;

  final Locale defaultLocale;
  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate<dynamic>> delegates;

  // App Config
  static AppConfig get appConfig => _appConfig ?? AppConfig();
  static AppConfig? _appConfig;

  // App Events
  static AppEvents get appEvents => _appEvents ?? AppEvents();
  static AppEvents? _appEvents;

  //
  final bool initGeneralState;

  final Color? lightAccentColor;
  final Color? darkAccentColor;

  final Color? lightBgColor;
  final Color? darkBgColor;

  final Color? lightCardColor;
  final Color? darkCardColor;

  final Overrides? overrides;
  final List<ProviderObserver>? observers;
  //
  final AppConfig? config;
  final AppEvents? events;

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
    //providers
    this.initGeneralState = true,
    this.overrides,
    this.observers,
    //
    //testing
    this.testing = false,
    this.config,
    this.events,
  }) {
    _appConfig = config?.copyWith(
      withCrashlytics: config?.withFirebase == true && config?.withCrashlytics == true,
      withFCM: config?.withFirebase == true && config?.withFCM == true,
    );

    _appEvents = events;

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

    if (appConfig.withFirebase) {
      await Firebase.initializeApp(); //firebaseCore
    }

    if (appConfig.withCrashlytics) {
      await ServiceFirebaseCrashlytics.register(); //firebaseCrashlytics
    }

    if (initGeneralState) {
      _generalState = await getGeneralState();
    }

    if (overrides != null) {
      _readyOverrides = await overrides!();
    }
  }

  //for testing
  Widget mainWidget({required Widget homePage}) {
    return ProviderScope(
      observers: observers,
      overrides: [
        initialGeneralStateProvider.overrideWithValue(_generalState),
        ..._readyOverrides,
      ],
      child: AppStart(homePage: homePage, delegates: delegates),
    );
  }

  void run({required Widget homePage}) {
    runApp(mainWidget(homePage: homePage));
  }
}

class AppStart extends StatelessWidget {
  const AppStart({Key? key, required this.delegates, required this.homePage}) : super(key: key);

  final List<LocalizationsDelegate<dynamic>> delegates;
  final Widget homePage;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: AppLauncher.appEvents.onGenerateTitle,
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
