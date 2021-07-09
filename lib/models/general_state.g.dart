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
    themeMode: _$enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']),
    isFirstAppRun: json['isFirstAppRun'] as bool? ?? false,
    isFirstAppBuildRun: json['isFirstAppBuildRun'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_GeneralStateToJson(_$_GeneralState instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'notificationToken': instance.notificationToken,
      'appDeviceData': instance.appDeviceData,
      'locale': const LocaleConverter().toJson(instance.locale),
      'themeMode': _$ThemeModeEnumMap[instance.themeMode],
      'isFirstAppRun': instance.isFirstAppRun,
      'isFirstAppBuildRun': instance.isFirstAppBuildRun,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
