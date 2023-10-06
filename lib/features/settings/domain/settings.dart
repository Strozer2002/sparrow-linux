import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 9)
class Settings {
  @HiveField(0)
  String? mnemonicSentence;

  @HiveField(1)
  String? userPassCode;

  @HiveField(2)
  bool? isAutoLock;

  @HiveField(3)
  int? autoLockDuration;

  Settings({
    this.isAutoLock = false,
    this.mnemonicSentence,
    this.userPassCode,
    this.autoLockDuration = 30,
  });
}
