//skipGenerator
import 'dart:io';

// void main() {
//   String newFolderName = "../my_services";
//   String sourceFolder = "../";
//   MyGenerator.generate(newFolderName, sourceFolder);
// }
extension FileExtention on FileSystemEntity {
  String get name => path.split("/").last;
}

class MyGenerator {
  static bool googleMaps = false;
  static String googleMapsKey = "googleMaps";
  static bool imagePicker = false;
  static String imagePickerKey = "imagePicker";

  static String skipGeneratorKey = "skipGenerator";

  static void generate(newFolderPath, sourceFolder) {
    createNewFolderName(newFolderPath);
    generatePubspecFile(newFolderPath, sourceFolder);
    generateFiles(newFolderPath, sourceFolder);
    pubGet(newFolderPath);
  }

  static String createNewFolderName(newFolderPath) {
    var newFolder = Directory(newFolderPath);
    if (newFolder.existsSync()) {
      newFolder.deleteSync(recursive: true);
    }
    newFolder.createSync(recursive: true);
    print(newFolder.absolute.path);
    return newFolder.path;
  }

  static void generatePubspecFile(newFolderPath, sourceFolder) {
    var pubspec = File(sourceFolder + "/pubspec.yaml");
    var newPubspec = StringBuffer();
    var lines = pubspec.readAsLinesSync();
    for (String line in lines) {
      if (shouldGenerate(line)) {
        newPubspec.writeln(line);
      }
    }
    var f = File(newFolderPath + "/pubspec.yaml");
    f.createSync();
    f.writeAsStringSync(newPubspec.toString());
  }

  static bool shouldGenerate(String line) {
    if ((line.contains("//$googleMapsKey") || line.contains("#$googleMapsKey")) && googleMaps == false) {
      return false;
    }

    if ((line.contains("//$imagePickerKey") || line.contains("#$imagePickerKey")) && imagePicker == false) {
      return false;
    }

    if ((line.contains("//$skipGeneratorKey") || line.contains("#$skipGeneratorKey"))) {
      return false;
    }

    return true;
  }

  static void pubGet(newFolderPath) {
    Process.run("flutter", ['pub', 'get'], workingDirectory: newFolderPath);
  }

  static void generateFiles(newFolderPath, sourceFolder) {
    var lib = Directory(sourceFolder + "/lib");
    copyFiles(lib, newFolderPath, sourceFolder);

    var from = Directory(sourceFolder + "/flags");
    var to = Directory(newFolderPath + "/flags");
    copyFolder(from, to);
  }

  static copyFolder(Directory from, Directory to) {
    to.createSync();
    for (FileSystemEntity file in from.listSync()) {
      if (file is File) {
        file.copySync(to.path + "/" + file.name);
      }
    }
  }

  static void copyFiles(Directory folder, String newFolderPath, sourceFolder) {
    String folderPath = folder.path.replaceAll(sourceFolder, "");
    for (FileSystemEntity file in folder.listSync()) {
      try {
        if (file is File) {
          var lines = file.readAsLinesSync();
          if (shouldGenerate(lines.first)) {
            var f = File(newFolderPath + folderPath + "/" + file.name);
            f.createSync(recursive: true);
            var newFile = StringBuffer();
            for (String line in lines) {
              if (shouldGenerate(line)) {
                newFile.writeln(line);
              }
            }
            f.writeAsStringSync(newFile.toString());
          }
        } else if (file is Directory) {
          copyFiles(file, newFolderPath, sourceFolder);
        }
      } catch (e, s) {
        print(e);
      }
    }
  }
}
