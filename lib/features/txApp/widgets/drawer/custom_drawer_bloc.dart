import 'package:flutter/material.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/screen_name_enum.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/week_day_enum.dart';
import 'package:sparrow/features/txApp/settings/domain/services/settings_service.dart';
import 'package:sparrow/features/txApp/widgets/drawer/custom_drawer.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class CustomDrawerBloc extends State<CustomDrawer> {
  final SettingsTxAppService settingsService = SettingsTxAppService.instance;
  final CurrencyService currencyService = CurrencyService.instance;

  final TextEditingController passwordController = TextEditingController();

  Rv<String?> mainCurrency = Rv(null);
  Rv<List<Currency>?> currencies = Rv(null);

  Rv<ScreensName?> mainScreenName = Rv(null);

  Rv<bool> isPassword = Rv(false);

  Rv<String?> mainWeekDay = Rv(null);

  @override
  void initState() {
    super.initState();
    (() async {
      mainCurrency.value = await getMainCurrency();
      mainScreenName.value = await getMainScreen();
      isPassword.value = await isActivatePassword();
      mainWeekDay.value = await getMainDay();
    })();
  }

  Future<List<Currency>> getCurrencyList() async {
    List<Currency>? currencies = await currencyService.getCurrencyList();
    return currencies;
  }

  Future<String> getMainCurrency() async {
    Currency mainCurrency = await settingsService.getMainCurrency();
    return mainCurrency.name;
  }

  Future<void> updateMainCurrency(Currency currency) async =>
      await settingsService.updateMainCurrency(currency);

  Future<ScreensName> getMainScreen() async {
    ScreensName mainScreen = await settingsService.getMainScreen();
    return mainScreen;
  }

  Future<void> updateMainScreen(ScreensName screensName) async =>
      await settingsService.updateMainScreen(screensName);

  Future<bool> isActivatePassword() async {
    bool isActivatePassword = await settingsService.isActivatePassword();
    return isActivatePassword;
  }

  Future<void> addPassword(String password) async {
    await settingsService.addPassword(password);
    settingsService.isRelocate = true;
    settingsService.relocate();
    passwordController.text = '';
  }

  Future<void> deletePassword() async {
    await settingsService.deletePassword();
    setState(() {
      settingsService.isRelocate = false;
    });
    passwordController.text = '';
  }

  Future<String> getMainDay() async {
    WeekDay mainDay = await settingsService.getWeekDay();
    return mainDay.toString();
  }

  Future<void> updateMainDay(WeekDay weekDay) async =>
      await settingsService.updateWeekDay(weekDay);
}
