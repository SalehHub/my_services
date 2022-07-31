import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/my_services.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Test AppLauncher class default config', (WidgetTester tester) async {
    //
    MyServices.register();

    //locale
    expect(MyServices.services.locale.defaultLocale, const Locale("ar"));
    expect(MyServices.services.locale.supportedLocales, [const Locale("ar")]);
    expect(MyServices.services.locale.localizationsDelegates, [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      const MyServicesLocalizationsDelegate(),
    ]);

    //theme
    expect(MyServices.services.theme.borderRadius, const BorderRadius.all(Radius.zero));

    //appConfig + firebase
    expect(MyServices.appConfig.withFirebase, true);
    expect(MyServices.appConfig.withFCM, true);
    expect(MyServices.appConfig.withCrashlytics, true);
    expect(MyServices.appConfig.nativeLocaleChange, false);

    //events
    expect(MyServices.appEvents.onDynamicLink == null, true);
    expect(MyServices.appEvents.onFCMTokenRefresh == null, true);
    expect(MyServices.appEvents.onGenerateTitle == null, true);
    expect(MyServices.appEvents.onLocaleChange == null, true);
    expect(MyServices.appEvents.onFirebaseNotification == null, true);

    //test alias
    expect(MyS.appEvents.onFirebaseNotification == null, true);
    expect(MyS.appConfig.withCrashlytics, true);
    expect(MyS.appConfig.withCrashlytics, true);
    expect(MyS.services.locale.defaultLocale, const Locale("ar"));
    //
  });
}
