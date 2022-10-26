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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppConfig {
  bool get withFirebase => throw _privateConstructorUsedError;
  bool get withFCM => throw _privateConstructorUsedError;
  bool get withCrashlytics => throw _privateConstructorUsedError;
  bool get nativeLocaleChange => throw _privateConstructorUsedError;
  FirebaseOptions? get firebaseOptions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppConfigCopyWith<AppConfig> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppConfigCopyWith<$Res> {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) then) = _$AppConfigCopyWithImpl<$Res, AppConfig>;
  @useResult
  $Res call({bool withFirebase, bool withFCM, bool withCrashlytics, bool nativeLocaleChange, FirebaseOptions? firebaseOptions});
}

/// @nodoc
class _$AppConfigCopyWithImpl<$Res, $Val extends AppConfig> implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? withFirebase = null,
    Object? withFCM = null,
    Object? withCrashlytics = null,
    Object? nativeLocaleChange = null,
    Object? firebaseOptions = freezed,
  }) {
    return _then(_value.copyWith(
      withFirebase: null == withFirebase
          ? _value.withFirebase
          : withFirebase // ignore: cast_nullable_to_non_nullable
              as bool,
      withFCM: null == withFCM
          ? _value.withFCM
          : withFCM // ignore: cast_nullable_to_non_nullable
              as bool,
      withCrashlytics: null == withCrashlytics
          ? _value.withCrashlytics
          : withCrashlytics // ignore: cast_nullable_to_non_nullable
              as bool,
      nativeLocaleChange: null == nativeLocaleChange
          ? _value.nativeLocaleChange
          : nativeLocaleChange // ignore: cast_nullable_to_non_nullable
              as bool,
      firebaseOptions: freezed == firebaseOptions
          ? _value.firebaseOptions
          : firebaseOptions // ignore: cast_nullable_to_non_nullable
              as FirebaseOptions?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$$_AppConfigCopyWith(_$_AppConfig value, $Res Function(_$_AppConfig) then) = __$$_AppConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool withFirebase, bool withFCM, bool withCrashlytics, bool nativeLocaleChange, FirebaseOptions? firebaseOptions});
}

/// @nodoc
class __$$_AppConfigCopyWithImpl<$Res> extends _$AppConfigCopyWithImpl<$Res, _$_AppConfig> implements _$$_AppConfigCopyWith<$Res> {
  __$$_AppConfigCopyWithImpl(_$_AppConfig _value, $Res Function(_$_AppConfig) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? withFirebase = null,
    Object? withFCM = null,
    Object? withCrashlytics = null,
    Object? nativeLocaleChange = null,
    Object? firebaseOptions = freezed,
  }) {
    return _then(_$_AppConfig(
      withFirebase: null == withFirebase
          ? _value.withFirebase
          : withFirebase // ignore: cast_nullable_to_non_nullable
              as bool,
      withFCM: null == withFCM
          ? _value.withFCM
          : withFCM // ignore: cast_nullable_to_non_nullable
              as bool,
      withCrashlytics: null == withCrashlytics
          ? _value.withCrashlytics
          : withCrashlytics // ignore: cast_nullable_to_non_nullable
              as bool,
      nativeLocaleChange: null == nativeLocaleChange
          ? _value.nativeLocaleChange
          : nativeLocaleChange // ignore: cast_nullable_to_non_nullable
              as bool,
      firebaseOptions: freezed == firebaseOptions
          ? _value.firebaseOptions
          : firebaseOptions // ignore: cast_nullable_to_non_nullable
              as FirebaseOptions?,
    ));
  }
}

/// @nodoc

class _$_AppConfig extends _AppConfig {
  _$_AppConfig({this.withFirebase = true, this.withFCM = true, this.withCrashlytics = true, this.nativeLocaleChange = false, this.firebaseOptions}) : super._();

  @override
  @JsonKey()
  final bool withFirebase;
  @override
  @JsonKey()
  final bool withFCM;
  @override
  @JsonKey()
  final bool withCrashlytics;
  @override
  @JsonKey()
  final bool nativeLocaleChange;
  @override
  final FirebaseOptions? firebaseOptions;

  @override
  String toString() {
    return 'AppConfig(withFirebase: $withFirebase, withFCM: $withFCM, withCrashlytics: $withCrashlytics, nativeLocaleChange: $nativeLocaleChange, firebaseOptions: $firebaseOptions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppConfig &&
            (identical(other.withFirebase, withFirebase) || other.withFirebase == withFirebase) &&
            (identical(other.withFCM, withFCM) || other.withFCM == withFCM) &&
            (identical(other.withCrashlytics, withCrashlytics) || other.withCrashlytics == withCrashlytics) &&
            (identical(other.nativeLocaleChange, nativeLocaleChange) || other.nativeLocaleChange == nativeLocaleChange) &&
            (identical(other.firebaseOptions, firebaseOptions) || other.firebaseOptions == firebaseOptions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, withFirebase, withFCM, withCrashlytics, nativeLocaleChange, firebaseOptions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppConfigCopyWith<_$_AppConfig> get copyWith => __$$_AppConfigCopyWithImpl<_$_AppConfig>(this, _$identity);
}

abstract class _AppConfig extends AppConfig {
  factory _AppConfig({final bool withFirebase, final bool withFCM, final bool withCrashlytics, final bool nativeLocaleChange, final FirebaseOptions? firebaseOptions}) = _$_AppConfig;
  _AppConfig._() : super._();

  @override
  bool get withFirebase;
  @override
  bool get withFCM;
  @override
  bool get withCrashlytics;
  @override
  bool get nativeLocaleChange;
  @override
  FirebaseOptions? get firebaseOptions;
  @override
  @JsonKey(ignore: true)
  _$$_AppConfigCopyWith<_$_AppConfig> get copyWith => throw _privateConstructorUsedError;
}
