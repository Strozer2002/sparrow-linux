import 'package:hive/hive.dart';

import '../../auth/presentation/manage_crypt/domain/crypt.dart';

part 'settings.g.dart';

@HiveType(typeId: 9)
class Settings {
  @HiveField(0)
  String? mnemonicSentence;

  @HiveField(2)
  List<Crypt>? crypts;

  @HiveField(3)
  String? userPassCode;

  Settings({
    this.mnemonicSentence,
    this.crypts,
    this.userPassCode,
  });
}
