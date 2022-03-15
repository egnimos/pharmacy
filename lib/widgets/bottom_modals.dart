import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showPicker(
  BuildContext context, {
  required Future<void> Function(ImageSource imgsrc) pickFile,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.green.shade100,
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(
                'Photo Library',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                await pickFile(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text(
                'Camera',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                await pickFile(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
