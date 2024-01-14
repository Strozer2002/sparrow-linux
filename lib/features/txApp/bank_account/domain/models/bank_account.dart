import 'package:hive/hive.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';

part 'bank_account.g.dart';

@HiveType(typeId: 8)
class BankAccount {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final Currency currency;
  @HiveField(2)
  final int color;
  @HiveField(3)
  final int icon;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  double amount;
  @HiveField(6)
  final int id;
  @HiveField(7)
  bool? isSyncOrDelete;

  BankAccount({
    required this.name,
    required this.currency,
    required this.color,
    required this.icon,
    this.description,
    required this.amount,
    required this.id,
    required this.isSyncOrDelete,
  });
  // Hive fields go here
}
