import '../my_services.dart';

typedef Overrides = List<Override> Function();

Future<void> myServicesMain({
  required Locale defaultLocale,
  required List<Locale> supportedLocales,
  required String title,
  required Widget homePage,
  Overrides? overrides,
  List<LocalizationsDelegate<dynamic>> delegates = const [],
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocale.defaultLocale = defaultLocale;
  ServiceLocale.supportedLocales = supportedLocales;

  await Firebase.initializeApp();
  await ServiceFirebaseCrashlytics.register();
  final GeneralState generalState = await getInitGeneralState();

  runApp(
    ProviderScope(
      overrides: [
        generalStateProvider.overrideWithProvider(
          StateNotifierProvider<GeneralStateNotifier, GeneralState>((ref) => GeneralStateNotifier(generalState, ref)),
        ),
        if (overrides != null) ...overrides(),
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
        theme: ServiceTheme.lightTheme(Colors.amber.shade900),
        darkTheme: ServiceTheme.darkTheme(Colors.amber),
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
