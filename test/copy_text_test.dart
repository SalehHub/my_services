import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/my_services.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test AppLauncher class', (WidgetTester tester) async {
    //locale
    expect(ServiceLocale.defaultLocale, const Locale('ar'));
    expect(ServiceLocale.supportedLocales, [const Locale('ar')]);

    //theme
    expect(ServiceTheme.lightAccentColor, const Color(0xf000b050));
    expect(ServiceTheme.darkAccentColor, const Color(0xf000b050));

    //firebase
    expect(AppLauncher.appWithFirebase, true);
    expect(AppLauncher.appWithFCM, true);
    expect(AppLauncher.appWithCrashlytics, true);

    AppLauncher appLauncher = AppLauncher(
      testing: true,
      initGeneralState: false,
      withFirebase: false,
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

    //firebase
    expect(AppLauncher.appWithFirebase, false);
    expect(AppLauncher.appWithFCM, false);
    expect(AppLauncher.appWithCrashlytics, false);

    await appLauncher.prepare();

    //locale
    expect(ServiceLocale.defaultLocale, const Locale("test1"));
    expect(ServiceLocale.supportedLocales, [const Locale("test1"), const Locale("test2")]);

    //theme
    expect(ServiceTheme.lightAccentColor, const Color(0x0f000000));
    expect(ServiceTheme.darkAccentColor, const Color(0xfddddddd));

    //firebase
    expect(AppLauncher.appWithFirebase, false);
    expect(AppLauncher.appWithFCM, false);
    expect(AppLauncher.appWithCrashlytics, false);
  });

  //
  testWidgets('Test CopyTextWidget', (WidgetTester tester) async {
    AppLauncher appLauncher = AppLauncher(testing: true, withFirebase: false, initGeneralState: false);
    await appLauncher.prepare();

    String copiedText = '';
    SystemChannels.platform.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == "Clipboard.setData") {
        copiedText = methodCall.arguments['text'];
      }
    });

    await tester.pumpWidget(appLauncher.mainWidget(title: "title", homePage: const CopyTextWidget(textToCopy: "MyTestCopyText", child: Text("MyTestText"))));

    final textFinder = find.text('MyTestText');
    expect(textFinder, findsNWidgets(1));

    final btnFinder = find.byKey(const ValueKey('copyBtn'));
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);

    expect(copiedText, "MyTestCopyText");
  });
}
