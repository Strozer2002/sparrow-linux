import 'package:hive_flutter/hive_flutter.dart';

part 'category_enum.g.dart';

@HiveType(typeId: 3)
enum CategoryType {
  @HiveField(0)
  expense("expense"),
  @HiveField(1)
  income("income");

  const CategoryType(this.name);

  final String name;

  @override
  String toString() => name;
}
