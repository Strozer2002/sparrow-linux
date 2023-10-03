import 'package:flutter/material.dart';

class Crypt {
  final Widget icon;
  final String name;
  final String shortName;
  double? amount;
  bool isChoose;

  Crypt({
    this.amount,
    required this.icon,
    required this.name,
    required this.shortName,
    required this.isChoose,
  });
}
