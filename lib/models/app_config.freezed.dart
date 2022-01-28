// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppEventsTearOff {
  const _$AppEventsTearOff();

  _AppEvents call(
      {dynamic Function(Uri, WidgetRef, BuildContext)? onDynamicLink,
      dynamic Function(String, WidgetRef, BuildContext)? onFCMTokenRefresh,
      GenerateAppTitle? onGenerateTitle,
      dynamic Function(Locale?, Locale?, WidgetRef, BuildContext)? onLocaleChange}) {
    return _AppEvents(
      onDynamicLink: onDynamicLink,
      onFCMTokenRefresh: onFCMTokenRefresh,
      onGenerateTitle: onGenerateTitle,
      onLocaleChange: onLocaleChange,
    );
  }
}

/// @nodoc
const $AppEvents = _$AppEventsTearOff();

/// @nodoc
mixin _$AppEvents {
  dynamic Function(Uri, WidgetRef, BuildContext)? get onDynamicLink => throw _privateConstructorUsedError;
  dynamic Function(String, WidgetRef, BuildContext)? get onFCMTokenRefresh => throw _privateConstructorUsedError;
  GenerateAppTitle? get onGenerateTitle => throw _privateConstructorUsedError;
  dynamic Function(Locale?, Locale?, WidgetRef, BuildContext)? get onLocaleChange => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppEventsCopyWith<AppEvents> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppEventsCopyWith<$Res> {
  factory $AppEventsCopyWith(AppEvents value, $Res Function(AppEvents) then) = _$AppEventsCopyWithImpl<$Res>;
  $Res call(
      {dynamic Function(Uri, WidgetRef, BuildContext)? onDynamicLink,
      dynamic Function(String, WidgetRef, BuildContext)? onFCMTokenRefresh,
      GenerateAppTitle? onGenerateTitle,
      dynamic Function(Locale?, Locale?, WidgetRef, BuildContext)? onLocaleChange});
}

/// @nodoc
class _$AppEventsCopyWithImpl<$Res> implements $AppEventsCopyWith<$Res> {
  _$AppEventsCopyWithImpl(this._value, this._then);

  final AppEvents _value;
  // ignore: unused_field
  final $Res Function(AppEvents) _then;

  @override
  $Res call({
    Object? onDynamicLink = freezed,
    Object? onFCMTokenRefresh = freezed,
    Object? onGenerateTitle = freezed,
    Object? onLocaleChange = freezed,
  }) {
    return _then(_value.copyWith(
      onDynamicLink: onDynamicLink == freezed
          ? _value.onDynamicLink
          : onDynamicLink // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Uri, WidgetRef, BuildContext)?,
      onFCMTokenRefresh: onFCMTokenRefresh == freezed
          ? _value.onFCMTokenRefresh
          : onFCMTokenRefresh // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String, WidgetRef, BuildContext)?,
      onGenerateTitle: onGenerateTitle == freezed
          ? _value.onGenerateTitle
          : onGenerateTitle // ignore: cast_nullable_to_non_nullable
              as GenerateAppTitle?,
      onLocaleChange: onLocaleChange == freezed
          ? _value.onLocaleChange
          : onLocaleChange // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Locale?, Locale?, WidgetRef, BuildContext)?,
    ));
  }
}

/// @nodoc
abstract class _$AppEventsCopyWith<$Res> implements $AppEventsCopyWith<$Res> {
  factory _$AppEventsCopyWith(_AppEvents value, $Res Function(_AppEvents) then) = __$AppEventsCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic Function(Uri, WidgetRef, BuildContext)? onDynamicLink,
      dynamic Function(String, WidgetRef, BuildContext)? onFCMTokenRefresh,
      GenerateAppTitle? onGenerateTitle,
      dynamic Function(Locale?, Locale?, WidgetRef, BuildContext)? onLocaleChange});
}

/// @nodoc
class __$AppEventsCopyWithImpl<$Res> extends _$AppEventsCopyWithImpl<$Res> implements _$AppEventsCopyWith<$Res> {
  __$AppEventsCopyWithImpl(_AppEvents _value, $Res Function(_AppEvents) _then) : super(_value, (v) => _then(v as _AppEvents));

  @override
  _AppEvents get _value => super._value as _AppEvents;

  @override
  $Res call({
    Object? onDynamicLink = freezed,
    Object? onFCMTokenRefresh = freezed,
    Object? onGenerateTitle = freezed,
    Object? onLocaleChange = freezed,
  }) {
    return _then(_AppEvents(
      onDynamicLink: onDynamicLink == freezed
          ? _value.onDynamicLink
          : onDynamicLink // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Uri, WidgetRef, BuildContext)?,
      onFCMTokenRefresh: onFCMTokenRefresh == freezed
          ? _value.onFCMTokenRefresh
          : onFCMTokenRefresh // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String, WidgetRef, BuildContext)?,
      onGenerateTitle: onGenerateTitle == freezed
          ? _value.onGenerateTitle
          : onGenerateTitle // ignore: cast_nullable_to_non_nullable
              as GenerateAppTitle?,
      onLocaleChange: onLocaleChange == freezed
          ? _value.onLocaleChange
          : onLocaleChange // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Locale?, Locale?, WidgetRef, BuildContext)?,
    ));
  }
}

