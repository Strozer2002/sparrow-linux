import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/settings/settings_service.dart';
import 'set_code.dart';

abstract class SetCodeBloc extends State<SetCodeScreen> {
  final SettingsService _settingsService = SettingsService();
  final TextEditingController numberText = TextEditingController();

  bool isNotFull() {
    setState(() {});
    return numberText.text.length < 6;
  }

  void goNext() {
    if (isNotFull()) {
      print(numberText.text);
    } else {
      _settingsService.putPassCode(numberText.text);
      print("_authService.getPassCode() ${_settingsService.getPassCode()}");
      context.go(AppData.routes.homeScreen);
    }
  }
}
