import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/services/exchange_currency_service.dart';
import 'package:sparrow/features/txApp/operation/domain/services/operation_service.dart';
import 'package:sparrow/features/txApp/settings/domain/services/settings_service.dart';

class Data {
  final ExchangeCurrencyService exchange = ExchangeCurrencyService.instance;
  final SettingsTxAppService settings = SettingsTxAppService.instance;
  final CurrencyService currency = CurrencyService.instance;
  final CategoryService category = CategoryService.instance;
  final BankAccountService bankAccount = BankAccountService.instance;
  final OperationService operation = OperationService.instance;

  Data();
}
