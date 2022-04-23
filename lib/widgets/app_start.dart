import '../my_services.dart';
import '../providers/general_state_provider.dart';

typedef Overrides = Future<List<Override>> Function();
GeneralState _generalState = GeneralState();
List<Override> _readyOverrides = [];

class AppLauncher {
  //is testing
  final bool testing;

  //locale
  final Locale defaultLocale;
  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate<dynamic>> delegates;

  //theme
  final MyThemeData darkTheme;
  final MyThemeData lightTheme;

  //storage
  // final MyStorage? storage;

  //borderRadius
  final BorderRadius borderRadius;

  //providers
  final bool initGeneralState;
  final Overrides? overrides;
  final List<ProviderObserver> observers;

  // app config & events
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
    // this.storage,

    // borderRadius
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),

    //providers
    this.initGeneralState = true,
    this.overrides,
    this.observers = const [],

    //testing
    this.testing = false,

    // app config & events
    this.config,
    this.events,
  }) {
    
    MyServices.register();

    if (config != null) {
      MyServices.appConfig = config!.copyWith(
        withCrashlytics: config!.withFirebase == true && config!.withCrashlytics == true,
        withFCM: config!.withFirebase == true && config!.withFCM == true,
      );
    }
    if (events != null) {
      MyServices.appEvents = events!;
    }

    ServiceTheme.dark = darkTheme;
    ServiceTheme.light = lightTheme;

    // if (storage != null) {
    //   MyServices.storage = storage!;
    // }

    ServiceTheme.borderRadius = borderRadius;

    MyServices.services.locale.setDefaultLocale(defaultLocale);
    MyServices.services.locale.setSupportedLocales(supportedLocales);
  }

  Future<void> prepare() async {
    if (!testing) {
      WidgetsFlutterBinding.ensureInitialized();
    }

    if (MyServices.appConfig.withFirebase) {
      await Firebase.initializeApp(options: MyServices.appConfig.firebaseOptions); //firebaseCore
    }

    if (MyServices.appConfig.withCrashlytics) {
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
        onGenerateTitle: MyServices.appEvents.onGenerateTitle,
        //
        localizationsDelegates: MyServices.services.locale.localizationsDelegates(delegates),
        supportedLocales: MyServices.services.locale.supportedLocales,
        locale: MyServices.services.locale.watchLocale(ref),
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
