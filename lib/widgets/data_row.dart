import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/filesystem.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class DataHandlingRow extends StatefulWidget {
  const DataHandlingRow({
    Key? key,
  }) : super(key: key);

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
    await file.writeAsString("date,${DateTime.now().toIso8601String()}");
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
            const WideCard(
              content: "Import",
              halfWidth: true,
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
