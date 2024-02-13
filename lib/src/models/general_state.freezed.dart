// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GeneralState _$GeneralStateFromJson(Map<String, dynamic> json) {
  return _GeneralState.fromJson(json);
}

/// @nodoc
mixin _$GeneralState {
  String? get accessToken => throw _privateConstructorUsedError;
  String? get notificationToken => throw _privateConstructorUsedError;
  AppDeviceData? get appDeviceData => throw _privateConstructorUsedError;
  @LocaleConverter()
  Locale? get locale => throw _privateConstructorUsedError;
  @ThemeModeConverter()
  ThemeMode? get themeMode => throw _privateConstructorUsedError;
  bool get isFirstAppRun => throw _privateConstructorUsedError;
  bool get isFirstAppBuildRun => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeneralStateCopyWith<GeneralState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneralStateCopyWith<$Res> {
  factory $GeneralStateCopyWith(GeneralState value, $Res Function(GeneralState) then) = _$GeneralStateCopyWithImpl<$Res, GeneralState>;
  @useResult
  $Res call(
      {String? accessToken,
      String? notificationToken,
      AppDeviceData? appDeviceData,
      @LocaleConverter() Locale? locale,
      @ThemeModeConverter() ThemeMode? themeMode,
      bool isFirstAppRun,
      bool isFirstAppBuildRun});

  $AppDeviceDataCopyWith<$Res>? get appDeviceData;
}

/// @nodoc
class _$GeneralStateCopyWithImpl<$Res, $Val extends GeneralState> implements $GeneralStateCopyWith<$Res> {
  _$GeneralStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? notificationToken = freezed,
    Object? appDeviceData = freezed,
    Object? locale = freezed,
    Object? themeMode = freezed,
    Object? isFirstAppRun = null,
    Object? isFirstAppBuildRun = null,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationToken: freezed == notificationToken
          ? _value.notificationToken
          : notificationToken // ignore: cast_nullable_to_non_nullable
              as String?,
      appDeviceData: freezed == appDeviceData
          ? _value.appDeviceData
          : appDeviceData // ignore: cast_nullable_to_non_nullable
              as AppDeviceData?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      themeMode: freezed == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode?,
      isFirstAppRun: null == isFirstAppRun
          ? _value.isFirstAppRun
          : isFirstAppRun // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstAppBuildRun: null == isFirstAppBuildRun
          ? _value.isFirstAppBuildRun
          : isFirstAppBuildRun // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppDeviceDataCopyWith<$Res>? get appDeviceData {
    if (_value.appDeviceData == null) {
      return null;
    }

    return $AppDeviceDataCopyWith<$Res>(_value.appDeviceData!, (value) {
      return _then(_value.copyWith(appDeviceData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GeneralStateImplCopyWith<$Res> implements $GeneralStateCopyWith<$Res> {
  factory _$$GeneralStateImplCopyWith(_$GeneralStateImpl value, $Res Function(_$GeneralStateImpl) then) = __$$GeneralStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? accessToken,
      String? notificationToken,
      AppDeviceData? appDeviceData,
      @LocaleConverter() Locale? locale,
      @ThemeModeConverter() ThemeMode? themeMode,
      bool isFirstAppRun,
      bool isFirstAppBuildRun});

  @override
  $AppDeviceDataCopyWith<$Res>? get appDeviceData;
}

/// @nodoc
class __$$GeneralStateImplCopyWithImpl<$Res> extends _$GeneralStateCopyWithImpl<$Res, _$GeneralStateImpl> implements _$$GeneralStateImplCopyWith<$Res> {
  __$$GeneralStateImplCopyWithImpl(_$GeneralStateImpl _value, $Res Function(_$GeneralStateImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? notificationToken = freezed,
    Object? appDeviceData = freezed,
    Object? locale = freezed,
    Object? themeMode = freezed,
    Object? isFirstAppRun = null,
    Object? isFirstAppBuildRun = null,
  }) {
    return _then(_$GeneralStateImpl(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationToken: freezed == notificationToken
          ? _value.notificationToken
          : notificationToken // ignore: cast_nullable_to_non_nullable
              as String?,
      appDeviceData: freezed == appDeviceData
          ? _value.appDeviceData
          : appDeviceData // ignore: cast_nullable_to_non_nullable
              as AppDeviceData?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      themeMode: freezed == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode?,
      isFirstAppRun: null == isFirstAppRun
          ? _value.isFirstAppRun
          : isFirstAppRun // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstAppBuildRun: null == isFirstAppBuildRun
          ? _value.isFirstAppBuildRun
          : isFirstAppBuildRun // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneralStateImpl extends _GeneralState {
  _$GeneralStateImpl(
      {this.accessToken, this.notificationToken, this.appDeviceData, @LocaleConverter() this.locale, @ThemeModeConverter() this.themeMode, this.isFirstAppRun = false, this.isFirstAppBuildRun = false})
      : super._();

  factory _$GeneralStateImpl.fromJson(Map<String, dynamic> json) => _$$GeneralStateImplFromJson(json);

  @override
  final String? accessToken;
  @override
  final String? notificationToken;
  @override
  final AppDeviceData? appDeviceData;
  @override
  @LocaleConverter()
  final Locale? locale;
  @override
  @ThemeModeConverter()
  final ThemeMode? themeMode;
  @override
  @JsonKey()
  final bool isFirstAppRun;
  @override
  @JsonKey()
  final bool isFirstAppBuildRun;

  @override
  String toString() {
    return 'GeneralState(accessToken: $accessToken, notificationToken: $notificationToken, appDeviceData: $appDeviceData, locale: $locale, themeMode: $themeMode, isFirstAppRun: $isFirstAppRun, isFirstAppBuildRun: $isFirstAppBuildRun)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneralStateImpl &&
            (identical(other.accessToken, accessToken) || other.accessToken == accessToken) &&
            (identical(other.notificationToken, notificationToken) || other.notificationToken == notificationToken) &&
            (identical(other.appDeviceData, appDeviceData) || other.appDeviceData == appDeviceData) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.themeMode, themeMode) || other.themeMode == themeMode) &&
            (identical(other.isFirstAppRun, isFirstAppRun) || other.isFirstAppRun == isFirstAppRun) &&
            (identical(other.isFirstAppBuildRun, isFirstAppBuildRun) || other.isFirstAppBuildRun == isFirstAppBuildRun));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, notificationToken, appDeviceData, locale, themeMode, isFirstAppRun, isFirstAppBuildRun);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneralStateImplCopyWith<_$GeneralStateImpl> get copyWith => __$$GeneralStateImplCopyWithImpl<_$GeneralStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneralStateImplToJson(
      this,
    );
  }
}

abstract class _GeneralState extends GeneralState {
  factory _GeneralState(
      {final String? accessToken,
      final String? notificationToken,
      final AppDeviceData? appDeviceData,
      @LocaleConverter() final Locale? locale,
      @ThemeModeConverter() final ThemeMode? themeMode,
      final bool isFirstAppRun,
      final bool isFirstAppBuildRun}) = _$GeneralStateImpl;
  _GeneralState._() : super._();

  factory _GeneralState.fromJson(Map<String, dynamic> json) = _$GeneralStateImpl.fromJson;

  @override
  String? get accessToken;
  @override
  String? get notificationToken;
  @override
  AppDeviceData? get appDeviceData;
  @override
  @LocaleConverter()
  Locale? get locale;
  @override
  @ThemeModeConverter()
  ThemeMode? get themeMode;
  @override
  bool get isFirstAppRun;
  @override
  bool get isFirstAppBuildRun;
  @override
  @JsonKey(ignore: true)
  _$$GeneralStateImplCopyWith<_$GeneralStateImpl> get copyWith => throw _privateConstructorUsedError;
}
