import '../my_services.dart';

typedef Overrides = Future<List<Override>> Function();

class AppLauncher {
  final bool testing;

  //locale
  final Locale defaultLocale;
  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate<dynamic>> delegates;

  // App Config
  static AppConfig get appConfig => _appConfig ?? AppConfig();
  static AppConfig? _appConfig;

  // App Events
  static AppEvents get appEvents => _appEvents ?? AppEvents();
  static AppEvents? _appEvents;

  //theme
  final MyThemeData darkTheme;
  final MyThemeData lightTheme;

  //storage
  final MyStorage? storage;

  final BorderRadius borderRadius;

  //providers
  final bool initGeneralState;
  final Overrides? overrides;
  final List<ProviderObserver> observers;

  //
  final AppConfig? config;
  final AppEvents? events;

  AppLauncher({
    //locale
    this.defaultLocale = const Locale('ar'),
    this.supportedLocales = const [Locale('ar'), Locale('en')],
    this.delegates = const [],

    //theme
    this.lightTheme = MyThemeData.light,
    this.darkTheme = MyThemeData.dark,

    //storage
    this.storage,

    //
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),

    //providers
    this.initGeneralState = true,
    this.overrides,
    this.observers = const [],

    //testing
    this.testing = false,

    //
    this.config,
    this.events,
  }) {
    _appConfig = config?.copyWith(
      withCrashlytics: config?.withFirebase == true && config?.withCrashlytics == true,
      withFCM: config?.withFirebase == true && config?.withFCM == true,
    );

    _appEvents = events;

    ServiceTheme.dark = darkTheme;
    ServiceTheme.light = lightTheme;

    if (storage != null) {
      MyServices.storage = storage!;
    }
    // ServiceTheme.lightAccentColor = lightAccentColor;
    // ServiceTheme.darkAccentColor = darkAccentColor;

    // ServiceTheme.lightBgColor = lightBgColor;
    // ServiceTheme.darkBgColor = darkBgColor;

    // ServiceTheme.lightCardColor = lightCardColor;
    // ServiceTheme.darkCardColor = darkCardColor;

    ServiceTheme.borderRadius = borderRadius;

    ServiceLocale.defaultLocale = defaultLocale;
    ServiceLocale.supportedLocales = supportedLocales;
  }

  GeneralState _generalState = GeneralState();
  List<Override> _readyOverrides = [];

  Future<void> prepare() async {
    if (!testing) {
      WidgetsFlutterBinding.ensureInitialized();
    }

    if (appConfig.withFirebase) {
      await Firebase.initializeApp(options: appConfig.firebaseOptions); //firebaseCore
    }

    if (appConfig.withCrashlytics) {
      await ServiceFirebaseCrashlytics.register(); //firebaseCrashlytics
    }

    if (initGeneralState) {
      _generalState = await MyServices.storage.getGeneralState() ?? await getGeneralState(); // TODO: remove getGeneralState()
    }

    if (overrides != null) {
      _readyOverrides = await overrides!();
    }
  }

  //for testing
  Widget mainWidget({required Widget homePage}) {
    return ProviderScope(
      observers: [const GeneralStateSaver(), ...observers],
      overrides: [
        initialGeneralStateProvider.overrideWithValue(_generalState),
        ..._readyOverrides,
      ],
      child: AppStart(homePage: homePage, delegates: delegates),
    );
  }

  void run({required Widget homePage}) {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });

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

class GeneralStateSaver extends ProviderObserver {
  const GeneralStateSaver();

  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    if (newValue is GeneralState) {
      if (newValue != previousValue) {
        MyServices.storage.setGeneralState(newValue.toJson());
        logger.w((newValue == previousValue).toString() + " - New GeneralState Saved");
      }
    }
  }
}
