import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'classPass.dart';

class Storage {
  Future<String> get _localPath async { // 1
    final directory = await getApplicationDocumentsDirectory();
    var path = directory.path;
    return path;
  }

  Future<File> get _localFile async { // 2
    final path = await _localPath;
    return File('$path/backup.json');
  }

  Future<File> writePeople(List<Person> people) async { // 3
    if (!await Permission.storage.request().isGranted) { // 4
      return Future.value(null);
    }

    final file = await _localFile;
    if (!await file.exists()) { // 5
      await file.create(recursive: true);
    }
    String encodedPeople = jsonEncode(people); // 6
    return file.writeAsString(encodedPeople); // 7
  }
}