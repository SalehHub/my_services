// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppEvents {
  OnDynamicLink? get onDynamicLink => throw _privateConstructorUsedError;
  OnFCMTokenRefresh? get onFCMTokenRefresh => throw _privateConstructorUsedError;
  OnFirebaseNotification? get onFirebaseNotification => throw _privateConstructorUsedError; //firebaseMessaging
  GenerateAppTitle? get onGenerateTitle => throw _privateConstructorUsedError;
  OnLocaleChange? get onLocaleChange => throw _privateConstructorUsedError;
  dynamic Function(String?)? get onPush => throw _privateConstructorUsedError;
  dynamic Function(String?)? get onPop => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppEventsCopyWith<AppEvents> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppEventsCopyWith<$Res> {
  factory $AppEventsCopyWith(AppEvents value, $Res Function(AppEvents) then) = _$AppEventsCopyWithImpl<$Res, AppEvents>;
  @useResult
  $Res call(
      {OnDynamicLink? onDynamicLink,
      OnFCMTokenRefresh? onFCMTokenRefresh,
      OnFirebaseNotification? onFirebaseNotification,
      GenerateAppTitle? onGenerateTitle,
      OnLocaleChange? onLocaleChange,
      dynamic Function(String?)? onPush,
      dynamic Function(String?)? onPop});
}

/// @nodoc
class _$AppEventsCopyWithImpl<$Res, $Val extends AppEvents> implements $AppEventsCopyWith<$Res> {
  _$AppEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onDynamicLink = freezed,
    Object? onFCMTokenRefresh = freezed,
    Object? onFirebaseNotification = freezed,
    Object? onGenerateTitle = freezed,
    Object? onLocaleChange = freezed,
    Object? onPush = freezed,
    Object? onPop = freezed,
  }) {
    return _then(_value.copyWith(
      onDynamicLink: freezed == onDynamicLink
          ? _value.onDynamicLink
          : onDynamicLink // ignore: cast_nullable_to_non_nullable
              as OnDynamicLink?,
      onFCMTokenRefresh: freezed == onFCMTokenRefresh
          ? _value.onFCMTokenRefresh
          : onFCMTokenRefresh // ignore: cast_nullable_to_non_nullable
              as OnFCMTokenRefresh?,
      onFirebaseNotification: freezed == onFirebaseNotification
          ? _value.onFirebaseNotification
          : onFirebaseNotification // ignore: cast_nullable_to_non_nullable
              as OnFirebaseNotification?,
      onGenerateTitle: freezed == onGenerateTitle
          ? _value.onGenerateTitle
          : onGenerateTitle // ignore: cast_nullable_to_non_nullable
              as GenerateAppTitle?,
      onLocaleChange: freezed == onLocaleChange
          ? _value.onLocaleChange
          : onLocaleChange // ignore: cast_nullable_to_non_nullable
              as OnLocaleChange?,
      onPush: freezed == onPush
          ? _value.onPush
          : onPush // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String?)?,
      onPop: freezed == onPop
          ? _value.onPop
          : onPop // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String?)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppEventsCopyWith<$Res> implements $AppEventsCopyWith<$Res> {
  factory _$$_AppEventsCopyWith(_$_AppEvents value, $Res Function(_$_AppEvents) then) = __$$_AppEventsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OnDynamicLink? onDynamicLink,
      OnFCMTokenRefresh? onFCMTokenRefresh,
      OnFirebaseNotification? onFirebaseNotification,
      GenerateAppTitle? onGenerateTitle,
      OnLocaleChange? onLocaleChange,
      dynamic Function(String?)? onPush,
      dynamic Function(String?)? onPop});
}

