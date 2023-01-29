//appLinks
import '../../my_services.dart';

typedef OnAppLinkFunction = void Function(Uri urt);

class ServiceDynamicLink {
  // static const ServiceDynamicLink _s = ServiceDynamicLink._();
  // factory ServiceDynamicLink() => _s;
  // const ServiceDynamicLink._();
  const ServiceDynamicLink();
  //
  void register(OnAppLinkFunction onAppLink) {
    //TODO: remove when web supported
    if (!kIsWeb && !Platform.isMacOS) {
      Future<void>.delayed(const Duration(seconds: 1)).then((_) async {
        final AppLinks appLinks = AppLinks();

        appLinks.uriLinkStream.listen((uri) {
          onAppLink(uri);
        });

        await appLinks.getInitialAppLink().then((Uri? uri) {
          if (uri != null) {
            onAppLink(uri);
          }
        });
      });
    }
  }
}
