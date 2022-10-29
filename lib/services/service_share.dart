//sharePlus
import '../my_services.dart';

class ServiceShare {
  // static const ServiceShare _s = ServiceShare._();
  // factory ServiceShare() => _s;
  // const ServiceShare._();
  //
  const ServiceShare();
  //
  Future<void> text(String text) async {
    try {
      await Share.share(text);
    } catch (e, s) {
      logger.e(e, e, s);
    }
  }

  Future<ShareResult> fileFromPathOrUrl(String pathOrUrl, {String? subject, String? text}) async {
    try {
      if (pathOrUrl.startsWith("http")) {
        pathOrUrl = await MyServices.services.api.download(pathOrUrl);
      }

      // List<String> mimeTypes = [];
      // if (Platform.isAndroid) {
      //   mimeTypes = ['image/*'];
      // } else {
      //   String ext = extension(path);
      //   if (ext.contains(".jpg")) {
      //     mimeTypes = ['image/jpg'];
      //   } else if (ext.contains(".jpeg")) {
      //     mimeTypes = ['image/jpeg'];
      //   } else if (ext.contains(".png")) {
      //     mimeTypes = ['image/png'];
      //   }
      // }

      return await Share.shareXFiles([XFile(pathOrUrl)], text: text, subject: subject);
      // await Share.shareFiles([path], text: text, subject: subject, mimeTypes: mimeTypes);
    } catch (e, s) {
      logger.e(e, e, s);
      return ShareResult(e.toString(), ShareResultStatus.unavailable);
    }
  }
}
