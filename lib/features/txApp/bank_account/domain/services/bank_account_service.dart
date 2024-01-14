import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/repository/bank_account_repository.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';

class BankAccountService {
  static BankAccountService instance = GetIt.I.get<BankAccountService>();
  final CurrencyService currencyService = CurrencyService.instance;
  final String _boxName = 'bank_account';

  late Box<BankAccount> bankAccountBox;
  late Future<void> ready;

  BankAccountService() {
    ready = _initAsync();
  }

  Future<void> _initAsync() async {
    bankAccountBox = Hive.isBoxOpen(_boxName)
        ? Hive.box<BankAccount>(_boxName)
        : await Hive.openBox<BankAccount>(_boxName);

    if (bankAccountBox.isEmpty) {
      // await _firstAddSettings();
    }
  }

  // Future<BankAccount?> _firstAddSettings() async {
  //   BankAccount account = BankAccount(
  //     id:1,
  //     name: "Наличные",
  //     currency: await currencyService.getFirstCurrency(),
  //     color: Colors.black.value,
  //     icon: Icons.account_balance_wallet.codePoint,
  //     amount: 0,
  //   );
  //   await bankAccountBox.put(account.name, account);
  //   return bankAccountBox.get(account.name);
  // }

  Future<List<BankAccount>> getBankAccountList() async {
    await ready;
    // log(" Длина массива ${bankAccountBox.values.toList().length}");
    return bankAccountBox.values.toList();
  }

  Future<List<BankAccount>> getToScreenBankAccountList() async {
    await ready;
    // log(" Длина массива ${bankAccountBox.values.toList().length}");
    return bankAccountBox.values
        .where((element) => element.isSyncOrDelete != null)
        .toList();
  }

  Future<void> _add(BankAccount obj) async {
    final BankAccountRepository bankAccountRepository = BankAccountRepository();
    final updatedAccount = await bankAccountRepository.addBankAccount(
      id: obj.id,
      name: obj.name,
      currency: obj.currency.name,
      icon: obj.icon,
      color: obj.color,
      amount: obj.amount,
    );
    if (updatedAccount.isSuccess) {
      print(" updatedAccount.data ${updatedAccount.data}");
      obj.isSyncOrDelete = true;
      await updateAccount(obj);
    }
    final Services services = Services();
    await services.check();
  }

  Future<void> _delete(BankAccount obj) async {
    final BankAccountRepository bankAccountRepository = BankAccountRepository();
    final deletedAccount =
        await bankAccountRepository.deleteBankAccount(id: obj.id);
    if (deletedAccount.isSuccess) {
      await deleteAccount(obj);
    }
    final Services services = Services();
    await services.check();
  }

  Future<void> updateOrAddInDb() async {
    // Update or add async bank accounts
    var accounts = await getBankAccountList();
    accounts.where((obj) => obj.isSyncOrDelete == false).forEach(_add);
  }

  Future<void> deleteInDb() async {
    // Delete async bank accounts
    var accounts = await getBankAccountList();
    accounts.where((obj) => obj.isSyncOrDelete == null).forEach(_delete);
  }

  Future<void> syncWithDatabase() async {
    await ready;
    await updateOrAddInDb();
    await deleteInDb();
    log(" Длина массива ${bankAccountBox.values.toList().length}");
  }

  Future<void> importFromDb() async {
    await ready;
    bankAccountBox.clear();
    final BankAccountRepository bankAccountRepository = BankAccountRepository();
    final CurrencyService currencyService = CurrencyService();
    final accounts = await bankAccountRepository.getAllBankAccounts();
    if (accounts.data != null) {
      for (int i = accounts.data!.first.id; i <= accounts.data!.last.id; i++) {
        Currency currency =
            await currencyService.getCurrencyByName(accounts.data![i].currency);
        await addAccount(
          BankAccount(
            name: accounts.data![i].name,
            currency: currency,
            color: accounts.data![i].color,
            icon: accounts.data![i].icon,
            amount: accounts.data![i].amount,
            id: accounts.data![i].id,
            isSyncOrDelete: true,
          ),
        );
      }
    }
    log(" Длина импортированного массива ${bankAccountBox.values.toList().length}");
  }

  Future<int> getAsyncCount() async {
    await ready;
    int count = 0;
    var accounts = await getBankAccountList();
    accounts
        .where(
            (obj) => obj.isSyncOrDelete == false || obj.isSyncOrDelete == null)
        .forEach((obj) {
      count++;
    });
    log(" Длина async аккаунтов $count");
    return count;
  }

  Future<List<BankAccount>> getBankAccountListWithoutSync() async {
    await ready;
    for (int i = 0; i < bankAccountBox.values.toList().length; i++) {
      if (bankAccountBox.values.toList()[i].isSyncOrDelete == true) {
        bankAccountBox.values.toList()[i].isSyncOrDelete = false;
        updateAccount(bankAccountBox.values.toList()[i]);
      }
    }
    log(" Длина массива ${bankAccountBox.values.toList().length}");
    return bankAccountBox.values.toList();
  }

  Future<void> addAccount(BankAccount account) async {
    await ready;
    log(" Добавлен аккаунт ${account.id}");
    await bankAccountBox.put(account.id, account);
  }

  Future<void> updateAccount(BankAccount account) async {
    await ready;
    log(" Обновлен аккаунт ${account.id}");
    await bankAccountBox.put(account.id, account);
  }

  Future<BankAccount?> getAccountById(int id) async {
    await ready;
    log(" Взят по id аккаунт $id");
    return bankAccountBox.get(id);
  }

  Future<void> deleteAccount(BankAccount account) async {
    await ready;
    log(" Удален аккаунт ${account.id}");
    await bankAccountBox.delete(account.id);
  }
}
