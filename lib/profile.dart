import 'package:flutter/material.dart';
import 'global.dart';

// our data
const url = "mes.me";
const email = "me.h007@gmail.com";
const phone = "90441539202"; // not real number :)
const location = "Lucknow, India";

class Profile extends StatelessWidget {
  static const String id = 'Profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage(sharedPreferences!.getString("photoUrl")!),
              ),
              Text(
                sharedPreferences!.getString("name")!,
                style: const TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
              Text(
                "Video Editor",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueGrey[200],
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              // we will be creating a new widget name info carrd
            ],
          ),
        ));
  }
}
