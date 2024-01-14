import 'package:hive/hive.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';

part 'operation.g.dart';

@HiveType(typeId: 4)
class Operation {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final Category category;
  @HiveField(3)
  final BankAccount bankAccount;
  @HiveField(4)
  final int id;
  @HiveField(5)
  bool? isSyncOrDelete;

  Operation({
    required this.date,
    required this.amount,
    required this.category,
    required this.bankAccount,
    required this.id,
    required this.isSyncOrDelete,
  });
}
