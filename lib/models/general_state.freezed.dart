// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'general_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeneralState _$GeneralStateFromJson(Map<String, dynamic> json) {
  return _GeneralState.fromJson(json);
}

/// @nodoc
class _$GeneralStateTearOff {
  const _$GeneralStateTearOff();

  _GeneralState call(
      {String? accessToken,
      String? notificationToken,
      AppDeviceData? appDeviceData,
      @LocaleConverter() Locale? locale,
      @ThemeModeConverter() ThemeMode? themeMode,
      bool isFirstAppRun = false,
      bool isFirstAppBuildRun = false}) {
    return _GeneralState(
      accessToken: accessToken,
      notificationToken: notificationToken,
      appDeviceData: appDeviceData,
      locale: locale,
      themeMode: themeMode,
      isFirstAppRun: isFirstAppRun,
      isFirstAppBuildRun: isFirstAppBuildRun,
    );
  }

  GeneralState fromJson(Map<String, Object?> json) {
    return GeneralState.fromJson(json);
  }
}

/// @nodoc
const $GeneralState = _$GeneralStateTearOff();

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
  factory $GeneralStateCopyWith(GeneralState value, $Res Function(GeneralState) then) = _$GeneralStateCopyWithImpl<$Res>;
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
class _$GeneralStateCopyWithImpl<$Res> implements $GeneralStateCopyWith<$Res> {
  _$GeneralStateCopyWithImpl(this._value, this._then);

  final GeneralState _value;
  // ignore: unused_field
  final $Res Function(GeneralState) _then;

  @override
  $Res call({
    Object? accessToken = freezed,
    Object? notificationToken = freezed,
    Object? appDeviceData = freezed,
    Object? locale = freezed,
    Object? themeMode = freezed,
    Object? isFirstAppRun = freezed,
    Object? isFirstAppBuildRun = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: accessToken == freezed
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationToken: notificationToken == freezed
          ? _value.notificationToken
          : notificationToken // ignore: cast_nullable_to_non_nullable
              as String?,
      appDeviceData: appDeviceData == freezed
          ? _value.appDeviceData
          : appDeviceData // ignore: cast_nullable_to_non_nullable
              as AppDeviceData?,
      locale: locale == freezed
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      themeMode: themeMode == freezed
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode?,
      isFirstAppRun: isFirstAppRun == freezed
          ? _value.isFirstAppRun
          : isFirstAppRun // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstAppBuildRun: isFirstAppBuildRun == freezed
          ? _value.isFirstAppBuildRun
          : isFirstAppBuildRun // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $AppDeviceDataCopyWith<$Res>? get appDeviceData {
    if (_value.appDeviceData == null) {
      return null;
    }

    return $AppDeviceDataCopyWith<$Res>(_value.appDeviceData!, (value) {
      return _then(_value.copyWith(appDeviceData: value));
    });
  }
}

/// @nodoc
abstract class _$GeneralStateCopyWith<$Res> implements $GeneralStateCopyWith<$Res> {
  factory _$GeneralStateCopyWith(_GeneralState value, $Res Function(_GeneralState) then) = __$GeneralStateCopyWithImpl<$Res>;
  @override
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
class __$GeneralStateCopyWithImpl<$Res> extends _$GeneralStateCopyWithImpl<$Res> implements _$GeneralStateCopyWith<$Res> {
  __$GeneralStateCopyWithImpl(_GeneralState _value, $Res Function(_GeneralState) _then) : super(_value, (v) => _then(v as _GeneralState));

  @override
  _GeneralState get _value => super._value as _GeneralState;

