import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/account/account_page.dart';
import 'package:sparrow/features/txApp/bank_account/repository/bank_account_repository.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class AccountBloc extends State<AccountPage> {
  // Page variables
  final BankAccountService accountService = BankAccountService.instance;
  final BankAccountRepository bankAccountRepository = BankAccountRepository();
  Rv<List<BankAccount>> accounts = Rv([]);
  bool isLoading = true;
  //.....

  // Initialize
  @override
  void initState() {
    super.initState();
    (() async {
      accounts.value = await accountService.getToScreenBankAccountList();
      setState(() {
        isLoading = false;
      });
    })();
  }

  Future<List<BankAccount>> getAccountList() async {
    List<BankAccount>? accountList =
        await accountService.getToScreenBankAccountList();
    return accountList;
  }
  //.......

  //Interaction with objects

  FutureOr<void> onCreateAccount(BankAccount account) async {
    await accountService.addAccount(account);
    accounts.value = await accountService.getToScreenBankAccountList();
  }

  FutureOr<void> onChangeAccount(BankAccount account) async {
    await accountService.updateAccount(account);

    accounts.value = await accountService.getToScreenBankAccountList();
  }

  FutureOr<void> onUpdateAccount(BankAccount account) async {
    account.isSyncOrDelete = null;
    await accountService.updateAccount(account);

    accounts.value = await accountService.getToScreenBankAccountList();
  }

  FutureOr<void> onDeleteAccount(BankAccount account) async {
    await accountService.deleteAccount(account);

    accounts.value = await accountService.getToScreenBankAccountList();
  }
  //..................
}
