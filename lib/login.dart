import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dti_2/error_dialog.dart';
import 'package:dti_2/global.dart';
import 'package:dti_2/logsign.dart';
import 'package:dti_2/screen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  Future readDataAndSetLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!
            .setString("email", snapshot.data()!["usersEmail"]);
        await sharedPreferences!
            .setString("name", snapshot.data()!["userName"]);
        await sharedPreferences!
            .setString("photoUrl", snapshot.data()!["UserAvatarUrl"]);
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "No Record Found",
              );
            });
        firebaseAuth.signOut();
        Navigator.pushNamed(context, logsign.id);
      }
    });
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
            const SizedBox(
              height: 0,
            ),
            const Text('Email address'),
            TextField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Password'),
            TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              )),
            ),
            const SizedBox(
              height: 7,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Forgot password',
                  style: TextStyle(color: Colors.deepOrange)),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 150,
              child: RawMaterialButton(
                onPressed: () async {
                  try {
                    User? currentUser;
                    await _auth.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                    if (currentUser != null) {
                      readDataAndSetLocally(currentUser).then((value) {
                        Navigator.pushNamed(context, Screen.id);
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                fillColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: const Text("Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
