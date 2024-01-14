import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/category/domain/models/category_enum.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/services/exchange_currency_service.dart';
import 'package:sparrow/features/txApp/operation/domain/models/operation.dart';
import 'package:sparrow/features/txApp/operation/repository/operation_repository.dart';

class DeleteOperation extends StatefulWidget {
  final Operation operation;
  final FutureOr<void> Function(Operation operation)? onDelete;
  final FutureOr<void> Function(Operation operation)? onUpdate;
  const DeleteOperation({
    super.key,
    required this.operation,
    this.onDelete,
    this.onUpdate,
  });

  @override
  State<DeleteOperation> createState() => _DeleteOperationState();
}

class _DeleteOperationState extends State<DeleteOperation> {
  final CategoryService categoryService = CategoryService.instance;
  final BankAccountService accountService = BankAccountService.instance;
  final OperationRepository operationRepository = OperationRepository();
  final Connectivity _connectivity = Connectivity();

  Future<void> deleteOperation() async {
    double exchangeAmount = 0;

    //Eсли одинаковые валюты
    if (widget.operation.bankAccount.currency.name ==
        widget.operation.category.currency.name) {
      exchangeAmount = widget.operation.amount;
      // Если расход то снимаем со счета
      if (widget.operation.category.type == CategoryType.expense) {
        widget.operation.bankAccount.amount += exchangeAmount;

        await accountService.updateAccount(widget.operation.bankAccount);
      }
      // Если доход то ставим на счет
      else if (widget.operation.category.type == CategoryType.income) {
        widget.operation.bankAccount.amount -= exchangeAmount;
        await accountService.updateAccount(widget.operation.bankAccount);
      }
      // В любом случае добавляем к категории
      widget.operation.category.amount -= exchangeAmount;
      await categoryService.updateCategory(widget.operation.category);

      // Удаляем операцию
      await widget.onDelete?.call(widget.operation);
      if (mounted) {
        context.pop();
      }
      return;
    }
    // .....
    // Если валюты разные
    else {
      final ExchangeCurrencyService exchangeCurrencyService =
          ExchangeCurrencyService.instance;
      List<ExchangeCurrency> exchanges =
          await exchangeCurrencyService.getExchangeCurrencyList();

      ExchangeCurrency? fromToInto;
      for (ExchangeCurrency object in exchanges) {
        if (object.currencyFrom.name.toString() ==
                widget.operation.bankAccount.currency.name.toString() &&
            object.currencyInto.name.toString() ==
                widget.operation.category.currency.name.toString()) {
          fromToInto = object;
          break;
        }
      }
      //  Если курс совпал с операцией
      if (fromToInto != null) {
        exchangeAmount = widget.operation.amount /
            (fromToInto.amountFrom / fromToInto.amountInto);

        print(
            "from to into = ${fromToInto.amountFrom}    ${fromToInto.amountInto}");
        // Если расход то ставим на  счет
        if (widget.operation.category.type == CategoryType.expense) {
          widget.operation.bankAccount.amount += widget.operation.amount;

          await accountService.updateAccount(widget.operation.bankAccount);
        }
        // Если доход то снимаем со счета
        else if (widget.operation.category.type == CategoryType.income) {
          widget.operation.bankAccount.amount -= widget.operation.amount;
          await accountService.updateAccount(widget.operation.bankAccount);
        }
        // В любом случае снимаем с категории
        widget.operation.category.amount -= exchangeAmount;
        await categoryService.updateCategory(widget.operation.category);

        // Удаляем операцию
        await widget.onDelete?.call(widget.operation);
        if (mounted) {
          context.pop();
        }
        return;
      }
      ExchangeCurrency? intoToFrom;
      for (ExchangeCurrency object in exchanges) {
        if (object.currencyInto.name.toString() ==
                widget.operation.bankAccount.currency.name.toString() &&
            object.currencyFrom.name.toString() ==
                widget.operation.category.currency.name.toString()) {
          intoToFrom = object;
          break;
        }
      }
      //  Если курс не совпал с операцией
      if (intoToFrom != null) {
        exchangeAmount = widget.operation.amount /
            (intoToFrom.amountInto / intoToFrom.amountFrom);

        print(
            " into to from  =    ${intoToFrom.amountInto}   ${intoToFrom.amountFrom} ");
        // Если расход то ставим на  счет
        if (widget.operation.category.type == CategoryType.expense) {
          widget.operation.bankAccount.amount += widget.operation.amount;

          await accountService.updateAccount(widget.operation.bankAccount);
        }
        // Если доход то снимаем со счета
        else if (widget.operation.category.type == CategoryType.income) {
          widget.operation.bankAccount.amount -= widget.operation.amount;
          await accountService.updateAccount(widget.operation.bankAccount);
        }
        // В любом случае снимаем с категории
        widget.operation.category.amount -= exchangeAmount;
        await categoryService.updateCategory(widget.operation.category);

        // Удаляем операцию
        await widget.onDelete?.call(widget.operation);
        if (mounted) {
          context.pop();
        }
        return;
      } else if (intoToFrom == null && fromToInto == null) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
                "Вы не может произвести операцию, создайте курс валют ${widget.operation.bankAccount.currency.name} : ${widget.operation.category.currency.name}"),
          ),
        );
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Удалить операцию?",
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
                          final result = await operationRepository
                              .deleteOperation(id: widget.operation.id);
                          if (result.isSuccess) {
                            print(result.message);
                          }

                          await deleteOperation();
                        } else {
                          await widget.onUpdate?.call(widget.operation);
                        }
                        final Services services = Services();
                        await services.check();

                        context.pop();
                      },
                      child: const Text("Да"),
                    ),
                    ElevatedButton(
                      style: AppData.theme.button.deleteElevatedButton,
                      onPressed: () {
                        context.pop();
                      },
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
