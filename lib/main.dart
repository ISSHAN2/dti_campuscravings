import 'package:dti_2/firebase_options.dart';
import 'package:dti_2/global.dart';
import 'package:dti_2/home.dart';
import 'package:dti_2/menus_screen.dart';
import 'package:dti_2/profile.dart';
import 'package:dti_2/screen1.dart';
import 'package:dti_2/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logsign.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MySplashScreen.id,
      routes: {
        MySplashScreen.id: (context) => const MySplashScreen(),
        LogSign.id: (context) => const LogSign(),
        Screen.id: (context) => const Screen(),
        Home.id: (context) => const Home(),
        MenuScreens.id: (context) => const MenuScreens(),
        Profile.id: (context) => const Profile(),
      },
    );
  }
}
