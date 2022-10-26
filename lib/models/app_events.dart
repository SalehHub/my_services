import '../my_services.dart';
import '../services/service_firebase_messaging.dart'; //firebaseMessaging

part 'app_events.freezed.dart';

@freezed
class AppEvents with _$AppEvents {
  const AppEvents._();

  factory AppEvents({
    Function(Uri uri, WidgetRef ref, BuildContext context)? onDynamicLink,
    Function(String token, WidgetRef ref, BuildContext context)? onFCMTokenRefresh,
    OnFirebaseNotification? onFirebaseNotification, //firebaseMessaging
    GenerateAppTitle? onGenerateTitle,
    Function(Locale? oldLocale, Locale? newLocale, WidgetRef ref, BuildContext context)? onLocaleChange,
    Function(String? name)? onPush,
    Function(String? name)? onPop,
  }) = _AppEvents;
}
