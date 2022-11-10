import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _imagePath = '';

  void captureImageFromGallery() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      print(file.path);
      setState(() {
        _imagePath = file.path;
      });
    }
  }

  void captureImageFromCamera() async {
    var file = await ImagePicker().pickImage(source: ImageSource.camera);

    if (file != null) {
      print(file.path);
      setState(() {
        _imagePath = file.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Column(children: [
        _imagePath.isNotEmpty
            ? Image.file(
                File(_imagePath),
                height: 100,
                width: 100,
              )
            : const SizedBox(),
        TextButton(
          onPressed: () {
            captureImageFromGallery();
          },
          child: Text("Capture Gallery"),
        ),
        TextButton(
          onPressed: () {
            captureImageFromCamera();
          },
          child: Text("Capture Camera"),
        ),
      ]),
    );
  }
}
