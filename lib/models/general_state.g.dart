// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GeneralState _$$_GeneralStateFromJson(Map<String, dynamic> json) => _$_GeneralState(
      accessToken: json['accessToken'] as String?,
      notificationToken: json['notificationToken'] as String?,
      appDeviceData: json['appDeviceData'] == null ? null : AppDeviceData.fromJson(json['appDeviceData'] as Map<String, dynamic>),
      locale: const LocaleConverter().fromJson(json['locale'] as String?),
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']),
      isFirstAppRun: json['isFirstAppRun'] as bool? ?? false,
      isFirstAppBuildRun: json['isFirstAppBuildRun'] as bool? ?? false,
    );

Map<String, dynamic> _$$_GeneralStateToJson(_$_GeneralState instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'notificationToken': instance.notificationToken,
      'appDeviceData': instance.appDeviceData,
      'locale': const LocaleConverter().toJson(instance.locale),
      'themeMode': _$ThemeModeEnumMap[instance.themeMode],
      'isFirstAppRun': instance.isFirstAppRun,
      'isFirstAppBuildRun': instance.isFirstAppBuildRun,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
