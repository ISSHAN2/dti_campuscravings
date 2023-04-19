import 'package:dti_2/menus_screen.dart';
import 'package:flutter/material.dart';
import 'models/sellers.dart';

// ignore: must_be_immutable
class InfoDesign extends StatefulWidget {
  Sellers model;
  BuildContext context;
  InfoDesign({super.key, required this.model, required this.context});

  @override
  State<InfoDesign> createState() => _InfoDesignState();
}

class _InfoDesignState extends State<InfoDesign> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => MenuScreens(
                          model: widget.model,
                        )));
          },
          splashColor: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: SizedBox(
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(68),
                            child: Image.network(widget.model.sellerAvatarUrl!,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.model.sellerName!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: "Proxima Nova",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
