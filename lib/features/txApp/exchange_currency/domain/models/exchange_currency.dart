import 'package:hive/hive.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';

part 'exchange_currency.g.dart';

@HiveType(typeId: 9)
class ExchangeCurrency {
  @HiveField(0)
  final Currency currencyFrom;
  @HiveField(1)
  final Currency currencyInto;
  @HiveField(2)
  final double amountFrom;
  @HiveField(3)
  final double amountInto;
  @HiveField(4)
  final int id;
  @HiveField(5)
  bool? isSyncOrDelete;

  // Hive fields go here

  ExchangeCurrency({
    required this.currencyFrom,
    required this.currencyInto,
    required this.amountFrom,
    required this.amountInto,
    required this.id,
    required this.isSyncOrDelete,
  });
}
