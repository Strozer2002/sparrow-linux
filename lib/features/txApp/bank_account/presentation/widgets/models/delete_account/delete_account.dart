import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/bank_account/repository/bank_account_repository.dart';

class DeleteAccount extends StatefulWidget {
  final BankAccount account;
  final FutureOr<void> Function(BankAccount account)? onDelete;
  final FutureOr<void> Function(BankAccount account)? onUpdate;
  const DeleteAccount({
    super.key,
    required this.account,
    this.onDelete,
    this.onUpdate,
  });

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final BankAccountService accountService = BankAccountService.instance;
  final BankAccountRepository bankAccountRepository = BankAccountRepository();
  final Connectivity _connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Удалить счет?",
                  style: AppData.theme.text.s18w700,
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: AppData.theme.button.acceptElevatedButton,
                      onPressed: () async {
                        final connectivityResult =
                            await _connectivity.checkConnectivity();
                        if (connectivityResult != ConnectivityResult.none) {
                          final result = await bankAccountRepository
                              .deleteBankAccount(id: widget.account.id);
                          if (result.isSuccess) {
                            print(result.message);
                          }
                          await widget.onDelete?.call(widget.account);
                        } else {
                          await widget.onUpdate?.call(widget.account);
                        }
                        final Services services = Services();
                        await services.check();

                        context.pop();
                      },
                      child: const Text("Да"),
                    ),
                    ElevatedButton(
                      style: AppData.theme.button.deleteElevatedButton,
                      onPressed: () => context.pop(),
                      child: const Text("Нет"),
                    ),
                  ],
                ),
              );
            });
      },
      icon: Icon(
        Icons.delete,
        color: Colors.red.shade300,
      ),
    );
  }
}
