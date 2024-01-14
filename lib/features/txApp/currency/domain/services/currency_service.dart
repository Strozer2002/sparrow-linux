import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';

class CurrencyService {
  static CurrencyService instance = GetIt.I.get<CurrencyService>();

  final String _boxName = 'currency';

  late Box<Currency> currencyBox;
  late Future<void> ready;

  CurrencyService() {
    ready = _initAsync();
  }

  Future<void> _initAsync() async {
    currencyBox = Hive.isBoxOpen(_boxName)
        ? Hive.box<Currency>(_boxName)
        : await Hive.openBox<Currency>(_boxName);

    if (currencyBox.isEmpty) {
      await _initialData();
    }
  }

  Future<void> _initialData() async {
    await currencyBox.add(const Currency(name: "USD", symbol: "\$"));
    await currencyBox.add(const Currency(name: "RUB", symbol: "₽"));
    await currencyBox.add(const Currency(name: "EUR", symbol: "€"));
    await currencyBox.add(const Currency(name: "UAH", symbol: "₴"));
  }

  Future<List<Currency>> getCurrencyList() async {
    await ready;
    return currencyBox.values.toList();
  }

  Future<Currency> getFirstCurrency() async {
    await ready;
    return currencyBox.values.first;
  }

  Future<Currency> getCurrencyByName(String name) async {
    await ready;
    return currencyBox.values.firstWhere((element) => element.name == name);
  }

  Future<void> addCurrency(Currency currency) async {
    await ready;
    await currencyBox.put(currency.name, currency);
  }
}
