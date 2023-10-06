import 'package:flutter/material.dart';

import 'buy_cash.dart';

abstract class BuyCashBloc extends State<BuyCashScreen> {
  final TextEditingController amountCtrl = TextEditingController();
  int max = 1000;
  String errorText = "";
  @override
  void initState() {
    amountCtrl.text += "1";
    amountCtrl.addListener(() {
      setState(() {
        print("Text field value: ${amountCtrl.text}");
        if (amountCtrl.text.isNotEmpty) {
          if (amountCtrl.text == "0") {
            amountCtrl.text = '';
          } else if (int.parse(amountCtrl.text) > max) {
            errorText = "Error message";
          } else {
            errorText = "";
          }
        }
      });
    });
    super.initState();
  }

  void toMax() {
    amountCtrl.text = max.toString();
  }

  bool get isMax {
    if (amountCtrl.text.isNotEmpty && int.parse(amountCtrl.text) == max) {
      return true;
    } else {
      return false;
    }
  }
  // bool isNotFull() {
  //   setState(() {});
  //   return numberText.text.length < 6;
  // }

  // void goNext() {
  //   if (isNotFull()) {
  //     print(numberText.text);
  //   } else {
  //     if (settingsService.getPassCode() == null) {
  //       settingsService.putPassCode(numberText.text);
  //       print("_authService.getPassCode() ${settingsService.getPassCode()}");
  //       context.go(AppData.routes.homeScreen);
  //     } else {
  //       print("_authService.getPassCode() ${settingsService.getPassCode()}");
  //       if (numberText.text == settingsService.getPassCode()!) {
  //         if (context.canPop()) {
  //           context.pop(true);
  //         }
  //       }
  //     }
  //   }
  // }
}
