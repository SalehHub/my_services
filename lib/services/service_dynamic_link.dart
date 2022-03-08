//appLinks
import '../my_services.dart';

typedef OnAppLinkFunction = void Function(Uri urt);

class ServiceDynamicLink {
  static const ServiceDynamicLink _s = ServiceDynamicLink._();
  factory ServiceDynamicLink() => _s;
  const ServiceDynamicLink._();
  //
  static void register(OnAppLinkFunction onAppLink) {
    if (!kIsWeb && !Platform.isMacOS) {
      //TODO: remove when supported
      Future<void>.delayed(const Duration(seconds: 1)).then((_) async {
        final AppLinks _appLinks = AppLinks(
          // Called when a new uri has been redirected to the app
          onAppLink: (Uri uri, _) => onAppLink(uri),
        );

        await _appLinks.getInitialAppLink().then((Uri? uri) {
          if (uri != null) {
            onAppLink(uri);
          }
        });
      });
    }
  }
}
