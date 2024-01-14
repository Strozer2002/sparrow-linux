import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/services/exchange_currency_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/presentation/widget/update_exchange/update_exchange.dart';
import 'package:sparrow/features/txApp/exchange_currency/repository/exchange_repository.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class UpdateExchangeBloc extends State<UpdateExchange> {
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
  // Initialization
  @override
  void initState() {
    super.initState();
    initVar();
  }

  Future<void> initVar() async {
    newCurrencyFrom.value = widget.exchangeCurrency.currencyFrom;
    newCurrencyInto.value = widget.exchangeCurrency.currencyInto;
    amountCtrlFrom.text = widget.exchangeCurrency.amountFrom.toString();
    amountCtrlInto.text = widget.exchangeCurrency.amountInto.toString();
  }
  //........

  // Interaction with object

  Future<void> Function()? onUpdateExchange() {
    return isValidForm
        ? null
        : () async {
            final Connectivity connectivity = Connectivity();
            final connectivityResult = await connectivity.checkConnectivity();
            ExchangeCurrency exchange = ExchangeCurrency(
              id: widget.exchangeCurrency.id,
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
            await widget.onChange?.call(exchange);
            if (connectivityResult != ConnectivityResult.none) {
              final ExchangeRepository exchangeRepository =
                  ExchangeRepository();
              final result = await exchangeRepository.updateExchange(
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
            if (mounted) {
              context.pop();
            }
          };
  }

  // ..................
}
