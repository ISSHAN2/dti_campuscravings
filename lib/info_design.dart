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
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => MenuScreens(
                      model: widget.model,
                    )));
      },
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.amber,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      width: 5,
                      color: const Color.fromARGB(255, 227, 227, 227))),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  child: Column(children: [
                    Image.network(
                      widget.model.sellerAvatarUrl!,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.model.sellerName!,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const Divider(
                      height: 3,
                      thickness: 2,
                      color: Color.fromARGB(255, 201, 200, 200),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                  ]),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 55,
          )
        ],
      ),
    );
  }
}
