import '../my_services.dart';

class ServiceShare {
  static Future<void> text(String text) async {
    try {
      await Share.share(text);
    } catch (e, s) {
      logger.e(e, e, s);
    }
  }

  static Future<void> image(String path, {String? subject, String? text}) async {
    try {
      if (path.startsWith("http")) {
        path = await ServiceApi.download(path);
      }

      List<String> mimeTypes = [];
      if (Platform.isAndroid) {
        mimeTypes = ['image/*'];
      } else {
        String ext = extension(path);
        if (ext.contains(".jpg")) {
          mimeTypes = ['image/jpg'];
        } else if (ext.contains(".jpeg")) {
          mimeTypes = ['image/jpeg'];
        } else if (ext.contains(".png")) {
          mimeTypes = ['image/png'];
        }
      }

      await Share.shareFiles([path], text: text, subject: subject, mimeTypes: mimeTypes);
    } catch (e, s) {
      logger.e(e, e, s);
    }
  }
}
