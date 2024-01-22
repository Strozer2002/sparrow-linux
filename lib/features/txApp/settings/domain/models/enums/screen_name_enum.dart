import 'package:hive/hive.dart';

part 'screen_name_enum.g.dart';

@HiveType(typeId: 7)
enum ScreensName {
  @HiveField(0)
  bankAccount("Accounts", 0),
  @HiveField(1)
  category('Categories', 1),
  @HiveField(2)
  operation("Operations", 2),
  @HiveField(3)
  review("Courses", 3);

  const ScreensName(this.name, this.id);

  final String name;
  final int id;
  @override
  String toString() => name;
}
