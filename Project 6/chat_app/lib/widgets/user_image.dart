import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedimage) imagepickerfn;
  UserImagePicker(this.imagepickerfn);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  void _imagepicker() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    final pickedImageFile = File(pickedImage!.path);
// ! is a null check.. dont know . check for potential error.
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagepickerfn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: _pickedImage != null
              // null check is annoying.
              ? FileImage(_pickedImage!)
              : null, // != null is not necessary.
        ),
        TextButton.icon(
          onPressed: _imagepicker,
          icon: const Icon(
            Icons.image,
          ),
          label: const Text('Add an Image'),
        )
      ],
    );
  }
}
