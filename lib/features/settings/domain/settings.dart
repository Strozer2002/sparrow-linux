import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 9)
class Settings {
  @HiveField(0)
  String? mnemonicSentence;

  @HiveField(1)
  String? userPassCode;

  Settings({
    this.mnemonicSentence,
    this.userPassCode,
  });
}
