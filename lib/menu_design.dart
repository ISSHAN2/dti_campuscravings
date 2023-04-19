import 'package:flutter/material.dart';
import 'models/menu.dart';
import 'assistant_method.dart';

class MenuDesign extends StatefulWidget {
  final Menus model;
  final BuildContext context;

  MenuDesign({
    Key? key,
    required this.model,
    required this.context,
  }) : super(key: key);

  @override
  State<MenuDesign> createState() => _MenuDesignState();
}

class _MenuDesignState extends State<MenuDesign> {
  bool _ = false;
  int _count = 0;
  int _total = 0;
  bool _showIncrementDecrementButtons = false;

  void _closeBottomSheet() {
    Navigator.pop(context);
  }

  bool _isVisib() {
    // Add your implementation here to calculate the value of ``
    return _;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: SizedBox(
                child: Column(children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(58),
                              child: Image.network(widget.model.thumbnailUrl!,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _showIncrementDecrementButtons =
                                    !_showIncrementDecrementButtons;
                                if (_showIncrementDecrementButtons) {
                                  showBottomSheet(
                                    context: context,
                                    builder: (builder) => bottomsheet(),
                                  );
                                  _count = 1;
                                  _total += int.parse(widget.model.menuPrice!);
                                  return;
                                } else {
                                  _total = 0;
                                  _count = 0;
                                }
                              });
                            },
                            child: _showIncrementDecrementButtons
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (_count > 1) {
                                              _total -= _total;
                                              _count--;
                                            } else {
                                              _total = 0;

                                              _count = 0;
                                              _showIncrementDecrementButtons =
                                                  false;
                                            }
                                          });
                                        },
                                        icon: const Icon(Icons.remove),
                                        color: Colors.green,
                                      ),
                                      Text(
                                        '$_count',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _count++;

                                          setState(() {
                                            _total += _total;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                        ),
                                        color: Colors.green,
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'ADD',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
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
                              '₹ ${widget.model!.menuPrice!}',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 49, 137, 52),
                                  fontSize: 25,
                                  fontFamily: "Proxima Nova",
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.model!.menuInfo!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 122, 121, 121),
                                fontSize: 15,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 90.0,
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
      ),
    );
  }

  Widget Container1() {
    return Expanded(
        child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.blue,
      ),
    ));
  }

  bottomsheet() {
    return InkWell(
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                _total.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
