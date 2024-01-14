import 'package:hive/hive.dart';
import 'package:sparrow/features/auth/domain/adapters/transaction.dart';
import 'package:sparrow/features/currency/domain/custom_currency.dart';

import 'portfolio.dart';

part 'user.g.dart';

@HiveType(typeId: 10)
class User {
  @HiveField(0)
  String address;

  @HiveField(5)
  int sumBalance;

  @HiveField(7)
  int sumMem;

  @HiveField(6)
  int txCount;

  // @HiveField(1)
  // List<Transaction>? transactions;

  // @HiveField(2)
  // List<CustomCurrency> currencies;

  // @HiveField(3)
  // List<String>? nft;

  // @HiveField(4)
  // Portfolio portfolio;

  User({
    required this.address,
    required this.sumBalance,
    required this.sumMem,
    required this.txCount,
    // this.transactions,
    // this.nft,
    // required this.portfolio,
    // required this.currencies,
  });
}
