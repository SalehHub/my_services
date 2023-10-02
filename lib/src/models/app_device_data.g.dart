// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_device_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppDeviceDataImpl _$$AppDeviceDataImplFromJson(Map<String, dynamic> json) => _$AppDeviceDataImpl(
      appVersion: json['appVersion'] as String,
      appBuild: json['appBuild'] as String,
      deviceID: json['deviceID'] as String?,
      deviceOSVersion: json['deviceOSVersion'] as String?,
      deviceModel: json['deviceModel'] as String?,
      deviceOS: json['deviceOS'] as String?,
    );

Map<String, dynamic> _$$AppDeviceDataImplToJson(_$AppDeviceDataImpl instance) => <String, dynamic>{
      'appVersion': instance.appVersion,
      'appBuild': instance.appBuild,
      'deviceID': instance.deviceID,
      'deviceOSVersion': instance.deviceOSVersion,
      'deviceModel': instance.deviceModel,
      'deviceOS': instance.deviceOS,
    };
