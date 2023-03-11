import 'package:flutter/material.dart';
import 'package:dti_2/signup.dart';
import 'login.dart';

class logsign extends StatefulWidget {
  static const String id = 'logsign';
  const logsign({super.key});

  @override
  State<logsign> createState() => _logsignState();
}

class _logsignState extends State<logsign> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          toolbarHeight: 300,
          backgroundColor: Colors.white,
          title: const Text('🗿'),
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(100))),
          centerTitle: true,
          bottom: const TabBar(
              isScrollable: true,
              padding: EdgeInsets.only(left: 5),
              indicatorPadding: EdgeInsets.only(left: 2),
              labelPadding: EdgeInsets.symmetric(horizontal: 20),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 5.0, color: Colors.deepOrange),
                  insets: EdgeInsets.only(right: 5)),
              tabs: [
                Tab(
                    child: Text('             LogIn          ',
                        style: TextStyle(color: Colors.black))),
                Tab(
                    child: Text('      Sign-Up           ',
                        style: TextStyle(color: Colors.black)))
              ]),
        ),
        body: TabBarView(
          children: [Login(), Signup()],
        ),
      ),
    );
  }
}
