import 'package:hive/hive.dart';

part 'week_day_enum.g.dart';

@HiveType(typeId: 6)
enum WeekDay {
  @HiveField(0)
  monday("Monday"),
  @HiveField(1)
  tuesday('Tuesday'),
  @HiveField(2)
  wednesday("Wednesday"),
  @HiveField(3)
  thursday("Thursday"),
  @HiveField(4)
  friday('Friday'),
  @HiveField(5)
  saturday("Saturday"),
  @HiveField(6)
  sunday("Sunday");

  const WeekDay(this.name);

  final String name;

  @override
  String toString() => name;
}
