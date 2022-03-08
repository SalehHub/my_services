import '../my_services.dart';

class ServiceURLLauncher {
  static const ServiceURLLauncher _s = ServiceURLLauncher._();
  factory ServiceURLLauncher() => _s;
  const ServiceURLLauncher._();
  //

  static Future<bool> launchUniversalLinkIos(String url) async {
    try {
      assert(url.trim() != '');
      logger.i(url);
      if (await canLaunch(url)) {
        final bool try2 = await launch(url, forceSafariVC: false);
        if (try2 == false) {
          final bool try3 = await launch(url, forceSafariVC: true);
          if (try3 == false) {
            final bool nativeAppLaunchSucceeded = await launch(url);
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

  static Future<void> openTwitterUser(String username, BuildContext context) async {
    return launchUrl('https://twitter.com/$username');
  }

  static Future<void> openTwitterTag(String tag, BuildContext context) async {
    String _tag = tag.replaceAll('#', '');
    _tag = Uri.encodeFull(_tag);

    // print(_tag);
    return launchUrl('https://twitter.com/hashtag/$_tag?src=hashtag_click');
  }

  static Future<void> launchUrl(String url) async {
    final bool result = await launchUniversalLinkIos(url);

    if (result == false) {
      ServiceSnackBar.showText(text: url);
    }
  }

  static Future<void> launchWhatsapp(String num, String text, BuildContext context) async {
    final String _text = Uri.encodeFull(text);

    final bool result = await launchUniversalLinkIos('whatsapp://send?phone=$num&text=$_text');

    if (result == false) {
      final String url = 'https://wa.me/$num?text=$_text';
      final bool nativeAppLaunchSucceeded = await launchUniversalLinkIos(url);
      if (nativeAppLaunchSucceeded == false) {
        final bool urlLaunch = await launch(url);
        if (urlLaunch == false) {
          ServiceSnackBar.showText(text: num);
        }
      }
    }
  }

  static Future<void> launchCall(String num, BuildContext context) async {
    final bool result = await launchUniversalLinkIos('tel:$num');

    if (result == false) {
      ServiceSnackBar.showText(text: num);
    }
  }

  static Future<void> launchEmail(String email, BuildContext context) async {
    final bool result = await launchUniversalLinkIos('mailto:$email');

    if (result == false) {
      ServiceSnackBar.showText(text: email);
    }
  }

  static Future<void> openAppOnStore(String iosAppStoreUrl, String androidPlayStoreUrl) async {
    if (Platform.isIOS) {
      await launchUniversalLinkIos(iosAppStoreUrl);
    } else if (Platform.isAndroid) {
      await launchUniversalLinkIos(androidPlayStoreUrl);
    }
  }
}
