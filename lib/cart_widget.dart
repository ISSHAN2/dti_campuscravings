import 'package:flutter/material.dart';

class TotalAmountContainer extends StatefulWidget {
  const TotalAmountContainer({Key? key}) : super(key: key);

  @override
  _TotalAmountContainerState createState() => _TotalAmountContainerState();
}

class _TotalAmountContainerState extends State<TotalAmountContainer> {
  int _totalAmount = 0;

  void _updateTotalAmount(int amount) {
    setState(() {
      _totalAmount += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _totalAmount > 0 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Total Amount${_totalAmount.toString()}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
