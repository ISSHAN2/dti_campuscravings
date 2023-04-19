import 'package:flutter/material.dart';
import 'menu.dart';

class InfoDesign extends StatefulWidget {
  Menus? model;
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
                          borderRadius:
                              BorderRadius.circular(20), // Image border
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(58), // Image radius
                            child: Image.network(widget.model!.thumbnailUrl!,
                                fit: BoxFit.cover),
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
                            widget.model!.menuTitle!,
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
                          "₹ ${widget.model!.menuPrice!}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 27, 125, 30),
                              fontSize: 22,
                              fontFamily: "Proxima Nova",
                              fontWeight: FontWeight.w200),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.model!.menuInfo!,
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
