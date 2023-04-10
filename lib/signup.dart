import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dti_2/loading_dialog.dart';
import 'package:dti_2/screen1.dart';
import 'error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'custom_text_widget.dart';
import 'global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  XFile? imageXFile;
  String Imageurl = '';
  final ImagePicker _picker = ImagePicker();
  Future<void> takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        imageXFile = XFile(pickedFile.path);
      }
    });
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please select an image.",
            );
          });
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (confirmPasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            phoneController.text.isNotEmpty) {
          //start uploading image
          showDialog(
              context: context,
              builder: (c) {
                return const LoadingDialog(
                  message: "Registering Account",
                );
              });

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child("sellers")
              .child(fileName);
          fStorage.UploadTask uploadTask =
              reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            Imageurl = url;

            //save info to firestore
            authenticateSellerAndSignUp();
          });
        } else {
          showDialog(
              context: context,
              builder: (c) {
                return const ErrorDialog(
                  message:
                      "Please write the complete required info for Registration.",
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Password do not match.",
              );
            });
      }
    }
  }

  void authenticateSellerAndSignUp() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });

    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        Route newRoute = MaterialPageRoute(builder: (c) => Screen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
      "sellerUID": currentUser.uid,
      "sellerEmail": currentUser.email,
      "sellerName": nameController.text.trim(),
      "sellerAvatarUrl": Imageurl,
      "phone": phoneController.text.trim(),
      "status": "approved",
      "earnings": 0.0,
    });

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", Imageurl);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageFile(),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              data: Icons.person,
              controller: nameController,
              hintText: "Name",
              isObsecre: false,
            ),
            CustomTextField(
              data: Icons.phone,
              controller: phoneController,
              hintText: "Phone",
              isObsecre: false,
            ),
            CustomTextField(
              data: Icons.email,
              controller: emailController,
              hintText: "Email",
              isObsecre: false,
            ),
            CustomTextField(
              data: Icons.lock,
              controller: passwordController,
              hintText: "Password",
              isObsecre: true,
            ),
            CustomTextField(
              data: Icons.lock,
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              isObsecre: true,
            ),
            const SizedBox(
              height: 7,
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 150,
              child: RawMaterialButton(
                onPressed: () async {
                  formValidation();
                },
                fillColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ImageFile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.20,
            backgroundImage: imageXFile == null
                ? null
                : FileImage(File(imageXFile!.path)) as ImageProvider<Object>?,
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showBottomSheet(
                    context: context, builder: ((builder) => bottomsheet()));
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomsheet() {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          const Center(
            child: Text(
              "Choose Profile Photo",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"))
            ],
          )
        ],
      ),
    );
  }
}
