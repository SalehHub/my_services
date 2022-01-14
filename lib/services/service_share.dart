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
      await Share.shareFiles([path], text: text, subject: subject, mimeTypes: ['image/jpg', 'image/jpeg', 'image/png']);
    } catch (e, s) {
      logger.e(e, e, s);
    }
  }
}
