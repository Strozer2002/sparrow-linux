import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    required this.address,
    this.transactions,
    this.positions,
    this.nft,
    this.portfolio,
  });

  @HiveField(0)
  String address;

  @HiveField(1)
  List<String>? transactions;

  @HiveField(2)
  List<String>? positions;

  @HiveField(3)
  List<String>? nft;

  @HiveField(4)
  List<String>? portfolio;
}
