import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/account_card/widgets/account_logo.dart';
import 'package:sparrow/features/txApp/category/presentation/widget/category_card/widgets/category_logo.dart';
import 'package:sparrow/features/txApp/operation/domain/models/operation.dart';
import 'package:sparrow/features/txApp/operation/presentation/widget/delete_operation/delete_operation.dart';
import 'package:sparrow/features/txApp/operation/presentation/widget/update_operation/update_operation.dart';

class OperationCard extends StatefulWidget {
  final Operation operation;
  final FutureOr<void> Function(Operation operation)? onDelete;
  final FutureOr<void> Function(Operation operation)? onChange;
  final FutureOr<void> Function(Operation operation)? onUpdate;
  const OperationCard({
    super.key,
    required this.operation,
    this.onDelete,
    this.onChange,
    this.onUpdate,
  });

  @override
  State<OperationCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: AppData.colors.sky200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    AccountLogo(account: widget.operation.bankAccount),
                    Text(widget.operation.bankAccount.name),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      DateFormat("yMMMMd").format(widget.operation.date),
                    ),
                    Text(
                      "${widget.operation.amount.toString()} ${widget.operation.bankAccount.currency.symbol}",
                    ),
                  ],
                ),
                Column(
                  children: [
                    CategoryLogo(category: widget.operation.category),
                    Text(widget.operation.category.name),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    backgroundColor: Colors.white,
                    title: Text(
                      "Choose method",
                      style: AppData.theme.text.s18w700,
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text("Update"),
                            UpdateOperation(
                              onChange: widget.onChange,
                              operation: widget.operation,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Delete"),
                            DeleteOperation(
                              operation: widget.operation,
                              onDelete: widget.onDelete,
                              onUpdate: widget.onUpdate,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