/// @nodoc
class __$$_AppEventsCopyWithImpl<$Res> extends _$AppEventsCopyWithImpl<$Res, _$_AppEvents> implements _$$_AppEventsCopyWith<$Res> {
  __$$_AppEventsCopyWithImpl(_$_AppEvents _value, $Res Function(_$_AppEvents) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onDynamicLink = freezed,
    Object? onFCMTokenRefresh = freezed,
    Object? onFirebaseNotification = freezed,
    Object? onGenerateTitle = freezed,
    Object? onLocaleChange = freezed,
    Object? onPush = freezed,
    Object? onPop = freezed,
  }) {
    return _then(_$_AppEvents(
      onDynamicLink: freezed == onDynamicLink
          ? _value.onDynamicLink
          : onDynamicLink // ignore: cast_nullable_to_non_nullable
              as OnDynamicLink?,
      onFCMTokenRefresh: freezed == onFCMTokenRefresh
          ? _value.onFCMTokenRefresh
          : onFCMTokenRefresh // ignore: cast_nullable_to_non_nullable
              as OnFCMTokenRefresh?,
      onFirebaseNotification: freezed == onFirebaseNotification
          ? _value.onFirebaseNotification
          : onFirebaseNotification // ignore: cast_nullable_to_non_nullable
              as OnFirebaseNotification?,
      onGenerateTitle: freezed == onGenerateTitle
          ? _value.onGenerateTitle
          : onGenerateTitle // ignore: cast_nullable_to_non_nullable
              as GenerateAppTitle?,
      onLocaleChange: freezed == onLocaleChange
          ? _value.onLocaleChange
          : onLocaleChange // ignore: cast_nullable_to_non_nullable
              as OnLocaleChange?,
      onPush: freezed == onPush
          ? _value.onPush
          : onPush // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String?)?,
      onPop: freezed == onPop
          ? _value.onPop
          : onPop // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String?)?,
    ));
  }
}

/// @nodoc

class _$_AppEvents implements _AppEvents {
  const _$_AppEvents({this.onDynamicLink, this.onFCMTokenRefresh, this.onFirebaseNotification, this.onGenerateTitle, this.onLocaleChange, this.onPush, this.onPop});

  @override
  final OnDynamicLink? onDynamicLink;
  @override
  final OnFCMTokenRefresh? onFCMTokenRefresh;
  @override
  final OnFirebaseNotification? onFirebaseNotification;
//firebaseMessaging
  @override
  final GenerateAppTitle? onGenerateTitle;
  @override
  final OnLocaleChange? onLocaleChange;
  @override
  final dynamic Function(String?)? onPush;
  @override
  final dynamic Function(String?)? onPop;

  @override
  String toString() {
    return 'AppEvents(onDynamicLink: $onDynamicLink, onFCMTokenRefresh: $onFCMTokenRefresh, onFirebaseNotification: $onFirebaseNotification, onGenerateTitle: $onGenerateTitle, onLocaleChange: $onLocaleChange, onPush: $onPush, onPop: $onPop)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppEvents &&
            (identical(other.onDynamicLink, onDynamicLink) || other.onDynamicLink == onDynamicLink) &&
            (identical(other.onFCMTokenRefresh, onFCMTokenRefresh) || other.onFCMTokenRefresh == onFCMTokenRefresh) &&
            (identical(other.onFirebaseNotification, onFirebaseNotification) || other.onFirebaseNotification == onFirebaseNotification) &&
            (identical(other.onGenerateTitle, onGenerateTitle) || other.onGenerateTitle == onGenerateTitle) &&
            (identical(other.onLocaleChange, onLocaleChange) || other.onLocaleChange == onLocaleChange) &&
            (identical(other.onPush, onPush) || other.onPush == onPush) &&
            (identical(other.onPop, onPop) || other.onPop == onPop));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onDynamicLink, onFCMTokenRefresh, onFirebaseNotification, onGenerateTitle, onLocaleChange, onPush, onPop);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppEventsCopyWith<_$_AppEvents> get copyWith => __$$_AppEventsCopyWithImpl<_$_AppEvents>(this, _$identity);
}

abstract class _AppEvents implements AppEvents {
  const factory _AppEvents(
      {final OnDynamicLink? onDynamicLink,
      final OnFCMTokenRefresh? onFCMTokenRefresh,
      final OnFirebaseNotification? onFirebaseNotification,
      final GenerateAppTitle? onGenerateTitle,
      final OnLocaleChange? onLocaleChange,
      final dynamic Function(String?)? onPush,
      final dynamic Function(String?)? onPop}) = _$_AppEvents;

  @override
  OnDynamicLink? get onDynamicLink;
  @override
  OnFCMTokenRefresh? get onFCMTokenRefresh;
  @override
  OnFirebaseNotification? get onFirebaseNotification;
  @override //firebaseMessaging
  GenerateAppTitle? get onGenerateTitle;
  @override
  OnLocaleChange? get onLocaleChange;
  @override
  dynamic Function(String?)? get onPush;
  @override
  dynamic Function(String?)? get onPop;
  @override
  @JsonKey(ignore: true)
  _$$_AppEventsCopyWith<_$_AppEvents> get copyWith => throw _privateConstructorUsedError;
}
