import 'package:flutter/material.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';
import 'package:rabby/features/home/domain/home_screen_enum.dart';
import 'package:rabby/features/home/domain/wallet_type_enum.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../dashboard/domain/dashboard_service.dart';
import 'home_screen.dart';

abstract class HomeBloc extends State<HomeScreen> {
  final dashboardService = DashboardService.instance;
  final AuthService authService = AuthService();
  Rv<HomeScreenEnum> selectedScreen = Rv(HomeScreenEnum.wallet);
  Rv<WalletTypeEnum> selectedWalletType = Rv(WalletTypeEnum.send);
  List<Crypt> crypts = [];
  int transactionsLength = 20;
  @override
  void initState() {
    setState(() {
      if (authService.getTrueCrypts() != null) {
        crypts = authService.getTrueCrypts()!;
        print(crypts.length);
      }
    });
    super.initState();
  }
}
