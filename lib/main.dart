import 'dart:io';

void main() {
  String newFolderName = "../my_services";
  String sourceFolder = "../";
  MyGenerator.generate(newFolderName, sourceFolder);
}

class MyGenerator {
  static bool googleMaps = false;
  static bool imagePicker = false;

  static void generate(newFolderPath, sourceFolder) {
    createNewFolderName(newFolderPath);
    generatePubspecFile(newFolderPath, sourceFolder);
    // generateFiles(newFolderPath);
    // pubGet(newFolderPath);
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
    var f = File(newFolderPath + "/" + pubspec.path);
    f.createSync(recursive: true);
    f.writeAsStringSync(newPubspec.toString());
  }

  static bool shouldGenerate(String line) {
    if (line.contains("googleMaps") && googleMaps == false) {
      return false;
    }

    if (line.contains("imagePicker") && imagePicker == false) {
      return false;
    }

    return true;
  }

  static void pubGet(newFolderPath) {
    Process.run("flutter", ['pub', 'get'], workingDirectory: newFolderPath);
  }

  static void generateFiles(newFolderPath) {
    var lib = Directory("lib");
    copyFiles(lib, newFolderPath);
  }

  static void copyFiles(Directory folder, String newFolderPath) {
    for (FileSystemEntity file in folder.listSync()) {
      if (file is File) {
        var lines = file.readAsLinesSync();
        if (shouldGenerate(lines.first)) {
          var f = File(newFolderPath + "/" + file.path);
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
        copyFiles(file, newFolderPath);
      }
    }
  }
}
