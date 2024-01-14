import 'package:hive/hive.dart';
import 'package:sparrow/features/txApp/category/domain/models/category_enum.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final Currency currency;
  @HiveField(2)
  final int color;
  @HiveField(3)
  final int icon;
  @HiveField(4)
  final CategoryType type;
  @HiveField(5)
  double amount;
  @HiveField(6)
  final int id;
  @HiveField(7)
  bool? isSyncOrDelete;

  Category({
    required this.name,
    required this.currency,
    required this.color,
    required this.icon,
    required this.type,
    this.amount = 0.0,
    required this.id,
    required this.isSyncOrDelete,
  });

  @override
  String toString() {
    return "$name : ${currency.name} - ${currency.symbol}";
  }

  String get getAmountAndCurrency {
    return "$amount ${currency.symbol}";
  }
}
