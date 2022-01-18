import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/my_services.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test AppLauncher class', (WidgetTester tester) async {
    //locale
    expect(ServiceLocale.defaultLocale, const Locale('ar'));
    expect(ServiceLocale.supportedLocales, [const Locale('ar')]);

    //theme
    expect(ServiceTheme.lightAccentColor, null);
    expect(ServiceTheme.darkAccentColor, null);

    expect(ServiceTheme.lightBgColor, null);
    expect(ServiceTheme.darkBgColor, null);

    //firebase
    // AppConfig appConfig = const AppConfig();
    expect(AppLauncher.appConfig.withFirebase, true);
    expect(AppLauncher.appConfig.withFCM, true);
    expect(AppLauncher.appConfig.withCrashlytics, true);

    AppLauncher appLauncher = AppLauncher(
      testing: true,
      initGeneralState: false,
      config: AppConfig(withFirebase: false),
      // withFirebase: false,
      //
      defaultLocale: const Locale("test1"),
      supportedLocales: [const Locale("test1"), const Locale("test2")],
      //
      lightAccentColor: const Color(0x0f000000),
      darkAccentColor: const Color(0xfddddddd),
    );

    //locale
    expect(ServiceLocale.defaultLocale, const Locale("test1"));
    expect(ServiceLocale.supportedLocales, [const Locale("test1"), const Locale("test2")]);

    //theme
    expect(ServiceTheme.lightAccentColor, const Color(0x0f000000));
    expect(ServiceTheme.darkAccentColor, const Color(0xfddddddd));

    expect(ServiceTheme.lightBgColor, const Color(0xffffffff));
    expect(ServiceTheme.darkBgColor, const Color(0xff161b1f));

    //firebase
    expect(AppLauncher.appConfig.withFirebase, false);
    expect(AppLauncher.appConfig.withFCM, false);
    expect(AppLauncher.appConfig.withCrashlytics, false);

    await appLauncher.prepare();

    //locale
    expect(ServiceLocale.defaultLocale, const Locale("test1"));
    expect(ServiceLocale.supportedLocales, [const Locale("test1"), const Locale("test2")]);

    //theme
    expect(ServiceTheme.lightAccentColor, const Color(0x0f000000));
    expect(ServiceTheme.darkAccentColor, const Color(0xfddddddd));

    expect(ServiceTheme.lightBgColor, const Color(0xffffffff));
    expect(ServiceTheme.darkBgColor, const Color(0xff161b1f));

    //firebase
    expect(AppLauncher.appConfig.withFirebase, false);
    expect(AppLauncher.appConfig.withFCM, false);
    expect(AppLauncher.appConfig.withCrashlytics, false);
  });
}
