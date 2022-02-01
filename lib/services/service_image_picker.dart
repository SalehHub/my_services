//imagePicker
import '../my_services.dart';

class MyFile {
  late String sizeForHuman;
  late int sizeInBytes;
  late String path;
  late double sizeInMegabytes;
  late File file;

  MyFile(dynamic _file) {
    if (_file is String) {
      file = File(_file);
    } else if (_file is File) {
      file = _file;
    }
    path = file.path;
    sizeInBytes = file.lengthSync();
    sizeForHuman = Helpers.bytesToFileSizeForHuman(sizeInBytes);
    sizeInMegabytes = Helpers.bytesToMegabytes(sizeInBytes);
  }

  String printSize([String filename = ""]) {
    return filename + ":\t" + sizeForHuman + "\n";
  }
}

// ignore: avoid_classes_with_only_static_members
class ServiceImagePicker {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImage(BuildContext context, {bool withCrop = true, bool withCompress = true, double sizeInMB = 1.0, bool square = false, bool circle = false}) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) {
        return null;
      }

      final MyFile originalFile = MyFile(pickedFile.path);

      if (kIsWeb) {
        return originalFile.file;
      }

      MyFile compressedFile;

      if (withCrop) {
        final File? _croppedFile = await ImageCropper.cropImage(
          sourcePath: originalFile.path,
          compressQuality: originalFile.sizeInMegabytes > sizeInMB ? 50 : 80,
          aspectRatio: square ? const CropAspectRatio(ratioX: 1, ratioY: 1) : null,
          cropStyle: circle ? CropStyle.circle : CropStyle.rectangle,
        );

        if (_croppedFile != null) {
          compressedFile = MyFile(_croppedFile);
          logger.i(compressedFile.printSize("Cropped File"));
        } else {
          compressedFile = originalFile;
        }
      } else {
        compressedFile = originalFile;
      }

      if (withCompress) {
        int i = 0;
        while (compressedFile.sizeInMegabytes > sizeInMB) {
          i++;
          File? _newFile = await FlutterImageCompress.compressAndGetFile(
            compressedFile.path,
            compressedFile.path.replaceFirst('.', '$i.', compressedFile.path.length - 6),
            quality: 95 - (i + 5),
            minHeight: 500,
            minWidth: 500,
          );

          if (_newFile == null) {
            break;
          }

          compressedFile = MyFile(_newFile);
        }
      }

      logger.i(originalFile.printSize("Original File") + compressedFile.printSize("Compressed File"));

      return compressedFile.file;
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
