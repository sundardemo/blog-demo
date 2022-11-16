import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _imagePath = '';
  String _imageServerPath = '';

  void captureImageFromGallery() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      print(file.path);
      setState(() {
        _imagePath = file.path;
      });
      _upload(file.path);
    }
  }

  void captureImageFromCamera() async {
    var file = await ImagePicker().pickImage(source: ImageSource.camera);

    // var files = await ImagePicker().pickMultiImage();
    // if(files.isNotEmpty){
    //   _uploadMultipleFiles(files);
    // }

    if (file != null) {
      print(file.path);
      setState(() {
        _imagePath = file.path;
      });
    }
  }
  // Untested - Sample code
  // _uploadMultipleFiles(List<XFile> files) async{
  //   var url = Uri.parse("https://adlisting.herokuapp.com/upload/xxx");
  //   var request = http.MultipartRequest('POST', url);
  //   files.forEach((file) async {
  //     MultipartFile image = await http.MultipartFile.fromPath('images', file.path);
  //     request.files.add(image);
  //   });

  //   var response = await request.send();
  //   var resp = await response.stream.bytesToString();
  //   var respJson = jsonDecode(resp);
  //   setState(() {
  //     _imageServerPath = respJson['data']['images'];
  //   });

  // }

  _upload(filePath) async {
    var url = Uri.parse("https://adlisting.herokuapp.com/upload/profile");
    var request = http.MultipartRequest('POST', url);
    MultipartFile image = await http.MultipartFile.fromPath('avatar', filePath);
    request.files.add(image);
    var response = await request.send();
    var resp = await response.stream.bytesToString();
    var respJson = jsonDecode(resp);
    setState(() {
      _imageServerPath = respJson['data']['path'];
    });
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
        Divider(),
        _imageServerPath.isNotEmpty
            ? Image.network(
                _imageServerPath,
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
