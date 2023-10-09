import 'package:hive/hive.dart';

import '../../../domain/adapters/changes.dart';

part 'crypt.g.dart';

@HiveType(typeId: 8)
class Crypt {
  @HiveField(0)
  final String iconName;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String shortName;
  @HiveField(3)
  double amount;
  @HiveField(4)
  double amountInCurrency;
  @HiveField(5)
  double priceForOne;
  @HiveField(6)
  bool isChoose;
  @HiveField(7)
  Changes changesCrypt;

  Crypt({
    this.amount = 0,
    this.amountInCurrency = 0,
    this.priceForOne = 0,
     required this.changesCrypt,
    required this.iconName,
    required this.name,
    required this.shortName,
    this.isChoose = false,
  });
}
