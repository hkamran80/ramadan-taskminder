import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/filesystem.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class DataHandlingRow extends StatefulWidget {
  const DataHandlingRow({
    Key? key,
    required this.version,
  }) : super(key: key);

  final String version;

  @override
  State<DataHandlingRow> createState() => _DataHandlingRowState();
}

class _DataHandlingRowState extends State<DataHandlingRow> {
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> exportBoxes() async {
    final exportDirectory = await localPath;

    for (final box in boxes) {
      // print("Exporting $box...");
      // Copy file
      await exportHiveBox(box, exportDirectory);
    }

    var encoder = ZipFileEncoder();
    encoder.create("$exportDirectory/rtm-export.zip");
    for (final box in boxes) {
      // print("Archiving $box...");

      // Add file to archive
      await encoder.addFile(
        File("$exportDirectory/export-$box.hive"),
        "$box.hive",
      );

      // Write checksum
      String checksum =
          await calculateFileChecksum("$exportDirectory/export-$box.hive");
      final file = File("$exportDirectory/$box.sha256");
      await file.writeAsString(checksum);
      await encoder.addFile(file);
    }

    final File file = File("$exportDirectory/meta.txt");
    await file.writeAsString(
        "version,${widget.version}\ndate,${DateTime.now().toIso8601String()}");
    await encoder.addFile(file);

    // print("Closing archive...");
    encoder.close();

    // Save archive
    // print("Saving archive...");
    await FlutterFileDialog.saveFile(
      params: SaveFileDialogParams(
        sourceFilePath: "$exportDirectory/rtm-export.zip",
      ),
    );

    // Delete files
    // print("Deleting files...");
    for (final box in boxes) {
      final hiveFile = File("$exportDirectory/export-$box.hive");
      final checksumFile = File("$exportDirectory/$box.sha256");

      await hiveFile.delete();
      await checksumFile.delete();
    }

    final archiveFile = File("$exportDirectory/rtm-export.zip");
    final metadataFile = File("$exportDirectory/meta.txt");

    await archiveFile.delete();
    await metadataFile.delete();
  }

  Future<void> importBoxes() async {
    final exportDirectory = await localPath;
    final baseImportPath = "$exportDirectory/import";
    final requiredFiles = [
      "meta.txt",
      "quran.hive",
      "tasks.hive",
      "prayers.hive",
      "quran.sha256",
      "tasks.sha256",
      "prayers.sha256"
    ];

    print("Importing...");

    String? filePath;
    try {
      filePath = await FlutterFileDialog.pickFile(
        params: const OpenFileDialogParams(
          dialogType: OpenFileDialogType.document,
          fileExtensionsFilter: ["zip"],
        ),
      );
    } on PlatformException catch (error) {
      print("PlatformException :: $error");
      return;
    }

    // TODO: Load the file from `filePath`, then extract the contents of the ZIP. Validate the checksums,
    // then confirm with the user that this is the data they want to import (maybe move the confirmation
    // step here?), then replace the boxes. Need to figure out a way to make sure the boxes are reopened
    // for use in the other pages.

    if (filePath == null) return;

    final bytes = await File(filePath).readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        File("$baseImportPath/$filename")
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
    }

    // Verifying files exist...
    int requiredFilesCount = 0;
    for (final entry in Directory("$baseImportPath/").listSync()) {
      if (requiredFiles.contains(entry.path.split("/").last)) {
        requiredFilesCount++;
      }
    }

    if (requiredFilesCount == requiredFiles.length) {
      print("Required files are present.");
    } else {
      print(
          "File does not contain all required files — $requiredFilesCount, should be ${requiredFiles.length}");
      return;
    }

    // Validating Hive files...
    int equalChecksums = 0;
    for (final box in boxes) {
      String checksum =
          await calculateFileChecksum("$baseImportPath/$box.hive");

      final checksumFile = File("$baseImportPath/$box.sha256");
      final checksumFileString = await checksumFile.readAsString();

      if (checksum == checksumFileString) equalChecksums++;
    }

    if (equalChecksums == boxes.length) {
      print("Checksums check out.");
    } else {
      print(
          "Checksums do not check out — $equalChecksums, should be ${boxes.length}");
      return;
    }

    // Importing
    for (final box in boxes) {
      // print("Importing $box...");
      // Copy file
      await importHiveBox(box, "$baseImportPath/$box.hive");
    }
    
    print("Import complete!");
  }

  void confirmImport() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Import"),
          content: const Text(
            "Are you sure you want to import your data? Your current data will be deleted.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text(
                "Import",
                style: TextStyle(
                  color: isDark(context) ? primaryLightColor : primaryDarkColor,
                ),
              ),
              onPressed: () {
                importBoxes();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Data"),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WideCard(
              content: "Import",
              halfWidth: true,
              onTap: () => confirmImport(),
            ),
            WideCard(
              content: "Export",
              halfWidth: true,
              onTap: () => exportBoxes(),
            ),
          ],
        ),
      ],
    );
  }
}
