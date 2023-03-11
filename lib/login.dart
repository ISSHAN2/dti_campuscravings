import 'package:dti_2/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
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
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, Home.id);
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