/// @nodoc

class _$_AppEvents extends _AppEvents with DiagnosticableTreeMixin {
  _$_AppEvents({this.onDynamicLink, this.onFCMTokenRefresh, this.onGenerateTitle, this.onLocaleChange}) : super._();

  @override
  final dynamic Function(Uri, WidgetRef, BuildContext)? onDynamicLink;
  @override
  final dynamic Function(String, WidgetRef, BuildContext)? onFCMTokenRefresh;
  @override
  final GenerateAppTitle? onGenerateTitle;
  @override
  final dynamic Function(Locale?, Locale?, WidgetRef, BuildContext)? onLocaleChange;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppEvents(onDynamicLink: $onDynamicLink, onFCMTokenRefresh: $onFCMTokenRefresh, onGenerateTitle: $onGenerateTitle, onLocaleChange: $onLocaleChange)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppEvents'))
      ..add(DiagnosticsProperty('onDynamicLink', onDynamicLink))
      ..add(DiagnosticsProperty('onFCMTokenRefresh', onFCMTokenRefresh))
      ..add(DiagnosticsProperty('onGenerateTitle', onGenerateTitle))
      ..add(DiagnosticsProperty('onLocaleChange', onLocaleChange));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppEvents &&
            (identical(other.onDynamicLink, onDynamicLink) || other.onDynamicLink == onDynamicLink) &&
            (identical(other.onFCMTokenRefresh, onFCMTokenRefresh) || other.onFCMTokenRefresh == onFCMTokenRefresh) &&
            (identical(other.onGenerateTitle, onGenerateTitle) || other.onGenerateTitle == onGenerateTitle) &&
            (identical(other.onLocaleChange, onLocaleChange) || other.onLocaleChange == onLocaleChange));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onDynamicLink, onFCMTokenRefresh, onGenerateTitle, onLocaleChange);

  @JsonKey(ignore: true)
  @override
  _$AppEventsCopyWith<_AppEvents> get copyWith => __$AppEventsCopyWithImpl<_AppEvents>(this, _$identity);
}

abstract class _AppEvents extends AppEvents {
  factory _AppEvents(
      {dynamic Function(Uri, WidgetRef, BuildContext)? onDynamicLink,
      dynamic Function(String, WidgetRef, BuildContext)? onFCMTokenRefresh,
      GenerateAppTitle? onGenerateTitle,
      dynamic Function(Locale?, Locale?, WidgetRef, BuildContext)? onLocaleChange}) = _$_AppEvents;
  _AppEvents._() : super._();

  @override
  dynamic Function(Uri, WidgetRef, BuildContext)? get onDynamicLink;
  @override
  dynamic Function(String, WidgetRef, BuildContext)? get onFCMTokenRefresh;
  @override
  GenerateAppTitle? get onGenerateTitle;
  @override
  dynamic Function(Locale?, Locale?, WidgetRef, BuildContext)? get onLocaleChange;
  @override
  @JsonKey(ignore: true)
  _$AppEventsCopyWith<_AppEvents> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$AppConfigTearOff {
  const _$AppConfigTearOff();

  _AppConfig call({bool withFirebase = true, bool withFCM = true, bool withCrashlytics = true, FirebaseOptions? firebaseOptions}) {
    return _AppConfig(
      withFirebase: withFirebase,
      withFCM: withFCM,
      withCrashlytics: withCrashlytics,
      firebaseOptions: firebaseOptions,
    );
  }
}

/// @nodoc
const $AppConfig = _$AppConfigTearOff();

/// @nodoc
mixin _$AppConfig {
  bool get withFirebase => throw _privateConstructorUsedError;
  bool get withFCM => throw _privateConstructorUsedError;
  bool get withCrashlytics => throw _privateConstructorUsedError;
  FirebaseOptions? get firebaseOptions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppConfigCopyWith<AppConfig> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigCopyWith<$Res> {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) then) = _$AppConfigCopyWithImpl<$Res>;
  $Res call({bool withFirebase, bool withFCM, bool withCrashlytics, FirebaseOptions? firebaseOptions});
}

