import '../my_services.dart';

class ServiceAppDevice {
  const ServiceAppDevice._();
  static const ServiceAppDevice _s = ServiceAppDevice._();
  factory ServiceAppDevice() => _s;
  //
  static AndroidDeviceInfo? _androidInfo;
  static PackageInfo? _packageInfo;
  static IosDeviceInfo? _iosInfo;
  static MacOsDeviceInfo? _macOsInfo;
  static WebBrowserInfo? _webBrowserInfo;
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static const String _deviceOS = "unknown";

  static Future<AppDeviceData> getAppAndDeviceData() async {
    final PackageInfo packageInfo = _packageInfo ?? (await PackageInfo.fromPlatform());
    String deviceIdCacheKey = "deviceIdStoredValue";

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
    } else if (Platform.isMacOS) {
      final MacOsDeviceInfo macOsInfo = _macOsInfo ?? (await _deviceInfoPlugin.macOsInfo);
      deviceId = macOsInfo.systemGUID;
      deviceOSVersion = macOsInfo.osRelease;
      deviceModel = macOsInfo.model;
      deviceOS = Platform.operatingSystem.toLowerCase();
    }

    //generate and store an uuid as device id when real device id is null
    if (deviceId == null || deviceId.trim() == "") {
      deviceId = await MyServices.storage.get(deviceIdCacheKey);
      if (deviceId == null || deviceId.trim() == "") {
        deviceId = "${MyServices.helpers.getUuid()}-G";
        await MyServices.storage.set(deviceIdCacheKey, deviceId);
      }
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
}
