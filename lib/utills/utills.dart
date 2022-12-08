import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// pickImage(ImageSource source) async {
//   ImagePicker piker = ImagePicker();
//   XFile? file = await piker.pickImage(source: source);
//   CroppedFile? file1 = await ImageCropper().cropImage(sourcePath: file!.path);
//   File? file2 = await FlutterImageCompress.compressAndGetFile(
//       File(file1!.path).absolute.path,
//       File(file1.path).absolute.path + "compress.jpg",
//       quality: 30);

//   if (file2 != null) {
//     return await file2.readAsBytes();
//   }
// }

pickImage(ImageSource source, FilterQuality quality) async {
  ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

showSnackbar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

const backgroundcolor = Color(0xFFEDF0F6);
