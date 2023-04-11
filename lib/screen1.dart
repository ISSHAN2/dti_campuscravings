import 'package:dti_2/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'menupage.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});
  static const String id = 'screen1';

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: const Menu(),
      mainScreen: const Home(),
      duration: const Duration(milliseconds: 200),
      style: DrawerStyle.defaultStyle,
      openCurve: Curves.fastOutSlowIn,
      menuBackgroundColor: Colors.white,
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}
