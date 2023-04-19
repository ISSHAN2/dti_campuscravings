import 'package:dti_2/logsign.dart';
import 'package:dti_2/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Align(
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                TextButton(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.account_box_outlined,
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Profile.id);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: const [
                Icon(
                  Icons.shopping_cart,
                  color: Colors.deepOrange,
                ),
                Text('orders')
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: const [
                Icon(
                  Icons.assessment_outlined,
                  color: Colors.deepOrange,
                ),
                Text('Privacy Policy')
              ],
            ),
            const SizedBox(
              height: 150,
            ),
            TextButton(
              child: Row(
                children: const [
                  Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.deepOrange,
                  )
                ],
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, logsign.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
