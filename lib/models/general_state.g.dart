// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GeneralState _$_$_GeneralStateFromJson(Map<String, dynamic> json) {
  return _$_GeneralState(
    accessToken: json['accessToken'] as String?,
    notificationToken: json['notificationToken'] as String?,
    appDeviceData: json['appDeviceData'] == null ? null : AppDeviceData.fromJson(json['appDeviceData'] as Map<String, dynamic>),
    locale: const LocaleConverter().fromJson(json['locale'] as String?),
    themeMode: const ThemeModeConverter().fromJson(json['themeMode'] as String?),
    isFirstAppRun: json['isFirstAppRun'] as bool? ?? false,
    isFirstAppBuildRun: json['isFirstAppBuildRun'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_GeneralStateToJson(_$_GeneralState instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'notificationToken': instance.notificationToken,
      'appDeviceData': instance.appDeviceData,
      'locale': const LocaleConverter().toJson(instance.locale),
      'themeMode': const ThemeModeConverter().toJson(instance.themeMode),
      'isFirstAppRun': instance.isFirstAppRun,
      'isFirstAppBuildRun': instance.isFirstAppBuildRun,
    };
