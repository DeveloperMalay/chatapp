import 'dart:io';
import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ComppleteProfileScreen extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseuser;
  const ComppleteProfileScreen({Key? key, this.firebaseuser, this.userModel})
      : super(key: key);

  @override
  State<ComppleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<ComppleteProfileScreen> {
  File? imageFile;
  TextEditingController fullnameController = TextEditingController();

  void selectImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      cropImage(pickedFile);
    } else {}
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
    );
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
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
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.photo_album),
                  title: const Text('Select from Gallery'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
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

  void checkValues() {
    String fullname = fullnameController.text.trim();
    if (fullname == null || imageFile == null) {
      print('please all the fields');
    } else {
      uploadData();
    }
  }

  void uploadData() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref('profilepictures')
        .child(widget.userModel!.uid.toString())
        .putFile(imageFile!);
    TaskSnapshot snapshot = await uploadTask;

    String imageUrl = await snapshot.ref.getDownloadURL();
    String fullname = fullnameController.text.trim();

    widget.userModel!.fullname = fullname;
    widget.userModel!.profilePic = imageUrl;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel!.uid)
        .set(widget.userModel!.toMap())
        .then((value) => print('data uploaded'));
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
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      (imageFile != null) ? FileImage(imageFile!) : null,
                  child: (imageFile == null)
                      ? const Icon(
                          Icons.person,
                          size: 60,
                        )
                      : null,
                ),
                onPressed: () {
                  showPhotesOptions();
                },
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
