import '../my_services.dart';
import '../providers/general_state_provider.dart';

class ServiceAppDevice {
  ServiceAppDevice._();

  static AndroidDeviceInfo? _androidInfo;
  static PackageInfo? _packageInfo;
  static IosDeviceInfo? _iosInfo;
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<AppDeviceData> getAppAndDeviceData() async {
    final PackageInfo packageInfo = _packageInfo ?? (await PackageInfo.fromPlatform());

    late String deviceId;
    late String deviceOSVersion;
    late String deviceModel;

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = _androidInfo ?? (await _deviceInfoPlugin.androidInfo);
      deviceId = androidInfo.androidId;
      deviceOSVersion = androidInfo.version.release;
      deviceModel = androidInfo.model;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = _iosInfo ?? (await _deviceInfoPlugin.iosInfo);
      deviceId = iosInfo.identifierForVendor;
      deviceOSVersion = iosInfo.systemVersion;
      deviceModel = iosInfo.model;
    }

    return AppDeviceData(
      appVersion: packageInfo.version,
      appBuild: packageInfo.buildNumber,
      deviceID: deviceId,
      deviceOSVersion: deviceOSVersion,
      deviceModel: deviceModel,
      deviceOS: Platform.operatingSystem.toLowerCase(),
    );
  }

  //providers
  static String? watchAppBuild(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData?.appBuild));
  static bool watchIsFirstAppRun(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.isFirstAppRun));

  static String? readAppBuild(dynamic ref) => ref.read(generalStateProvider).appDeviceData?.appBuild;
  static bool readIsFirstAppRun(WidgetRef ref) => ref.read(generalStateProvider).isFirstAppRun;
}
