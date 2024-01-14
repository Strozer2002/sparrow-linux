import 'package:get_it/get_it.dart';
import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/dashboard/domain/dashboard_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/services/exchange_currency_service.dart';
import 'package:sparrow/features/txApp/operation/domain/services/operation_service.dart';

class Services {
  final _dashboardService = GetIt.I.get<DashboardService>();
  final BankAccountService bankAccountService = BankAccountService();
  final CategoryService categoryService = CategoryService();
  final OperationService operationService = OperationService();
  final ExchangeCurrencyService exchangeCurrencyService =
      ExchangeCurrencyService();

  Future<void> check() async {
    int accounts = await bankAccountService.getAsyncCount();
    int categories = await categoryService.getAsyncCount();
    int operations = await operationService.getAsyncCount();
    int exchanges = await exchangeCurrencyService.getAsyncCount();
    _dashboardService.syncCount.value =
        accounts + categories + operations + exchanges;
  }

  Future<void> onSync() async {
    await bankAccountService.syncWithDatabase();
    await categoryService.syncWithDatabase();
    await operationService.syncWithDatabase();
    await exchangeCurrencyService.syncWithDatabase();
  }

  Future<void> importFromDb() async {
    await bankAccountService.importFromDb();
    await categoryService.importFromDb();
    await operationService.importFromDb();
    await exchangeCurrencyService.importFromDb();
  }
}
