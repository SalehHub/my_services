import '../my_services.dart';

class ServiceAppDevice {
  const ServiceAppDevice();

  //
  static AndroidDeviceInfo? _androidInfo;
  static PackageInfo? _packageInfo;
  static IosDeviceInfo? _iosInfo;
  static MacOsDeviceInfo? _macOsInfo;
  // static WindowsDeviceInfo? _windowsInfo;
  static WebBrowserInfo? _webBrowserInfo;
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<AppDeviceData> getAppAndDeviceData() async {
    final PackageInfo packageInfo = _packageInfo ?? (await PackageInfo.fromPlatform());
    String deviceIdCacheKey = "deviceIdStoredValue";

    String? deviceId;
    String? deviceOSVersion;
    String? deviceModel;
    String? deviceOS;

    if (!kIsWeb) {
      deviceOS = Platform.operatingSystem.toLowerCase();
    }

    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = _webBrowserInfo ?? (await _deviceInfoPlugin.webBrowserInfo);
      deviceId = webBrowserInfo.userAgent;
      deviceOSVersion = webBrowserInfo.appVersion;
      deviceModel = webBrowserInfo.appName;
      deviceOS = webBrowserInfo.platform ?? "unknown";
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = _androidInfo ?? (await _deviceInfoPlugin.androidInfo);
      deviceId = null;
      deviceOSVersion = androidInfo.version.release;
      deviceModel = androidInfo.model;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = _iosInfo ?? (await _deviceInfoPlugin.iosInfo);
      deviceId = iosInfo.identifierForVendor;
      deviceOSVersion = iosInfo.systemVersion;
      deviceModel = iosInfo.utsname.machine;
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
    } else if (Platform.isWindows) {
      // final WindowsDeviceInfo windowsInfo = _windowsInfo ?? (await _deviceInfoPlugin.windowsInfo);
      deviceId = null;
      deviceOSVersion = null;
      deviceModel = null;
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
