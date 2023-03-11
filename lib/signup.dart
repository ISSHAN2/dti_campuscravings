import 'dart:io';
import 'error_dialog.dart';
import 'package:dti_2/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String name = '';
  String phoneNo = '';
  XFile? imageXFile;
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
              message: 'Please Choose an Image',
            );
          });
    } else {
      if (password.isNotEmpty &&
          email.isNotEmpty &&
          name.isNotEmpty &&
          phoneNo.isNotEmpty) {
        try {
          final newUser = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          if (newUser != null) {
            Navigator.pushNamed(context, Home.id);
          }
        } catch (e) {
          print(e);
        }
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: 'Fill all the required fields',
              );
            });
      }
    }
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
            const Text('Full Name'),
            TextFormField(
              onChanged: (value) {
                name = value;
              },
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  prefixIcon:
                      Icon(Icons.account_box_rounded, color: Colors.black)),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Phone No'),
            TextFormField(
              onChanged: (value) {
                phoneNo = value;
              },
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  prefixIcon:
                      Icon(Icons.account_box_rounded, color: Colors.black)),
            ),
            const Text('Email address'),
            TextFormField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text('Password'),
            TextFormField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
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
      child: Stack(children: <Widget>[
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
            ))
      ]),
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
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
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
