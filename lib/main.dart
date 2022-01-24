//skipGenerator
import 'dart:io';

void main() {
  String newFolderName = "../my_services";
  String sourceFolder = "../";
  MyGenerator.generate(newFolderName, sourceFolder, []);
}

extension FileExtention on FileSystemEntity {
  String get name => path.split("/").last;
}

enum Settings {
  googleMaps,
  imagePicker,
  skipGenerator,
}

class MyGenerator {
  static List<Settings> _toRemove = [];
  static String _newFolderPath = '../my_services';
  static String _sourceFolder = '../';

  static void generate(newFolderPath, sourceFolder, List<Settings> toRemove) {
    _toRemove = toRemove;
    _newFolderPath = newFolderPath;
    _sourceFolder = sourceFolder;
    createNewFolderName();
    generatePubspecFile();
    generateFiles();
    pubGet();
  }

  static String createNewFolderName() {
    var newFolder = Directory(_newFolderPath);
    if (newFolder.existsSync()) {
      newFolder.deleteSync(recursive: true);
    }
    newFolder.createSync(recursive: true);
    print(newFolder.absolute.path);
    return newFolder.path;
  }

  static void generatePubspecFile() {
    var pubspec = File(_sourceFolder + "/pubspec.yaml");
    var newPubspec = StringBuffer();
    var lines = pubspec.readAsLinesSync();
    for (String line in lines) {
      if (shouldGenerate(line)) {
        newPubspec.writeln(line);
      }
    }
    var f = File(_newFolderPath + "/pubspec.yaml");
    f.createSync();
    f.writeAsStringSync(newPubspec.toString());
  }

  static bool shouldGenerate(String line) {
    for (var s in _toRemove) {
      if ((line.contains("//${s.name}") || line.contains("#${s.name}"))) {
        return false;
      }
    }
    return true;
  }

  static void pubGet() {
    Process.run("flutter", ['pub', 'get'], workingDirectory: _newFolderPath);
  }

  static void generateFiles() {
    var lib = Directory(_sourceFolder + "/lib");
    copyFiles(lib, _newFolderPath, _sourceFolder);

    var from = Directory(_sourceFolder + "/flags");
    var to = Directory(_newFolderPath + "/flags");
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
