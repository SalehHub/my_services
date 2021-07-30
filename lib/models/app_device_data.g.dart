// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_device_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppDeviceData _$_$_AppDeviceDataFromJson(Map<String, dynamic> json) {
  return _$_AppDeviceData(
    appVersion: json['appVersion'] as String,
    appBuild: json['appBuild'] as String,
    deviceID: json['deviceID'] as String?,
    deviceOSVersion: json['deviceOSVersion'] as String?,
    deviceModel: json['deviceModel'] as String?,
    deviceOS: json['deviceOS'] as String?,
  );
}

Map<String, dynamic> _$_$_AppDeviceDataToJson(_$_AppDeviceData instance) => <String, dynamic>{
      'appVersion': instance.appVersion,
      'appBuild': instance.appBuild,
      'deviceID': instance.deviceID,
      'deviceOSVersion': instance.deviceOSVersion,
      'deviceModel': instance.deviceModel,
      'deviceOS': instance.deviceOS,
    };
