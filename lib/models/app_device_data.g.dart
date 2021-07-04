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
    osVersion: json['osVersion'] as String?,
    deviceModel: json['deviceModel'] as String?,
  );
}

Map<String, dynamic> _$_$_AppDeviceDataToJson(_$_AppDeviceData instance) => <String, dynamic>{
      'appVersion': instance.appVersion,
      'appBuild': instance.appBuild,
      'deviceID': instance.deviceID,
      'osVersion': instance.osVersion,
      'deviceModel': instance.deviceModel,
    };
