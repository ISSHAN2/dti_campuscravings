import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dti_2/menu_design.dart';
import 'package:dti_2/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'models/menu.dart';
import 'models/sellers.dart';

class MenuScreens extends StatefulWidget {
  final Sellers? model;
  static const String id = "MenuScreens";
  const MenuScreens({super.key, this.model});

  @override
  State<MenuScreens> createState() => _MenuScreensState();
}

class _MenuScreensState extends State<MenuScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: CustomScrollView(
          slivers: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.model!.sellerUID)
                  .collection('menus')
                  .orderBy("publishedDate", descending: true)
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
                          Menus rmodel = Menus.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>,
                          );
                          return MenuDesign(model: rmodel, context: context);
                        },
                        itemCount: snapshot.data!.docs.length);
              },
            )
          ],
        ),
      ),
    );
  }
}
