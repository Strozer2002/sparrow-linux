
import 'package:flutter/material.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';
import 'package:rabby/features/home/domain/home_screen_enum.dart';
import 'package:rabby/features/home/domain/wallet_type_enum.dart';
import 'package:reactive_variables/reactive_variables.dart';


import '../../auth/domain/adapters/transaction.dart';
import '../../dashboard/domain/dashboard_service.dart';
import 'home_screen.dart';

abstract class HomeBloc extends State<HomeScreen> {
  final dashboardService = DashboardService.instance;
  final AuthService authService = AuthService();
  Rv<HomeScreenEnum> selectedScreen = Rv(HomeScreenEnum.wallet);
  Rv<WalletTypeEnum> selectedWalletType = Rv(WalletTypeEnum.send);
  List<Crypt> crypts = [];

  int transactionsLength = 0;

  @override
  void initState() {
    setState(() {
      if (authService.getTrueCrypts() != null) {
        crypts = authService.getTrueCrypts()!;

        print(crypts.length);
      }
      if (authService.getTransactions() != null) {
        transactionsLength = authService.getTransactions()!.length;
      }
    });

    super.initState();
  }

  Widget operationType({
    required Transaction transaction,
    required Widget send,
    required Widget receive,
    required Widget swap,
  }) {
    switch (transaction.operationType) {
      case "send":
        return send;

      case "receive":
        return receive;
      case "swap":
        return swap;

      default:
        return send;
    }
  }

  String operationTypeString({
    required Transaction transaction,
    required String send,
    required String receive,
    required String swap,
  }) {
    switch (transaction.operationType) {
      case "send":
        return send;

      case "receive":
        return receive;
      case "swap":
        return swap;

      default:
        return send;
    }
  }
}
