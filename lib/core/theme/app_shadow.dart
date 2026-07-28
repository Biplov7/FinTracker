import 'package:flutter/material.dart';

class AppShadow {
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];
  static const List<BoxShadow> button = [
    BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
  ];
  static const List<BoxShadow> floatingButton = [
    BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 6)),
  ];
}
