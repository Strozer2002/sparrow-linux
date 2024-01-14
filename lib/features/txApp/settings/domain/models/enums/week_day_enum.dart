import 'package:hive/hive.dart';

part 'week_day_enum.g.dart';

@HiveType(typeId: 6)
enum WeekDay {
  @HiveField(0)
  monday("Понедельник"),
  @HiveField(1)
  tuesday('Вторник'),
  @HiveField(2)
  wednesday("Среда"),
  @HiveField(3)
  thursday("Четверг"),
  @HiveField(4)
  friday('Пятница'),
  @HiveField(5)
  saturday("Суббота"),
  @HiveField(6)
  sunday("Воскресенье");

  const WeekDay(this.name);

  final String name;

  @override
  String toString() => name;
}
