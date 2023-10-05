import 'package:hive/hive.dart';

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
  final int amount;
  @HiveField(4)
  bool isChoose;

  Crypt({
    required this.amount,
    required this.iconName,
    required this.name,
    required this.shortName,
    this.isChoose = false,
  });
}
