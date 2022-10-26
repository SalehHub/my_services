import '../my_services.dart';
import '../services/service_firebase_messaging.dart'; //firebaseMessaging

part 'app_config.freezed.dart';

@freezed
class AppConfig with _$AppConfig {
  const AppConfig._();

  factory AppConfig({
    @Default(true) bool withFirebase,
    @Default(true) bool withFCM,
    @Default(true) bool withCrashlytics,
    @Default(false) bool nativeLocaleChange,
    FirebaseOptions? firebaseOptions, //firebaseCore
  }) = _AppConfig;
}
