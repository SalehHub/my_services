//imagePicker
import '../my_services.dart';

// ignore: avoid_classes_with_only_static_members
class ServiceImagePicker {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImage(BuildContext context, {double sizeInMB = 1.0, bool square = false, bool circle = false}) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) {
        return null;
      }

      final String path = pickedFile.path;

      // if (path != null) {
      final File originalFile = File(path);

      final double originalFileSizeInMB = originalFile.lengthSync() / (1024 * 1000);

      final File? croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        compressQuality: originalFileSizeInMB > sizeInMB ? 50 : 70,
        aspectRatio: square ? const CropAspectRatio(ratioX: 1, ratioY: 1) : null,
        cropStyle: circle ? CropStyle.circle : CropStyle.rectangle,
      );

      if (croppedFile == null) {
        return null;
      }

      File? newFile = croppedFile;
      double newFileSizeInMB = croppedFile.lengthSync() / (1024 * 1000);

      int i = 0;
      while (newFileSizeInMB > sizeInMB) {
        //print(newFileSizeInMB);
        i++;
        newFile = await FlutterImageCompress.compressAndGetFile(
          newFile!.path,
          newFile.path.replaceFirst('.', '$i.', newFile.path.length - 6),
          quality: 95 - (i + 5),
          minHeight: 500,
          minWidth: 500,
        );

        newFileSizeInMB = newFile!.lengthSync() / (1024 * 1000);
      }

      if (newFile != null) {
        logger.i('Original File Size: ${Helpers.getFileSize(path)}'
            '\nCropped File  Size: ${Helpers.getFileSize(croppedFile.path)}'
            '\nNew Compressed File Size: ${Helpers.getFileSize(newFile.path)}');

        return newFile;
      }
      // }
    } catch (e, s) {
      logger.e(e, e, s);

      if (e.toString().toLowerCase().contains('photo_access_denied')) {
        MyServicesLocalizationsData myServicesLabels = getMyServicesLabels(ServiceNav.context!);
        ServiceSnackBar.showText(
          text: myServicesLabels.theAppDoesntHavePhotoAccessPermission,
          backgroundColor: Colors.red.shade900,
        );
      }
    }
    return null;
  }
}
