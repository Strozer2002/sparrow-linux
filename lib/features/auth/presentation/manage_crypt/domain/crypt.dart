import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'crypt.g.dart';

@HiveType(typeId: 8)
class Crypt {
  final Widget? icon;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String shortName;
  @HiveField(3)
  int? amount;
  @HiveField(4)
  bool isChoose;

  Crypt({
    this.amount,
    this.icon,
    required this.name,
    required this.shortName,
    required this.isChoose,
  });
}
