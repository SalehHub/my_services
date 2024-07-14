//imagePicker
import '../../my_services.dart';

class MyFile {
  late String sizeForHuman;
  late int sizeInBytes;
  late String path;
  late double sizeInMegabytes;
  late File file;

  MyFile(dynamic maybeFile) {
    if (maybeFile is String) {
      file = File(maybeFile);
    } else if (maybeFile is File) {
      file = maybeFile;
    } else if (maybeFile is XFile) {
      file = File(maybeFile.path);
    } else if (maybeFile is CroppedFile) {
      file = File(maybeFile.path);
    }
    path = file.path;
    sizeInBytes = file.lengthSync();
    sizeForHuman = MyServices.helpers.bytesToFileSizeForHuman(sizeInBytes);
    sizeInMegabytes = MyServices.helpers.bytesToMegabytes(sizeInBytes);
  }

  String printSize([String filename = ""]) {
    return "$filename:\t$sizeForHuman\n";
  }
}

// ignore: avoid_classes_with_only_static_members
class ServiceImagePicker {
  // static const ServiceImagePicker _s = ServiceImagePicker._();
  // factory ServiceImagePicker() => _s;
  // const ServiceImagePicker._();
  //
  const ServiceImagePicker();

  //

  static final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImage(BuildContext context,
      {bool withCrop = true,
      bool withCompress = true,
      double sizeInMB = 1.0,
      bool square = false,
      bool circle = false,
      bool forceCut = false}) async {
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
        final CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: originalFile.path,
          compressQuality: originalFile.sizeInMegabytes > sizeInMB ? 50 : 80,
          aspectRatio:
              square ? const CropAspectRatio(ratioX: 1, ratioY: 1) : null,
          uiSettings: [
            AndroidUiSettings(
              cropStyle: circle ? CropStyle.circle : CropStyle.rectangle,
            ),
            IOSUiSettings(
                cropStyle: circle ? CropStyle.circle : CropStyle.rectangle)
          ],
        );

        if (forceCut && croppedFile == null) {
          return null;
        }

        if (croppedFile != null) {
          compressedFile = MyFile(croppedFile);
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
          XFile? newFile = await FlutterImageCompress.compressAndGetFile(
            compressedFile.path,
            compressedFile.path
                .replaceFirst('.', '$i.', compressedFile.path.length - 6),
            quality: 95 - (i + 5),
            minHeight: 500,
            minWidth: 500,
          );

          if (newFile == null) {
            break;
          }

          compressedFile = MyFile(newFile);
        }
      }

      logger.i(originalFile.printSize("Original File") +
          compressedFile.printSize("Compressed File"));

      return compressedFile.file;
    } catch (e, s) {
      logger.e(e, error: e, stackTrace: s);

      if (e.toString().toLowerCase().contains('photo_access_denied')) {
        // ignore: use_build_context_synchronously
        MyServicesLocalizationsData myServicesLabels =
            getMyServicesLabels(MyServices.context);
        MyServices.services.snackBar.showText(
          text: myServicesLabels.theAppDoesntHavePhotoAccessPermission,
          success: false,
        );
      }
    }
    return null;
  }
}
