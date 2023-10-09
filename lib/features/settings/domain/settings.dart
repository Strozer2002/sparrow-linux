import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 9)
class Settings {
  @HiveField(0)
  String? mnemonicSentence;

  @HiveField(1)
  String? privateKey;

  @HiveField(2)
  String? userPassCode;

  @HiveField(3)
  bool? isAutoLock;

  @HiveField(4)
  int? autoLockDuration;

  Settings({
    this.isAutoLock = false,
    this.mnemonicSentence,
    this.privateKey,
    this.userPassCode,
    this.autoLockDuration = 30,
  });
}
