import '../my_services.dart';
import 'general_state_provider.dart';

class MyServices {
  MyServices._();

  static String? watchAppBuild(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData?.appBuild));
  static bool watchIsFirstAppRun(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.isFirstAppRun));
  static String? readAppBuild(dynamic ref) => _readGeneralState(ref).appDeviceData?.appBuild;
  static bool readIsFirstAppRun(WidgetRef ref) => _readGeneralState(ref).isFirstAppRun;

  static String? readAccessToken(dynamic ref) => _readGeneralState(ref).accessToken;
  static Future<void> setAccessToken(dynamic ref, String? value) => _readGeneralStateNotifier(ref).setAccessToken(value);

  static Map<String, dynamic> asMap(Ref ref) => _readGeneralStateNotifier(ref).asMap;

  static GeneralStateNotifier _readGeneralStateNotifier(dynamic ref) => ref.read(generalStateProvider.notifier);
  static GeneralState _readGeneralState(dynamic ref) => ref.read(generalStateProvider);
}
