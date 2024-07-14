//appLinks
import '../../my_services.dart';

typedef OnAppLinkFunction = void Function(Uri uri);

class ServiceDynamicLink {
  const ServiceDynamicLink();
  //
  void register(OnAppLinkFunction? onAppLink) {
    //TODO: remove when web supported
    if (!kIsWeb && !Platform.isMacOS && onAppLink != null) {
      Future<void>.delayed(const Duration(seconds: 1)).then((_) async {
        final AppLinks appLinks = AppLinks();

        appLinks.uriLinkStream.listen((uri) {
          onAppLink(uri);
        });

        await appLinks.getInitialLink().then((Uri? uri) {
          if (uri != null) {
            onAppLink(uri);
          }
        });
      });
    }
  }
}
