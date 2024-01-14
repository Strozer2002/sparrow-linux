import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/auth/presentation/welcome/welcome.dart';

abstract class WelcomeBloc extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  // selected screen (0,3)
  int selectedScreen = 0;

  // width for topNavigation
  bool isSwitch = false;
  // logic for screens
  void goNextScreen() {
    setState(() {
      selectedScreen = selectedScreen + 1;
    });
  }

  void goBackScreen() {
    setState(() {
      selectedScreen = selectedScreen - 1;
    });
  }

  // logic for wallets
  void toCreateNewAddress() =>
      context.push(AppData.routes.createWalletScreenScreen);
}
