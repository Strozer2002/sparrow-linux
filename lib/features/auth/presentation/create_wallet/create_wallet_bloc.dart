import 'dart:io';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/auth/domain/auth_service.dart';
import 'package:sparrow/features/currency/domain/custom_currency.dart';
import 'package:sparrow/features/settings/domain/settings_service.dart';

import 'create_wallet.dart';

abstract class CreateWalletBloc extends State<CreateWalletScreen> {
  final SettingsService _settingsService = SettingsService();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  bool isGeneral = true;
  Mnemonic? mnemonic;

  String r = '';

  String displayUnit = 'Auto';
  List<String> displayUnitItems = [
    'Auto',
    'Option 2',
    'Option 3',
  ];

  String feeRates = 'mempool.space';
  List<String> feeRatesItems = [
    'mempool.space',
    'Option 2',
    'Option 3',
  ];

  CustomCurrency? currency;
  List<CustomCurrency> currencyItems = [];

  String exchange = 'Coingecko';
  List<String> exchangeItems = [
    'Coingecko',
    'Option 2',
    'Option 3',
  ];

  bool isWalletLoad = true;
  bool isWalletValidate = true;
  bool isCoinGroup = true;
  bool isCoinAllow = true;
  bool isNewTx = true;
  bool isSoftware = true;

  bool? isPublic;

  String url = 'bitcoin.lukechilds.co';
  List<String> urlItems = [
    'bitcoin.lukechilds.co',
    'Option 2',
    'Option 3',
  ];
  bool useProxy = false;

  @override
  void initState() {
    initCurrencies();
    super.initState();
  }

  Future<void> initCurrencies() async {
    Map<String, dynamic> rates = await AppData.utils.getExchangeRates("USD");
    int rateUSD = rates['rates']["USD"];
    double rateEUR = rates['rates']["EUR"];
    double rateCNY = rates['rates']["CNY"];
    double rateJPY = rates['rates']["JPY"];
    double rateHKD = rates['rates']["HKD"];

    currencyItems.addAll([
      CustomCurrency(
        name: "USD",
        rate: rateUSD.toDouble(),
        symbol: "\$",
        isChoose: true,
      ),
      CustomCurrency(
        name: "EUR",
        rate: rateEUR,
        symbol: "€",
      ),
      CustomCurrency(
        name: "CNY",
        rate: rateCNY,
        symbol: "¥",
      ),
      CustomCurrency(
        name: "JPY",
        rate: rateJPY,
        symbol: "JP¥",
      ),
      CustomCurrency(
        name: "HKD",
        rate: rateHKD,
        symbol: "HK\$",
      ),
    ]);

    setState(() {
      currency = currencyItems[0];
    });
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });

    mnemonic = Mnemonic.generate(
      Language.english,
      passphrase: "Something",
      entropyLength: 128,
    );

    await AppData.utils.importData(
      public: mnemonic!.sentence,
      isNew: true,
    );

    _settingsService.putMnemonicSentence(mnemonic!.sentence);
    print(
        "_settingsService.getMnemonicSentence() ${_settingsService.getMnemonicSentence()}");

    if (mounted) {
      context.go(AppData.routes.homeScreen);
    }
    setState(() {
      isLoading = false;
    });
  }
}
