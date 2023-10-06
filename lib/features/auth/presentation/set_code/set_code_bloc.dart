import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/settings/settings_service.dart';
import 'set_code.dart';

abstract class SetCodeBloc extends State<SetCodeScreen> {
  final SettingsService settingsService = SettingsService();
  final TextEditingController numberText = TextEditingController();
  @override
  void initState() {
    numberText.addListener(() {
      setState(() {
        print("Text field value: ${numberText.text}");
      });
    });
    super.initState();
  }

  bool isNotFull() {
    return numberText.value.text.length < 6;
  }

  void goNext() {
    if (isNotFull()) {
      print(numberText.value.text);
    } else {
      if (settingsService.getPassCode() == null) {
        settingsService.putPassCode(numberText.value.text);
        print("_authService.getPassCode() ${settingsService.getPassCode()}");
        context.go(AppData.routes.homeScreen);
      } else {
        print("_authService.getPassCode() ${settingsService.getPassCode()}");
        if (numberText.value.text == settingsService.getPassCode()!) {
          if (context.canPop()) {
            context.pop(true);
          }
        }
      }
    }
  }

  bool checkPassword() {
    if (settingsService.getPassCode() != null) {
      return settingsService.getPassCode()! == numberText.value.text;
    }
    return true;
  }

  String get errorText {
    
    if (numberText.value.text.length == 6) {
      if (!checkPassword()) {
        return "Password uncorrected";
      } else {
        return 'Password corrected';
      }
    } else {
      return ' ';
    }
  }
}
