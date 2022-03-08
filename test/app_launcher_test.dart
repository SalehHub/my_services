import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/my_services.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test AppLauncher class', (WidgetTester tester) async {
    //locale
    expect(ServiceLocale.defaultLocale, const Locale('ar'));
    expect(ServiceLocale.supportedLocales, [const Locale('ar')]);

    //theme
    // expect(ServiceTheme.lightAccentColor, null);
    // expect(ServiceTheme.darkAccentColor, null);

    // expect(ServiceTheme.lightBgColor, null);
    // expect(ServiceTheme.darkBgColor, null);
    expect(ServiceTheme.borderRadius, const BorderRadius.all(Radius.zero));

    //appConfig + firebase
    expect(AppLauncher.appConfig.withFirebase, true);
    expect(AppLauncher.appConfig.withFCM, true);
    expect(AppLauncher.appConfig.withCrashlytics, true);

    //events
    expect(AppLauncher.appEvents.onDynamicLink, null);
    expect(AppLauncher.appEvents.onFCMTokenRefresh, null);
    expect(AppLauncher.appEvents.onGenerateTitle, null);
    expect(AppLauncher.appEvents.onLocaleChange, null);

    AppLauncher appLauncher = AppLauncher(
      testing: true,
      initGeneralState: false,
      config: AppConfig(withFirebase: false),
      events: AppEvents(
        onDynamicLink: (Uri _, WidgetRef __, BuildContext ___) {},
        onFCMTokenRefresh: (String _, WidgetRef __, BuildContext ___) {},
        onGenerateTitle: (BuildContext _) => "title",
        onLocaleChange: (Locale? _, Locale? __, WidgetRef ___, BuildContext _____) {},
      ),
      //
      defaultLocale: const Locale("test1"),
      supportedLocales: [const Locale("test1"), const Locale("test2")],
      //
      // lightAccentColor: const Color(0x0f000000),
      // darkAccentColor: const Color(0xfddddddd),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );

    //locale
    expect(ServiceLocale.defaultLocale, const Locale("test1"));
    expect(ServiceLocale.supportedLocales, [const Locale("test1"), const Locale("test2")]);

    //theme
    // expect(ServiceTheme.lightAccentColor, const Color(0x0f000000));
    // expect(ServiceTheme.darkAccentColor, const Color(0xfddddddd));

    // expect(ServiceTheme.lightBgColor, const Color(0xffffffff));
    // expect(ServiceTheme.darkBgColor, const Color(0xff161b1f));
    expect(ServiceTheme.borderRadius, const BorderRadius.all(Radius.circular(10)));

    //appConfig + firebase
    expect(AppLauncher.appConfig.withFirebase, false);
    expect(AppLauncher.appConfig.withFCM, false);
    expect(AppLauncher.appConfig.withCrashlytics, false);

    //events
    expect(AppLauncher.appEvents.onDynamicLink != null, true);
    expect(AppLauncher.appEvents.onFCMTokenRefresh != null, true);
    expect(AppLauncher.appEvents.onGenerateTitle != null, true);
    expect(AppLauncher.appEvents.onLocaleChange != null, true);

    await appLauncher.prepare();

    //locale
    expect(ServiceLocale.defaultLocale, const Locale("test1"));
    expect(ServiceLocale.supportedLocales, [const Locale("test1"), const Locale("test2")]);

    //theme
    // expect(ServiceTheme.lightAccentColor, const Color(0x0f000000));
    // expect(ServiceTheme.darkAccentColor, const Color(0xfddddddd));

    // expect(ServiceTheme.lightBgColor, const Color(0xffffffff));
    // expect(ServiceTheme.darkBgColor, const Color(0xff161b1f));

    //appConfig + firebase
    expect(AppLauncher.appConfig.withFirebase, false);
    expect(AppLauncher.appConfig.withFCM, false);
    expect(AppLauncher.appConfig.withCrashlytics, false);

    //events
    expect(AppLauncher.appEvents.onDynamicLink != null, true);
    expect(AppLauncher.appEvents.onFCMTokenRefresh != null, true);
    expect(AppLauncher.appEvents.onGenerateTitle != null, true);
    expect(AppLauncher.appEvents.onLocaleChange != null, true);
  });
}
