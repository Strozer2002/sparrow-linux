import 'package:flutter/material.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';
import 'package:rabby/features/home/domain/home_screen_enum.dart';
import 'package:rabby/features/home/domain/wallet_type_enum.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../auth/domain/adapters/transaction.dart';
import '../../dashboard/domain/dashboard_service.dart';
import 'home_screen.dart';

abstract class HomeBloc extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final dashboardService = DashboardService.instance;
  final AuthService authService = AuthService();
  final SettingsService settingsService = SettingsService();
  Rv<HomeScreenEnum> selectedScreen = Rv(HomeScreenEnum.wallet);
  Rv<WalletTypeEnum> selectedWalletType = Rv(WalletTypeEnum.send);
  List<Crypt> crypts = [];
  bool isReload = false;
  int transactionsLength = 0;


  @override
  void didChangeDependencies() {
    setState(() {
      print("hello");
    });
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    setState(() {
      print("hello");
    });
    super.didUpdateWidget(oldWidget);
  }

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


  Future<void> onReload() async {
    setState(() {
      isReload = true;
      dashboardService.shouldShowBottomBar.value = false;
    });
    await AppData.utils.importData(
      public: settingsService.getPrivateKey()!,
      isNew: false,
    );
    setState(() {
      isReload = false;
      dashboardService.shouldShowBottomBar.value = true;
    });
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
      case "trade":
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
      case "trade":
        return swap;

      default:
        return send;
    }
  }
}
