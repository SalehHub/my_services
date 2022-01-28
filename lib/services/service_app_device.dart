import '../my_services.dart';
import '../providers/general_state_provider.dart';

class ServiceAppDevice {
  ServiceAppDevice._();

  static AndroidDeviceInfo? _androidInfo;
  static PackageInfo? _packageInfo;
  static IosDeviceInfo? _iosInfo;
  static WebBrowserInfo? _webBrowserInfo;
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static const String _deviceOS = "unknown";

  static Future<AppDeviceData> getAppAndDeviceData() async {
    final PackageInfo packageInfo = _packageInfo ?? (await PackageInfo.fromPlatform());

    late String? deviceId;
    late String? deviceOSVersion;
    late String? deviceModel;
    late String? deviceOS;
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = _webBrowserInfo ?? (await _deviceInfoPlugin.webBrowserInfo);
      deviceId = webBrowserInfo.userAgent;
      deviceOSVersion = webBrowserInfo.appVersion;
      deviceModel = webBrowserInfo.appName;
      deviceOS = webBrowserInfo.platform ?? _deviceOS;
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = _androidInfo ?? (await _deviceInfoPlugin.androidInfo);
      deviceId = androidInfo.androidId;
      deviceOSVersion = androidInfo.version.release;
      deviceModel = androidInfo.model;
      deviceOS = Platform.operatingSystem.toLowerCase();
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = _iosInfo ?? (await _deviceInfoPlugin.iosInfo);
      deviceId = iosInfo.identifierForVendor;
      deviceOSVersion = iosInfo.systemVersion;
      deviceModel = iosInfo.utsname.machine;
      deviceOS = Platform.operatingSystem.toLowerCase();
      // print(iosInfo.name);
      // print(iosInfo.localizedModel);
      // print(iosInfo.systemName);
      // print(iosInfo.systemVersion);
      // print(iosInfo.model);
      //
      // print(iosInfo.utsname.nodename);
      // print(iosInfo.utsname.machine);
      // print(iosInfo.utsname.release);
      // print(iosInfo.utsname.sysname);
      // print(iosInfo.utsname.version);
    }

    return AppDeviceData(
      appVersion: packageInfo.version,
      appBuild: packageInfo.buildNumber,
      deviceID: deviceId,
      deviceOSVersion: deviceOSVersion,
      deviceModel: deviceModel,
      deviceOS: deviceOS,
    );
  }

  //providers
  static String? watchAppBuild(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.appDeviceData?.appBuild));

  static bool watchIsFirstAppRun(dynamic ref) => ref.watch(generalStateProvider.select((s) => s.isFirstAppRun));

  static String? readAppBuild(dynamic ref) => ref.read(generalStateProvider).appDeviceData?.appBuild;

  static bool readIsFirstAppRun(WidgetRef ref) => ref.read(generalStateProvider).isFirstAppRun;
}
