import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dti_2/global.dart';
import 'package:dti_2/info_design.dart';
import 'package:dti_2/menu_upload_screen.dart';
import 'package:dti_2/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'menu.dart';

class Home extends StatefulWidget {
  static const String id = "Home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, MenuUp.id);
                },
                icon: const Icon(Icons.post_add, color: Colors.deepOrange))
          ],
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black38,
              ))),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: ListTile(
              title: Text("My Menu"),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus")
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Menus model = Menus.fromJson(
                          snapshot.data!.docs[index].data()!
                              as Map<String, dynamic>,
                        );
                        return InfoDesign(model: model, context: context);
                      },
                      itemCount: snapshot.data!.docs.length);
            },
          )
        ],
      ),
    );
  }
}

Widget buildCard() => const SizedBox(
      width: 100,
      height: 100,
      child: Image(image: AssetImage('assets/maggi.png')),
    );
