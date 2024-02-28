import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<String> calculateFileChecksum(String filename) async {
  final file = (await File(filename).readAsBytes()).toString();
  final bytes = utf8.encode(file);
  final digest = sha256.convert(bytes);

  return digest.toString();
}

Future<void> exportHiveBox<T>(String boxName, String backupPath) async {
  final box = await Hive.openBox(boxName);
  final boxPath = box.path;

  // print(boxPath);

  try {
    await File(boxPath!).copy("$backupPath/export-$boxName.hive");
  } finally {}
}
