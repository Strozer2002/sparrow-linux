import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/account_card/widgets/account_logo.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/models/delete_account/delete_account.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/models/update_account/update_account.dart';

class AccountCard extends StatefulWidget {
  final BankAccount account;
  final FutureOr<void> Function(BankAccount account)? onDelete;
  final FutureOr<void> Function(BankAccount account)? onChange;
  final FutureOr<void> Function(BankAccount account)? onUpdate;
  const AccountCard({
    super.key,
    required this.account,
    this.onDelete,
    this.onChange,
    this.onUpdate,
  });

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppData.colors.sky200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AccountLogo(account: widget.account),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.account.name,
                style: AppData.theme.text.s20w700,
              ),
              Row(
                children: [
                  Text(
                    widget.account.amount.toString(),
                    style: AppData.theme.text.s18w500.copyWith(
                      color: widget.account.amount >= 0
                          ? AppData.colors.green500
                          : AppData.colors.red500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.account.currency.symbol,
                    style: AppData.theme.text.s16w600,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      backgroundColor: Colors.white,
                      title: Text(
                        "Выберете действия",
                        style: AppData.theme.text.s18w700,
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text("Изменить"),
                              UpdateAccount(
                                account: widget.account,
                                onChange: widget.onChange,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Удалить"),
                              DeleteAccount(
                                account: widget.account,
                                onDelete: widget.onDelete,
                                onUpdate: widget.onUpdate,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            },
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
