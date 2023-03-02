import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/my_services.dart';
import 'package:my_services/src/providers/exports.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Set Ref', (WidgetTester tester) async {
    AppLauncher appLauncher = AppLauncher(testing: true, config: const AppConfig(withFirebase: false), initGeneralState: false);
    await appLauncher.prepare();

    //ref not set yet
    try {
      bool c = MyServices.providers.ref == Object();
    } catch (e) {
      expect(e.toString(), contains("LateInitializationError: Field"));
    }

    await tester.pumpWidget(appLauncher.mainWidget(homePage: const Scaffold(body: SizedBox())));

    expect(MyServices.providers.ref.runtimeType.toString(), 'ConsumerStatefulElement');
  });
}
