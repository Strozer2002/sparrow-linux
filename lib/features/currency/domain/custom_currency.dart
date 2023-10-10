import 'package:hive/hive.dart';

part 'custom_currency.g.dart';

@HiveType(typeId: 11)
class CustomCurrency {
  @HiveField(0)
  String name;

  @HiveField(1)
  String symbol;

  @HiveField(3)
  double rate;

  CustomCurrency({
    required this.name,
    required this.rate,
    required this.symbol,
  });
}
