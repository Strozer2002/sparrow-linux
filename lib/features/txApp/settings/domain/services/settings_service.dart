import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/screen_name_enum.dart';
import 'package:sparrow/features/txApp/settings/domain/models/settings.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/week_day_enum.dart';

class SettingsTxAppService {
  static SettingsTxAppService instance = GetIt.I.get<SettingsTxAppService>();
  final CurrencyService currencyService = CurrencyService.instance;
  final String _boxName = 'settingsTxApp';

  late Box<SettingsTxApp> settingsBox;
  late Future<void> ready;

  bool _isRelocate = false;
  final List<Function(bool)> _listeners = [];

  set isRelocate(bool newValue) {
    _isRelocate = newValue;
    print("isRelocate $_isRelocate");
    _notifyListeners(newValue);
  }

  bool get isRelocate => _isRelocate;

  void addListener(Function(bool) listener) {
    _listeners.add(listener);
  }

  void removeListener(Function(bool) listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners(bool value) {
    for (var listener in _listeners) {
      listener(value);
    }
  }

  void relocate() {
    if (isRelocate == true) {
      print("Relocate resume");
      isRelocate = false;
      AppData.routesConfig.routerConfig.go(AppData.routes.pincodeScreen);
    }
  }

  Future<void> lockApp(bool value) async {
    print("Relocate $value");
    final result = await getPassword();
    if (value == true) {
      Future.delayed(const Duration(seconds: 10), () {
        print("Try to relocate...");
        if (result != null && isRelocate == true) {
          print("Relocate with 2 min");
          isRelocate = false;
          AppData.routesConfig.routerConfig.go(AppData.routes.pincodeScreen);
        }
      });
    }
  }

  SettingsTxAppService() {
    ready = _initAsync();
  }

  Future<void> _initAsync() async => settingsBox = Hive.isBoxOpen(_boxName)
      ? Hive.box<SettingsTxApp>(_boxName)
      : await Hive.openBox<SettingsTxApp>(_boxName);

  Future<SettingsTxApp?> _firstAddSettings() async {
    await ready;
    SettingsTxApp settings = SettingsTxApp(
      mainCurrency: await currencyService.getFirstCurrency(),
      mainScreen: ScreensName.bankAccount,
      password: null,
      mainDay: WeekDay.monday,
    );
    await settingsBox.put(_boxName, settings);
    return settingsBox.get(_boxName);
  }

  Future<SettingsTxApp?> _openSettings() async {
    SettingsTxApp? settings = settingsBox.get(_boxName);
    settings ??= await _firstAddSettings();
    return settings;
  }

  Future<SettingsTxApp?> getSettings() async {
    await ready;
    _openSettings();
    return settingsBox.get(_boxName);
  }

  Future<void> updateMainCurrency(Currency mainCurrency) async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    settings!.mainCurrency = mainCurrency;
    settingsBox.put(_boxName, settings);
  }

  Future<Currency> getMainCurrency() async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    return settings!.mainCurrency;
  }

  Future<void> updateMainScreen(ScreensName mainScreen) async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    settings!.mainScreen = mainScreen;
    settingsBox.put(_boxName, settings);
  }

  Future<ScreensName> getMainScreen() async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    return settings!.mainScreen;
  }

  Future<void> addPassword(String newPassword) async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    settings!.password = newPassword;
    settingsBox.put(_boxName, settings);
  }

  Future<String?> getPassword() async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    if (settings != null && settings.password != null) {
      return settings.password;
    }
    return null;
  }

  Future<void> deletePassword() async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    settings!.password = null;
    settingsBox.put(_boxName, settings);
  }

  Future<bool> isActivatePassword() async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    if (settings != null && settings.password != null) {
      return true;
    }
    return false;
  }

  Future<void> updateWeekDay(WeekDay mainDay) async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    settings!.mainDay = mainDay;
    settingsBox.put(_boxName, settings);
  }

  Future<WeekDay> getWeekDay() async {
    await ready;
    SettingsTxApp? settings = await _openSettings();
    return settings!.mainDay;
  }
}
