//skipGenerator
import 'dart:io';

void main() {
  String newFolderName = "../my_services";
  String sourceFolder = "../";
  MyGenerator.generate(newFolderName, sourceFolder);
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
    var lib = Directory("./");
    copyFiles(lib, newFolderPath, sourceFolder);
  }

  static void copyFiles(Directory folder, String newFolderPath, sourceFolder) {
    for (FileSystemEntity file in folder.listSync()) {
      if (file is File) {
        var lines = file.readAsLinesSync();
        if (shouldGenerate(lines.first)) {
          var f = File(newFolderPath + "/lib/" + file.path);
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
    }
  }
}
