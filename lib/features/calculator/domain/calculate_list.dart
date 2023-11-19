import 'package:hive/hive.dart';
import 'package:rabby/features/calculator/domain/calculate_crypt.dart';

part 'calculate_list.g.dart';

@HiveType(typeId: 13)
class CalculateList {
  @HiveField(1)
  List<CalculateCrypt> calculate;

  CalculateList({
    required this.calculate,
  });
}
