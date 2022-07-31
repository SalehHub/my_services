import '../my_services.dart';

class ServiceURLLauncher {
  // static const ServiceURLLauncher _s = ServiceURLLauncher._();
  // factory ServiceURLLauncher() => _s;
  // const ServiceURLLauncher._();
  const ServiceURLLauncher();
  //

  Future<bool> launchUniversalLinkIos(String url, {LaunchMode? mode}) async {
    try {
      assert(url.trim() != '');

      logger.i(url);

      Uri uri = Uri.parse(url);
      // print(uri.scheme);

      bool result = await canLaunchUrl(uri);
      // print("canLaunchUrl: $result");

      if (result) {
        //launch with specific mode
        if (mode != null) {
          final bool withMode = await launchUrl(uri, mode: mode);
          if (withMode == true) {
            return true;
          }
        }

        final bool try1 = await launchUrl(uri, mode: LaunchMode.externalApplication);
        // print("externalApplication: $try2");

        if (try1 == false) {
          final bool try2 = await launchUrl(uri, mode: LaunchMode.inAppWebView);
          // print("platformDefault: $try2");

          if (try2 == false) {
            final bool nativeAppLaunchSucceeded = await launchUrl(uri);
            // print("nativeAppLaunchSucceeded: $nativeAppLaunchSucceeded");

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

  Future<bool> openTwitterUser(String username) async {
    return launchUniversalLinkIos('https://twitter.com/$username');
  }

  Future<void> openTwitterTag(String tag) async {
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

  Future<void> launchStringUrlInAppWebView(String url) async {
    final bool result = await launchUniversalLinkIos(url, mode: LaunchMode.inAppWebView);

    if (result == false) {
      MyServices.services.snackBar.showText(text: url);
    }
  }

  Future<void> launchWhatsapp(String num, String text) async {
    final String msg = Uri.encodeFull(text);

    final bool result = await launchUniversalLinkIos('whatsapp://send?phone=$num&text=$msg');

    if (result == false) {
      final String url = 'https://wa.me/$num?text=$msg';
      final bool nativeAppLaunchSucceeded = await launchUniversalLinkIos(url);
      if (nativeAppLaunchSucceeded == false) {
        MyServices.services.snackBar.showText(text: num);
      }
    }
  }

  Future<void> launchCall(String num) async {
    final bool result = await launchUniversalLinkIos('tel:$num');

    if (result == false) {
      MyServices.services.snackBar.showText(text: num);
    }
  }

  Future<void> launchEmail(String email) async {
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
