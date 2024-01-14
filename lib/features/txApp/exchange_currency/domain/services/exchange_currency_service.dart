import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/repository/exchange_repository.dart';

class ExchangeCurrencyService {
  static ExchangeCurrencyService instance =
      GetIt.I.get<ExchangeCurrencyService>();

  final String _boxName = 'exchange_currency';

  late Box<ExchangeCurrency> exchangeCurrencyBox;
  late Future<void> ready;

  ExchangeCurrencyService() {
    ready = _initAsync();
  }

  Future<void> _initAsync() async =>
      exchangeCurrencyBox = Hive.isBoxOpen(_boxName)
          ? Hive.box<ExchangeCurrency>(_boxName)
          : await Hive.openBox<ExchangeCurrency>(_boxName);

  Future<List<ExchangeCurrency>> getExchangeCurrencyList() async {
    await ready;
    return exchangeCurrencyBox.values.toList();
  }

  Future<void> _add(ExchangeCurrency obj) async {
    final ExchangeRepository exchangeRepository = ExchangeRepository();
    final updatedCategory = await exchangeRepository.addExchange(
      id: obj.id,
      amountFrom: obj.amountFrom,
      amountInto: obj.amountInto,
      currencyFrom: obj.currencyFrom.name,
      currencyInto: obj.currencyInto.name,
    );
    if (updatedCategory.isSuccess) {
      print(" updatedCategory.data ${updatedCategory.data}");
      obj.isSyncOrDelete = true;
      await updateExchange(obj);
    }
    final Services services = Services();
    await services.check();
  }

  Future<void> _delete(ExchangeCurrency obj) async {
    final ExchangeRepository exchangeRepository = ExchangeRepository();
    final deletedAccount = await exchangeRepository.deleteExchange(id: obj.id);
    if (deletedAccount.isSuccess) {
      await deleteExchange(obj);
    }
    final Services services = Services();
    await services.check();
  }

  Future<void> updateOrAddInDb() async {
    // Update or add async bank accounts
    var accounts = await getExchangeCurrencyList();
    accounts.where((obj) => obj.isSyncOrDelete == false).forEach(_add);
  }

  Future<void> deleteInDb() async {
    // Delete async bank accounts
    var accounts = await getExchangeCurrencyList();
    accounts.where((obj) => obj.isSyncOrDelete == null).forEach(_delete);
  }

  Future<void> syncWithDatabase() async {
    await ready;
    await updateOrAddInDb();
    await deleteInDb();
    log(" Длина массива ${exchangeCurrencyBox.values.toList().length}");
  }

  Future<void> importFromDb() async {
    await ready;
    exchangeCurrencyBox.clear();
    final ExchangeRepository exchangeRepository = ExchangeRepository();
    final CurrencyService currencyService = CurrencyService();
    final exchanges = await exchangeRepository.getAllExchange();
    if (exchanges.data != null) {
      for (int i = exchanges.data!.first.id;
          i <= exchanges.data!.last.id;
          i++) {
        Currency currencyFrom = await currencyService
            .getCurrencyByName(exchanges.data![i].currencyFrom);
        Currency currencyInto = await currencyService
            .getCurrencyByName(exchanges.data![i].currencyInto);
        await addExchange(
          ExchangeCurrency(
            amountFrom: exchanges.data![i].amountFrom,
            amountInto: exchanges.data![i].amountInto,
            currencyFrom: currencyFrom,
            currencyInto: currencyInto,
            id: exchanges.data![i].id,
            isSyncOrDelete: true,
          ),
        );
      }
    }
    log(" Длина импортированного массива ${exchangeCurrencyBox.values.toList().length}");
  }

  Future<int> getAsyncCount() async {
    await ready;
    int count = 0;
    var accounts = await getExchangeCurrencyList();
    accounts
        .where(
            (obj) => obj.isSyncOrDelete == false || obj.isSyncOrDelete == null)
        .forEach((obj) {
      count++;
    });
    log(" Длина async курсов $count");
    return count;
  }

  Future<void> addExchange(ExchangeCurrency exchangeCurrency) async {
    await ready;
    return exchangeCurrencyBox.put(
      exchangeCurrency.currencyFrom.name + exchangeCurrency.currencyInto.name,
      exchangeCurrency,
    );
  }

  Future<void> updateExchange(ExchangeCurrency exchangeCurrency) async {
    await ready;
    return exchangeCurrencyBox.put(
      exchangeCurrency.currencyFrom.name + exchangeCurrency.currencyInto.name,
      exchangeCurrency,
    );
  }

  Future<void> deleteExchange(ExchangeCurrency exchangeCurrency) async {
    await ready;
    return exchangeCurrencyBox.delete(
      exchangeCurrency.currencyFrom.name + exchangeCurrency.currencyInto.name,
    );
  }
}
