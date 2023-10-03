import 'package:hive/hive.dart';

part 'changes.g.dart';

@HiveType(typeId: 7)
class Changes {
  @HiveField(0)
  int absoluteId;

  @HiveField(1)
  int? percentId;
  Changes({
    required this.absoluteId,
    this.percentId,
  });
}
