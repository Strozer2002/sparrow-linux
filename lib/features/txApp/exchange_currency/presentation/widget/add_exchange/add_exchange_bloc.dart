import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/services/exchange_currency_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/presentation/widget/add_exchange/add_exchange.dart';
import 'package:sparrow/features/txApp/exchange_currency/repository/exchange_repository.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class AddExchangeBloc extends State<AddExchange> {
  // Page variables
  final CurrencyService currencyService = CurrencyService.instance;
  final ExchangeCurrencyService exchangeCurrencyService =
      ExchangeCurrencyService();

  final Services services = Services();
  final TextEditingController amountCtrlFrom = TextEditingController();
  final TextEditingController amountCtrlInto = TextEditingController();

  Rv<List<Currency>?> currencies = Rv(null);
  Rv<Currency?> newCurrencyFrom = Rv(null);
  Rv<Currency?> newCurrencyInto = Rv(null);

  // .................

  //Page Methods

  //..........

  // Page settings
  bool get isValidForm {
    return newCurrencyFrom.value == null ||
        newCurrencyInto.value == null ||
        amountCtrlFrom.text.isEmpty ||
        amountCtrlInto.text.isEmpty;
  }

  String get amountAllow =>
      r'([+-]?(?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))?';

  //........................

  // Interaction with object
  void restoreVar() {
    newCurrencyFrom.value = null;
    newCurrencyInto.value = null;
    amountCtrlFrom.text = "";
    amountCtrlInto.text = "";
  }

  Future<void> Function()? onCreateExchange() {
    return isValidForm
        ? null
        : () async {
            final Connectivity connectivity = Connectivity();
            final connectivityResult = await connectivity.checkConnectivity();
            final list =
                await exchangeCurrencyService.getExchangeCurrencyList();

            ExchangeCurrency exchange = ExchangeCurrency(
              id: list.isEmpty ? 0 : list.last.id + 1,
              currencyFrom: newCurrencyFrom.value!,
              currencyInto: newCurrencyInto.value!,
              amountFrom: amountCtrlFrom.text.isNotEmpty
                  ? double.parse(amountCtrlFrom.text)
                  : 0,
              amountInto: amountCtrlInto.text.isNotEmpty
                  ? double.parse(amountCtrlInto.text)
                  : 0,
              isSyncOrDelete: false,
            );
            await widget.onAdd?.call(exchange);
            if (connectivityResult != ConnectivityResult.none) {
              final ExchangeRepository exchangeRepository =
                  ExchangeRepository();
              final result = await exchangeRepository.addExchange(
                id: exchange.id,
                amountFrom: exchange.amountFrom,
                amountInto: exchange.amountInto,
                currencyFrom: exchange.currencyFrom.name,
                currencyInto: exchange.currencyInto.name,
              );
              if (result.isSuccess) {
                exchange.isSyncOrDelete = true;
                await exchangeCurrencyService.updateExchange(exchange);
              } else {
                await services.check();
              }
            } else {
              await services.check();
            }

            restoreVar();
            if (mounted) {
              context.pop();
            }
          };
  }

  // ..................
}
