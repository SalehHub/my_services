import '../my_services.dart';
part 'app_config.freezed.dart';

@freezed
class AppConfig with _$AppConfig {
  const factory AppConfig({
    @Default(true) bool withFirebase,
    @Default(true) bool withFCM,
    @Default(true) bool withCrashlytics,
    @Default(false) bool nativeLocaleChange,
    FirebaseOptions? firebaseOptions, //firebaseCore
  }) = _AppConfig;
}
