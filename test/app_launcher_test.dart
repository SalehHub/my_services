import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/my_services.dart';

Future<void> main() async {
  //
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Test AppLauncher class initilization', (WidgetTester tester) async {
    AppLauncher appLauncher = AppLauncher(
      //
      defaultLocale: const Locale("test1"),
      supportedLocales: [const Locale("test1"), const Locale("test2")],
      delegates: [
        //we added this again to make sure no deplication occure
        const MyServicesLocalizationsDelegate(),

        //new dummuy delegate
        const _TestDelegate(),
      ],
      //
      testing: true,
      initGeneralState: false,
      config: AppConfig(
        withFirebase: false,
        nativeLocaleChange: true,
      ),
      events: AppEvents(
        onDynamicLink: (Uri _, WidgetRef __, BuildContext ___) {
          return '';
        },
        onFCMTokenRefresh: (String _, WidgetRef __, BuildContext ___) {},
        onGenerateTitle: (BuildContext _) => "title",
        onLocaleChange: (Locale? _, Locale? __, WidgetRef ___, BuildContext _____) {},
        onFirebaseNotification: (ref, message, s) {},
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );

    await appLauncher.prepare();

    //locale
    expect(MyServices.services.locale.defaultLocale, const Locale("test1"));
    expect(MyServices.services.locale.supportedLocales, [const Locale("test1"), const Locale("test2")]);
    expect(MyServices.services.locale.localizationsDelegates, [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      const MyServicesLocalizationsDelegate(),
      const _TestDelegate(),
    ]);

    //theme
    expect(MyServices.services.theme.borderRadius, const BorderRadius.all(Radius.circular(10)));

    //appConfig + firebase
    expect(MyServices.appConfig.withFirebase, false);
    expect(MyServices.appConfig.withFCM, false);
    expect(MyServices.appConfig.withCrashlytics, false);
    expect(MyServices.appConfig.nativeLocaleChange, true);

    //events
    expect(MyServices.appEvents.onDynamicLink != null, true);
    expect(MyServices.appEvents.onFCMTokenRefresh != null, true);
    expect(MyServices.appEvents.onGenerateTitle != null, true);
    expect(MyServices.appEvents.onLocaleChange != null, true);
    expect(MyServices.appEvents.onFirebaseNotification != null, true);
  });
}

class _TestDelegate extends LocalizationsDelegate {
  const _TestDelegate();
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future load(Locale locale) async {}

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
