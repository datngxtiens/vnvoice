import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource imageSource) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: imageSource);
  if (file != null) {
    print("Pick Done");
    return await file.readAsBytes();
  }
  print("No image selected");
}

pickImageXfile(ImageSource imageSource) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: imageSource);
  return file;
}

pickImages(ImageSource imageSource) async {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? files = await imagePicker.pickMultiImage();
  List<Uint8List>? images = [];
  for(int i=0;i<files!.length;i++) {
     Uint8List file =  ( await files[i].readAsBytes());
     images.add(file);
  }
  if (images != null) {
    print("Pick Done ${images.length}");
    return images ;
  }
  print("No image selected");
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),

    ),
  );
}