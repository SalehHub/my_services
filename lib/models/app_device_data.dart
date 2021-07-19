import '../my_services.dart';

part 'app_device_data.freezed.dart';
part 'app_device_data.g.dart';

@freezed
class AppDeviceData with _$AppDeviceData {
  const AppDeviceData._();

  factory AppDeviceData.notInitialized() => AppDeviceData(appVersion: '', appBuild: '');

  factory AppDeviceData({
    required String appVersion,
    required String appBuild,
    String? deviceID,
    String? osVersion,
    String? deviceModel,
  }) = _AppDeviceData;

  factory AppDeviceData.fromJson(Map<String, dynamic> json) => _$AppDeviceDataFromJson(json);
}
