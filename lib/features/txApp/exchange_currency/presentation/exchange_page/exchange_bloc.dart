import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/services/exchange_currency_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/presentation/exchange_page/exchange_page.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class ExchangeBloc extends State<ExchangePage> {
  final ExchangeCurrencyService exchangeCurrencyService =
      ExchangeCurrencyService.instance;
  Rv<List<ExchangeCurrency>> tempExchange = Rv([]);

  @override
  void initState() {
    (() async {
      tempExchange.value =
          await exchangeCurrencyService.getExchangeCurrencyList();
    })();
    super.initState();
  }

  // Interaction with object

  FutureOr<void> createExchange(ExchangeCurrency exchangeCurrency) async {
    await exchangeCurrencyService.addExchange(exchangeCurrency);
    tempExchange.value =
        await exchangeCurrencyService.getExchangeCurrencyList();
  }

  FutureOr<void> onUpdateCategory(ExchangeCurrency exchangeCurrency) async {
    exchangeCurrency.isSyncOrDelete = null;
    await exchangeCurrencyService.updateExchange(exchangeCurrency);

    tempExchange.value =
        await exchangeCurrencyService.getExchangeCurrencyList();
  }

  FutureOr<void> updateExchange(ExchangeCurrency exchangeCurrency) async {
    await exchangeCurrencyService.updateExchange(exchangeCurrency);
    if (mounted) {
      context.pop();
    }
    tempExchange.value =
        await exchangeCurrencyService.getExchangeCurrencyList();
  }

  FutureOr<void> deleteExchange(ExchangeCurrency exchangeCurrency) async {
    await exchangeCurrencyService.deleteExchange(exchangeCurrency);
    if (mounted) {
      context.pop();
    }
    tempExchange.value =
        await exchangeCurrencyService.getExchangeCurrencyList();
  }

  //....................

  // Page settings
  String get isEmptyList => "You have not courses";
  //....................
}
