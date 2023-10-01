import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app_data/app_data.dart';
import 'set_code.dart';

abstract class SetCodeBloc extends State<SetCodeScreen> {
  final TextEditingController numberText = TextEditingController();

  bool isNotFull() {
    setState(() {});
    return numberText.text.length < 6;
  }

  void goNext() {
    if (isNotFull()) {
      print(numberText.text);
    } else {
      context.push(AppData.routes.createNewAddressScreen);
    }
  }
}
