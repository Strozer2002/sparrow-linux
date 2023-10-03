import 'package:hive/hive.dart';

import 'portfolio.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String address;

  @HiveField(1)
  List<String>? transactions;

  @HiveField(2)
  List<String>? positions;

  @HiveField(3)
  List<String>? nft;

  @HiveField(4)
  Portfolio portfolio;

  @HiveField(5)
  String mnemonicSentence;

  User({
    required this.address,
    this.transactions,
    this.positions,
    this.nft,
    required this.portfolio,
    required this.mnemonicSentence,
  });
}
