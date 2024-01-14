import 'package:hive/hive.dart';

part 'currency.g.dart';

@HiveType(typeId: 1)
class Currency {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String symbol;

  const Currency({
    required this.name,
    required this.symbol,
  });

  @override
  String toString() {
    return "$name - $symbol";
  }
}
