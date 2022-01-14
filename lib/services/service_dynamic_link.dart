import '../my_services.dart';

typedef OnAppLinkFunction = void Function(Uri urt);

class ServiceDynamicLink {
  static void register(OnAppLinkFunction onAppLink) {
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
