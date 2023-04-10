import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dti_2/global.dart';
import 'package:dti_2/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'error_dialog.dart';
// ignore: library_prefixes
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

class MenuUp extends StatefulWidget {
  const MenuUp({super.key});
  static const String id = 'menu';

  @override
  State<MenuUp> createState() => _MenuUpState();
}

class _MenuUpState extends State<MenuUp> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.deepOrange,
            )),
        centerTitle: true,
        title: const Text(
          "Add Menu",
          style: TextStyle(color: Colors.deepOrange),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 140.0),
        child: Center(
            child: Column(
          children: [
            const Icon(
              size: 275,
              Icons.shop_2,
              color: Color.fromARGB(255, 227, 226, 226),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              onPressed: () {
                takeImage(context);
              },
              child: const Text(
                "Add Menu",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )),
      ),
    );
  }

  takeImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "Menu Image",
            style: TextStyle(
              color: Colors.deepOrange,
            ),
          ),
          children: [
            SimpleDialogOption(
              onPressed: captureCamImage,
              child: const Text(
                "Capture With Camera",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: selectGallImage,
              child: const Text(
                "Capture With Gallery",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Color.fromARGB(255, 241, 122, 114),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  captureCamImage() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      imageXFile;
    });
  }

  selectGallImage() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      imageXFile;
    });
  }

  menusuploadForm() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.deepOrange,
          ),
          onPressed: () {
            clearMenusUploadForm();
          },
        ),
        title: const Text(
          "New Menus",
          style: TextStyle(color: Colors.deepOrange),
        ),
        actions: [
          TextButton(
              onPressed: () {
                uploading ? null : validateUploadForm();
              },
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.deepOrange),
              ))
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : const Text(""),
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
                child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(
                      File(imageXFile!.path),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
          ),
          ListTile(
            leading: const Icon(
              Icons.title,
              color: Colors.deepOrange,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: titlecontroller,
                decoration: const InputDecoration(
                    hintText: "Menu Title", border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 206, 206, 206),
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.deepOrange,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: shortInfoController,
                decoration: const InputDecoration(
                    hintText: "Menu Info", border: InputBorder.none),
              ),
            ),
          )
        ],
      ),
    );
  }

  clearMenusUploadForm() {
    setState(() {
      shortInfoController.clear();
      titlecontroller.clear();
      imageXFile = null;
      uploading = false;
    });
  }

  validateUploadForm() async {
    setState(() {
      uploading = true;
    });
    if (imageXFile != null) {
      if (shortInfoController.text.isNotEmpty &&
          titlecontroller.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });
        String downloadUrl = await uploadImage(File(imageXFile!.path));
        saveInfo(downloadUrl, shortInfoController.text, titlecontroller.text);
      } else {
        uploading = false;
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Please add title and info",
              );
            });
      }
    } else {
      uploading = false;

      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please pick an image for the menu",
            );
          });
    }
  }

  saveInfo(String downloadUrl, String shortInfo, String titleMenu) {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");

    ref.doc(uniqueIdName).set({
      "menuId": uniqueIdName,
      "sellerUID": sharedPreferences!.getString("uid"),
      "menuInfo": shortInfoController.text.toString(),
      "menuTitle": titlecontroller.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    });

    clearMenusUploadForm();
    setState(() {
      uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });
  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("menus");

    storageRef.UploadTask uploadTask =
        reference.child("$uniqueIdName.jpg").putFile(mImageFile);
    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : menusuploadForm();
  }
}
