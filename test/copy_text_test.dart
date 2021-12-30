import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/my_services.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
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
