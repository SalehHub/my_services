import '../my_services.dart';

class ServiceURLLauncher {
  static const ServiceURLLauncher _s = ServiceURLLauncher._();
  factory ServiceURLLauncher() => _s;
  const ServiceURLLauncher._();
  //

  Future<bool> launchUniversalLinkIos(String url) async {
    try {
      assert(url.trim() != '');
      logger.i(url);
      Uri uri = Uri.dataFromString(url);
      if (await canLaunchUrl(uri)) {
        final bool try2 = await launchUrl(uri, mode: LaunchMode.platformDefault);
        if (try2 == false) {
          final bool try3 = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (try3 == false) {
            final bool nativeAppLaunchSucceeded = await launchUrl(uri);
            return nativeAppLaunchSucceeded;
          } else {
            return true;
          }
        } else {
          return true;
        }
      }
    } catch (e, s) {
      logger.e(e, e, s);
    }

    return false;
  }

  Future<void> openTwitterUser(String username, BuildContext context) async {
    return launchStringUrl('https://twitter.com/$username');
  }

  Future<void> openTwitterTag(String tag, BuildContext context) async {
    String cleanTag = tag.replaceAll('#', '');
    cleanTag = Uri.encodeFull(cleanTag);

    // print(_tag);
    return launchStringUrl('https://twitter.com/hashtag/$cleanTag?src=hashtag_click');
  }

  Future<void> launchStringUrl(String url) async {
    final bool result = await launchUniversalLinkIos(url);

    if (result == false) {
      MyServices.services.snackBar.showText(text: url);
    }
  }

  Future<void> launchWhatsapp(String num, String text, BuildContext context) async {
    final String msg = Uri.encodeFull(text);

    final bool result = await launchUniversalLinkIos('whatsapp://send?phone=$num&text=$msg');

    if (result == false) {
      final String url = 'https://wa.me/$num?text=$msg';
      final bool nativeAppLaunchSucceeded = await launchUniversalLinkIos(url);
      if (nativeAppLaunchSucceeded == false) {
        final bool urlLaunch = await launchUrl(Uri.dataFromString(url));
        if (urlLaunch == false) {
          MyServices.services.snackBar.showText(text: num);
        }
      }
    }
  }

  Future<void> launchCall(String num, BuildContext context) async {
    final bool result = await launchUniversalLinkIos('tel:$num');

    if (result == false) {
      MyServices.services.snackBar.showText(text: num);
    }
  }

  Future<void> launchEmail(String email, BuildContext context) async {
    final bool result = await launchUniversalLinkIos('mailto:$email');

    if (result == false) {
      MyServices.services.snackBar.showText(text: email);
    }
  }

  Future<void> openAppOnStore(String iosAppStoreUrl, String androidPlayStoreUrl) async {
    if (Platform.isIOS) {
      await launchUniversalLinkIos(iosAppStoreUrl);
    } else if (Platform.isAndroid) {
      await launchUniversalLinkIos(androidPlayStoreUrl);
    }
  }
}
