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
