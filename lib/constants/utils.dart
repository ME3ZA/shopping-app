import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String txt) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(txt)),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var myFiles = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (myFiles != null && myFiles.files.isNotEmpty) {
      for (int i = 0; i < myFiles.files.length; i++) {
        images.add(File(myFiles.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
