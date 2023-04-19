import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dti_2/error_dialog.dart';
import 'package:dti_2/global.dart';
import 'package:dti_2/logsign.dart';
import 'package:dti_2/screen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'custom_text_widget.dart';
import 'loading_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = '';
  String password = '';

  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login
      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please write email/password.",
            );
          });
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingDialog(
            message: "Checking Credentials",
          );
        });

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
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
      readDataAndSetLocally(currentUser!).then((value) {
        Navigator.pushNamed(context, Screen.id);
      });
    }
  }

  Future readDataAndSetLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!
            .setString("email", snapshot.data()!["sellerEmail"]);
        await sharedPreferences!
            .setString("name", snapshot.data()!["sellerName"]);
        await sharedPreferences!
            .setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
      } else {
        firebaseAuth.signOut();
        Navigator.pushNamed(context, logsign.id);

        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "No Record Found",
              );
            });
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
            CustomTextField(
              data: Icons.email,
              controller: emailController,
              isObsecre: false,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Password'),
            CustomTextField(
              data: Icons.lock,
              controller: passwordController,
              isObsecre: true,
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
            SizedBox(
              width: 150,
              child: RawMaterialButton(
                onPressed: () {
                  formValidation();
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
