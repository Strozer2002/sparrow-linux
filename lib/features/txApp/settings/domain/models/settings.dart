import 'package:hive/hive.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/screen_name_enum.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/week_day_enum.dart';

part 'settings.g.dart';

@HiveType(typeId: 5)
class SettingsTxApp {
  @HiveField(0)
  Currency mainCurrency;
  @HiveField(1)
  ScreensName mainScreen;
  @HiveField(2)
  String? password;
  @HiveField(3)
  WeekDay mainDay;

  SettingsTxApp({
    required this.mainCurrency,
    required this.mainScreen,
    this.password,
    required this.mainDay,
  });
}