/// @nodoc
class _$AppConfigCopyWithImpl<$Res> implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._value, this._then);

  final AppConfig _value;
  // ignore: unused_field
  final $Res Function(AppConfig) _then;

  @override
  $Res call({
    Object? withFirebase = freezed,
    Object? withFCM = freezed,
    Object? withCrashlytics = freezed,
    Object? firebaseOptions = freezed,
  }) {
    return _then(_value.copyWith(
      withFirebase: withFirebase == freezed
          ? _value.withFirebase
          : withFirebase // ignore: cast_nullable_to_non_nullable
              as bool,
      withFCM: withFCM == freezed
          ? _value.withFCM
          : withFCM // ignore: cast_nullable_to_non_nullable
              as bool,
      withCrashlytics: withCrashlytics == freezed
          ? _value.withCrashlytics
          : withCrashlytics // ignore: cast_nullable_to_non_nullable
              as bool,
      firebaseOptions: firebaseOptions == freezed
          ? _value.firebaseOptions
          : firebaseOptions // ignore: cast_nullable_to_non_nullable
              as FirebaseOptions?,
    ));
  }
}

/// @nodoc
abstract class _$AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(_AppConfig value, $Res Function(_AppConfig) then) = __$AppConfigCopyWithImpl<$Res>;
  @override
  $Res call({bool withFirebase, bool withFCM, bool withCrashlytics, FirebaseOptions? firebaseOptions});
}

/// @nodoc
class __$AppConfigCopyWithImpl<$Res> extends _$AppConfigCopyWithImpl<$Res> implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(_AppConfig _value, $Res Function(_AppConfig) _then) : super(_value, (v) => _then(v as _AppConfig));

  @override
  _AppConfig get _value => super._value as _AppConfig;

  @override
  $Res call({
    Object? withFirebase = freezed,
    Object? withFCM = freezed,
    Object? withCrashlytics = freezed,
    Object? firebaseOptions = freezed,
  }) {
    return _then(_AppConfig(
      withFirebase: withFirebase == freezed
          ? _value.withFirebase
          : withFirebase // ignore: cast_nullable_to_non_nullable
              as bool,
      withFCM: withFCM == freezed
          ? _value.withFCM
          : withFCM // ignore: cast_nullable_to_non_nullable
              as bool,
      withCrashlytics: withCrashlytics == freezed
          ? _value.withCrashlytics
          : withCrashlytics // ignore: cast_nullable_to_non_nullable
              as bool,
      firebaseOptions: firebaseOptions == freezed
          ? _value.firebaseOptions
          : firebaseOptions // ignore: cast_nullable_to_non_nullable
              as FirebaseOptions?,
    ));
  }
}

/// @nodoc

class _$_AppConfig extends _AppConfig with DiagnosticableTreeMixin {
  _$_AppConfig({this.withFirebase = true, this.withFCM = true, this.withCrashlytics = true, this.firebaseOptions}) : super._();

  @JsonKey()
  @override
  final bool withFirebase;
  @JsonKey()
  @override
  final bool withFCM;
  @JsonKey()
  @override
  final bool withCrashlytics;
  @override
  final FirebaseOptions? firebaseOptions;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppConfig(withFirebase: $withFirebase, withFCM: $withFCM, withCrashlytics: $withCrashlytics, firebaseOptions: $firebaseOptions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppConfig'))
      ..add(DiagnosticsProperty('withFirebase', withFirebase))
      ..add(DiagnosticsProperty('withFCM', withFCM))
      ..add(DiagnosticsProperty('withCrashlytics', withCrashlytics))
      ..add(DiagnosticsProperty('firebaseOptions', firebaseOptions));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppConfig &&
            const DeepCollectionEquality().equals(other.withFirebase, withFirebase) &&
            const DeepCollectionEquality().equals(other.withFCM, withFCM) &&
            const DeepCollectionEquality().equals(other.withCrashlytics, withCrashlytics) &&
            const DeepCollectionEquality().equals(other.firebaseOptions, firebaseOptions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(withFirebase), const DeepCollectionEquality().hash(withFCM), const DeepCollectionEquality().hash(withCrashlytics),
      const DeepCollectionEquality().hash(firebaseOptions));

  @JsonKey(ignore: true)
  @override
  _$AppConfigCopyWith<_AppConfig> get copyWith => __$AppConfigCopyWithImpl<_AppConfig>(this, _$identity);
}

abstract class _AppConfig extends AppConfig {
  factory _AppConfig({bool withFirebase, bool withFCM, bool withCrashlytics, FirebaseOptions? firebaseOptions}) = _$_AppConfig;
  _AppConfig._() : super._();

  @override
  bool get withFirebase;
  @override
  bool get withFCM;
  @override
  bool get withCrashlytics;
  @override
  FirebaseOptions? get firebaseOptions;
  @override
  @JsonKey(ignore: true)
  _$AppConfigCopyWith<_AppConfig> get copyWith => throw _privateConstructorUsedError;
}