  @override
  $Res call({
    Object? accessToken = freezed,
    Object? notificationToken = freezed,
    Object? appDeviceData = freezed,
    Object? locale = freezed,
    Object? themeMode = freezed,
    Object? isFirstAppRun = freezed,
    Object? isFirstAppBuildRun = freezed,
  }) {
    return _then(_GeneralState(
      accessToken: accessToken == freezed
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationToken: notificationToken == freezed
          ? _value.notificationToken
          : notificationToken // ignore: cast_nullable_to_non_nullable
              as String?,
      appDeviceData: appDeviceData == freezed
          ? _value.appDeviceData
          : appDeviceData // ignore: cast_nullable_to_non_nullable
              as AppDeviceData?,
      locale: locale == freezed
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      themeMode: themeMode == freezed
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode?,
      isFirstAppRun: isFirstAppRun == freezed
          ? _value.isFirstAppRun
          : isFirstAppRun // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstAppBuildRun: isFirstAppBuildRun == freezed
          ? _value.isFirstAppBuildRun
          : isFirstAppBuildRun // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GeneralState extends _GeneralState with DiagnosticableTreeMixin {
  _$_GeneralState(
      {this.accessToken, this.notificationToken, this.appDeviceData, @LocaleConverter() this.locale, @ThemeModeConverter() this.themeMode, this.isFirstAppRun = false, this.isFirstAppBuildRun = false})
      : super._();

  factory _$_GeneralState.fromJson(Map<String, dynamic> json) => _$$_GeneralStateFromJson(json);

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
  @JsonKey()
  @override
  final bool isFirstAppRun;
  @JsonKey()
  @override
  final bool isFirstAppBuildRun;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GeneralState(accessToken: $accessToken, notificationToken: $notificationToken, appDeviceData: $appDeviceData, locale: $locale, themeMode: $themeMode, isFirstAppRun: $isFirstAppRun, isFirstAppBuildRun: $isFirstAppBuildRun)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GeneralState'))
      ..add(DiagnosticsProperty('accessToken', accessToken))
      ..add(DiagnosticsProperty('notificationToken', notificationToken))
      ..add(DiagnosticsProperty('appDeviceData', appDeviceData))
      ..add(DiagnosticsProperty('locale', locale))
      ..add(DiagnosticsProperty('themeMode', themeMode))
      ..add(DiagnosticsProperty('isFirstAppRun', isFirstAppRun))
      ..add(DiagnosticsProperty('isFirstAppBuildRun', isFirstAppBuildRun));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GeneralState &&
            const DeepCollectionEquality().equals(other.accessToken, accessToken) &&
            const DeepCollectionEquality().equals(other.notificationToken, notificationToken) &&
            const DeepCollectionEquality().equals(other.appDeviceData, appDeviceData) &&
            const DeepCollectionEquality().equals(other.locale, locale) &&
            const DeepCollectionEquality().equals(other.themeMode, themeMode) &&
            const DeepCollectionEquality().equals(other.isFirstAppRun, isFirstAppRun) &&
            const DeepCollectionEquality().equals(other.isFirstAppBuildRun, isFirstAppBuildRun));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(accessToken),
      const DeepCollectionEquality().hash(notificationToken),
      const DeepCollectionEquality().hash(appDeviceData),
      const DeepCollectionEquality().hash(locale),
      const DeepCollectionEquality().hash(themeMode),
      const DeepCollectionEquality().hash(isFirstAppRun),
      const DeepCollectionEquality().hash(isFirstAppBuildRun));

  @JsonKey(ignore: true)
  @override
  _$GeneralStateCopyWith<_GeneralState> get copyWith => __$GeneralStateCopyWithImpl<_GeneralState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeneralStateToJson(this);
  }
}

abstract class _GeneralState extends GeneralState {
  factory _GeneralState(
      {String? accessToken,
      String? notificationToken,
      AppDeviceData? appDeviceData,
      @LocaleConverter() Locale? locale,
      @ThemeModeConverter() ThemeMode? themeMode,
      bool isFirstAppRun,
      bool isFirstAppBuildRun}) = _$_GeneralState;
  _GeneralState._() : super._();

  factory _GeneralState.fromJson(Map<String, dynamic> json) = _$_GeneralState.fromJson;

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
  _$GeneralStateCopyWith<_GeneralState> get copyWith => throw _privateConstructorUsedError;
}
