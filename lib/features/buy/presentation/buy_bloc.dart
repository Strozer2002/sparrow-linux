import 'package:flutter/material.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';

import '../../auth/presentation/manage_crypt/domain/crypt.dart';
import 'buy_cash.dart';

abstract class BuyCashBloc extends State<BuyCashScreen> {
  final AuthService authService = AuthService();
  final TextEditingController amountCtrl = TextEditingController();
  int max = 0;
  String errorText = "";
  List<Crypt> toCrypts = [];
  Crypt? chosenToCrypt;
  @override
  void initState() {
    setState(() {
      toCrypts = authService.getTrueCrypts()!;
      chosenToCrypt = toCrypts[0];
    });
    max = (authService.getWallet()! * authService.getSelectCurrency()!.rate)
        .toInt();
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
}
