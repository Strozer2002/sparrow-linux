import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';
import 'package:rabby/features/home/domain/home_screen_enum.dart';
import 'package:rabby/features/home/domain/wallet_type_enum.dart';
import 'package:reactive_variables/reactive_variables.dart';
import 'package:http/http.dart' as http;

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
  double result = 0;
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
      init();
    });

    super.initState();
  }

  Future<Map<String, dynamic>> getExchangeRates(String baseCurrency) async {
    var url = Uri.https('api.exchangerate-api.com', '/v4/latest/$baseCurrency',
        {'q': '{https}'});
    log("HTTP");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  Future<void> init() async {
    Map<String, dynamic> rates = await getExchangeRates("USD");
    setState(() {
      result = authService.getWallet()! * rates['rates']["EUR"];
    });
    log("Resault $result");
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
