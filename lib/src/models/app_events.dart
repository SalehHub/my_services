import '../../my_services.dart';
import '../services/service_firebase_messaging.dart'; //firebaseMessaging

part 'app_events.freezed.dart';

typedef OnLocaleChange = Function(Locale? oldLocale, Locale? newLocale, WidgetRef ref, BuildContext context)?;
typedef OnFCMTokenRefresh = Function(String token, WidgetRef ref, BuildContext context)?;
typedef OnDynamicLink = Function(Uri uri, WidgetRef ref, BuildContext context)?;

@freezed
class AppEvents with _$AppEvents {
  const factory AppEvents({
    OnDynamicLink onDynamicLink,
    OnFCMTokenRefresh onFCMTokenRefresh,
    OnFirebaseNotification? onFirebaseNotification, //firebaseMessaging
    GenerateAppTitle? onGenerateTitle,
    OnLocaleChange onLocaleChange,
    Function(String? name)? onPush,
    Function(String? name)? onPop,
  }) = _AppEvents;
}
