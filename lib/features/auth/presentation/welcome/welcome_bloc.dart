import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/presentation/welcome/welcome.dart';

abstract class WelcomeBloc extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  // selected screen (0,3)
  int selectedScreen = 0;

  // width for topNavigation
  double pickedWidth = 16;
  double unpickedWidth = 6;

  // logic for screens
  void goNextScreen() {
    setState(() {
      selectedScreen = selectedScreen + 1;
    });
  }

  void toSkipScreens() {
    setState(() {
      selectedScreen = 3;
    });
  }

  // logic for links
  void toManyMore() {
    log("$selectedScreen");
  }

  void toTermsOfUse() {
    log("$selectedScreen");
  }

  // logic for wallets
  void toCreateNewAddress() =>
      context.push(AppData.routes.createWalletScreenScreen);
  void toImportAddress() => context.push(
        AppData.routes.setCodeScreenForImport,
        extra: AppData.routes.selectImport,
      );
}
