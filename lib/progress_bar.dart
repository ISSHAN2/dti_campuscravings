import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Colors.deepOrange,
      ),
    ),
  );
}

linearProgress() {
  return Container(
    alignment: Alignment.center,
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Colors.deepOrange,
      ),
    ),
  );
}
