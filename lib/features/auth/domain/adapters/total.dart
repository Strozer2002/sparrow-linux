import 'package:hive/hive.dart';

part 'total.g.dart';

@HiveType(typeId: 5)
class Total {
  @HiveField(0)
  int positions;

  Total({
    required this.positions,
  });
}
