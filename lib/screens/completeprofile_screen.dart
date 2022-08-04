import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ComppleteProfileScreen extends StatefulWidget {
  const ComppleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<ComppleteProfileScreen> createState() => _ComppleteProfileScreenState();
}

class _ComppleteProfileScreenState extends State<ComppleteProfileScreen> {
  late File imageFile;
  TextEditingController fullnameController = TextEditingController();

  void selectImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      cropImage(pickedFile);
    } else {}
  }

  void cropImage(XFile file) async {
    // File? croppedImage = await ImageCropper.cropImage(sourcePath: file.path);
  }

  void showPhotesOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    selectImage(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.photo_album),
                  title: const Text('Select from Gallery'),
                ),
                ListTile(
                  onTap: () {
                    selectImage(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a Photo'),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Complete Profile'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                child: const CircleAvatar(
                  radius: 60,
                  child: Icon(
                    Icons.person,
                    size: 60,
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(labelText: "Full Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                color: Theme.of(context).colorScheme.secondary,
                child: const Text('Submit'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
