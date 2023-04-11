import 'package:flutter/material.dart';
import 'models/menu.dart';

// ignore: must_be_immutable
class MenuDesign extends StatelessWidget {
  Menus? model;
  BuildContext context;
  MenuDesign({super.key, required this.model, required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
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
                            size: const Size.fromRadius(58),
                            child: Image.network(model!.thumbnailUrl!,
                                fit: BoxFit.cover),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange),
                          onPressed: () {},
                          child: const Text(
                            "Add To Cart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            model!.menuTitle!,
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
                        Text(
                          model!.menuInfo!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Divider(
                  height: 3,
                  thickness: 2,
                  color: Color.fromARGB(255, 201, 200, 200),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
