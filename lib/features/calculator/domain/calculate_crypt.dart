import 'package:hive/hive.dart';

part 'calculate_crypt.g.dart';

@HiveType(typeId: 12)
class CalculateCrypt {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String shortName;
  @HiveField(3)
  double price;
  @HiveField(4)
  bool isChoose;

  CalculateCrypt({
    required this.name,
    required this.shortName,
    this.price = 0,
    this.isChoose = false,
  });
}
