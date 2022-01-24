//skipGenerator
import 'dart:io';

void main() {
  String newFolderName = "../my_services";
  String sourceFolder = "../";
  MyGenerator.generate(
    newFolderName,
    sourceFolder,
    [
      Settings.googleMaps,
      Settings.imagePicker,
      Settings.photoView,
      Settings.sharePlus,
      Settings.mapLauncher,
      Settings.appLinks,
      Settings.flutterSvg,
      Settings.firebaseCrashlytics,
      Settings.firebaseMessaging,
      Settings.skipGenerator,
    ],
  );
}

extension FileExtention on FileSystemEntity {
  String get name => path.split("/").last;
}

enum Settings {
  googleMaps,
  imagePicker,
  photoView,
  sharePlus,
  mapLauncher,
  appLinks,
  flutterSvg,
  firebaseCrashlytics,
  firebaseMessaging,
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

  static String cleanFile(String contents) {
    String t = contents;
    for (var s in _toRemove) {
      String ss = "start-${s.name}";
      String es = "end-${s.name}";
      int start = t.lastIndexOf(ss);
      int end = t.lastIndexOf(es);
      if (start == -1 || end == -1) {
        continue;
      }
      String bad = t.substring(start, end + es.length);
      String result = t.replaceAll(bad, "");
      t = result;
    }

    return t;
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
    Process.run("flutter", ['clean'], workingDirectory: _newFolderPath);
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
            f.writeAsStringSync(cleanFile(newFile.toString()));
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
