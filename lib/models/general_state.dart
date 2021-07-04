import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_device_data.dart';

part 'general_state.freezed.dart';
part 'general_state.g.dart';

@freezed
class GeneralState with _$GeneralState {
  const GeneralState._();

  factory GeneralState({
    String? accessToken,
    String? notificationToken,
    AppDeviceData? appDeviceData,
    @LocaleConverter() Locale? locale,
    @ThemeModeConverter() @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(false) bool isFirstAppRun,
    @Default(false) bool isFirstAppBuildRun,
  }) = _GeneralState;

  factory GeneralState.fromJson(Map<String, dynamic> json) => _$GeneralStateFromJson(json);

  Map<String, dynamic> get appStateAsMap => <String, dynamic>{
        'notification_token': notificationToken,
        'device_id': appDeviceData?.deviceID,
        'access_token': accessToken,
        'lang': locale?.languageCode,
        'appBuild': appDeviceData?.appBuild,
        'deviceModel': appDeviceData?.deviceModel,
        'themeMode': themeMode.toString(),
        'isFirstAppRun': isFirstAppRun,
        'isFirstAppBuildRun': isFirstAppBuildRun,
        'deviceOS': Platform.operatingSystem.toLowerCase(),
      };
}

class LocaleConverter implements JsonConverter<Locale?, String?> {
  const LocaleConverter();

  @override
  Locale? fromJson(String? json) {
    if (json == null) {
      return null;
    }
    return Locale(json);
  }

  @override
  String? toJson(Locale? data) => data?.languageCode;
}

class ThemeModeConverter implements JsonConverter<ThemeMode, String?> {
  const ThemeModeConverter();

  @override
  ThemeMode fromJson(String? json) {
    if (json == null) {
      return ThemeMode.system;
    }

    if (json == ThemeMode.light.toString()) {
      return ThemeMode.light;
    } else if (json == ThemeMode.dark.toString()) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  @override
  String toJson(ThemeMode data) => data.toString();
}
