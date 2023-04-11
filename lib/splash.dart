import 'dart:async';

import 'package:dti_2/screen1.dart';
import 'package:flutter/material.dart';
import 'LogSign.dart';
import 'global.dart';

class MySplashScreen extends StatefulWidget {
  static const String id = 'splash';
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      //if seller is loggedin already
      if (firebaseAuth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Screen()));
      }
      //if seller is NOT loggedin already
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const LogSign()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/splash_dti.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Buy And Track Food Online",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
