import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';
import 'package:sparrow/features/txApp/category/domain/models/category_enum.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/services/exchange_currency_service.dart';
import 'package:sparrow/features/txApp/operation/domain/models/operation.dart';
import 'package:sparrow/features/txApp/operation/domain/services/operation_service.dart';
import 'package:sparrow/features/txApp/operation/presentation/widget/add_operation/add_operation.dart';
import 'package:sparrow/features/txApp/operation/repository/operation_repository.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class AddOperationBloc extends State<AddOperation> {
  // Page variables
  final CurrencyService currencyService = CurrencyService.instance;
  final CategoryService categoryService = CategoryService.instance;
  final BankAccountService accountService = BankAccountService.instance;
  final OperationService operationService = OperationService.instance;

  final Services services = Services();

  final TextEditingController amountCtrl = TextEditingController();

  Rv<List<Category>?> categories = Rv(null);
  Rv<Category?> newCategory = Rv(null);

  Rv<List<BankAccount>?> accounts = Rv(null);
  Rv<BankAccount?> newAccount = Rv(null);

  Rv<DateTime?> date = Rv(null);

  // .................

  //Page Methods
  Future<void> selectDate(BuildContext context) async {
    date.value = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }
  //..........

  // Page settings
  bool get isValidForm {
    return newAccount.value == null ||
        newCategory.value == null ||
        date.value == null;
  }

  String get amountAllow =>
      r'([+-]?(?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))?';

  //........................

  // Interaction with object
  void restoreVar() {
    newCategory.value = null;
    newAccount.value = null;
    amountCtrl.text = "";
    date.value = null;
  }

  Future<Operation?> addOperation() async {
    final list = await operationService.getOperationList();

    double exchangeAmount = 0;

    //Eсли одинаковые валюты
    if (newAccount.value!.currency.name == newCategory.value!.currency.name) {
      exchangeAmount =
          amountCtrl.text.isNotEmpty ? double.parse(amountCtrl.text) : 0;
      // Если расход то снимаем со счета
      if (newCategory.value!.type == CategoryType.expense) {
        newAccount.value!.amount -= exchangeAmount;
        await accountService.updateAccount(newAccount.value!);
      }
      // Если доход то ставим на счет
      else if (newCategory.value!.type == CategoryType.income) {
        newAccount.value!.amount += exchangeAmount;
        await accountService.updateAccount(newAccount.value!);
      }
      // В любом случае добавляем к категории
      newCategory.value!.amount += exchangeAmount;
      await categoryService.updateCategory(newCategory.value!);

      final operation = Operation(
        id: list.isEmpty ? 0 : list.last.id + 1,
        date: date.value!,
        amount: exchangeAmount,
        category: newCategory.value!,
        bankAccount: newAccount.value!,
        isSyncOrDelete: false,
      );
      // Добавляем операцию
      await widget.onAdd?.call(operation);
      restoreVar();
      if (mounted) {
        context.pop();
      }
      return operation;
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
                newAccount.value!.currency.name.toString() &&
            object.currencyInto.name.toString() ==
                newCategory.value!.currency.name.toString()) {
          fromToInto = object;
          break;
        }
      }
      //  Если курс совпал с операцией
      if (fromToInto != null) {
        exchangeAmount = amountCtrl.text.isNotEmpty
            ? double.parse(amountCtrl.text) /
                (fromToInto.amountFrom / fromToInto.amountInto)
            : 0;
        print("from to into");
        // Если расход то снимаем со счета
        if (newCategory.value!.type == CategoryType.expense) {
          newAccount.value!.amount -=
              amountCtrl.text.isNotEmpty ? double.parse(amountCtrl.text) : 0;
          await accountService.updateAccount(newAccount.value!);
        }
        // Если доход то ставим на счет
        else {
          if (newCategory.value!.type == CategoryType.income) {
            newAccount.value!.amount +=
                amountCtrl.text.isNotEmpty ? double.parse(amountCtrl.text) : 0;
            await accountService.updateAccount(newAccount.value!);
          }
        }
        // В любом случае добавляем к категории
        newCategory.value!.amount += exchangeAmount;
        await categoryService.updateCategory(newCategory.value!);
        // Добавляем операцию
        final operation = Operation(
          id: list.isEmpty ? 0 : list.last.id + 1,
          date: date.value!,
          amount:
              amountCtrl.text.isNotEmpty ? double.parse(amountCtrl.text) : 0,
          category: newCategory.value!,
          bankAccount: newAccount.value!,
          isSyncOrDelete: false,
        );
        await widget.onAdd?.call(operation);
        restoreVar();
        if (mounted) {
          context.pop();
        }
        return operation;
      }
      ExchangeCurrency? intoToFrom;
      for (ExchangeCurrency object in exchanges) {
        if (object.currencyInto.name.toString() ==
                newAccount.value!.currency.name.toString() &&
            object.currencyFrom.name.toString() ==
                newCategory.value!.currency.name.toString()) {
          intoToFrom = object;
          break;
        }
      }
      //  Если курс не совпал с операцией
      if (intoToFrom != null) {
        exchangeAmount = amountCtrl.text.isNotEmpty
            ? double.parse(amountCtrl.text) /
                (intoToFrom.amountInto / intoToFrom.amountFrom)
            : 0;
        print("  into to from");
        // Если расход то снимаем со счета
        if (newCategory.value!.type == CategoryType.expense) {
          newAccount.value!.amount -=
              amountCtrl.text.isNotEmpty ? double.parse(amountCtrl.text) : 0;
          await accountService.updateAccount(newAccount.value!);
        }
        // Если доход то ставим на счет
        else {
          if (newCategory.value!.type == CategoryType.income) {
            newAccount.value!.amount +=
                amountCtrl.text.isNotEmpty ? double.parse(amountCtrl.text) : 0;
            await accountService.updateAccount(newAccount.value!);
          }
        }
        // В любом случае добавляем к категории
        newCategory.value!.amount += exchangeAmount;
        await categoryService.updateCategory(newCategory.value!);

        // Добавляем операцию
        final operation = Operation(
          id: list.isEmpty ? 0 : list.last.id + 1,
          date: date.value!,
          amount:
              amountCtrl.text.isNotEmpty ? double.parse(amountCtrl.text) : 0,
          category: newCategory.value!,
          bankAccount: newAccount.value!,
          isSyncOrDelete: false,
        );
        await widget.onAdd?.call(operation);
        restoreVar();
        if (mounted) {
          context.pop();
        }
        return operation;
      } else if (intoToFrom == null && fromToInto == null) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
                "Вы не может произвести операцию, создайте курс валют ${newAccount.value!.currency.name} : ${newCategory.value!.currency.name}"),
          ),
        );
        return null;
      }
    }
    return null;
  }

  Future<void> Function()? onCreateOperation() {
    return isValidForm
        ? null
        : () async {
            final Connectivity connectivity = Connectivity();
            final connectivityResult = await connectivity.checkConnectivity();
            final Operation? operation = await addOperation();
            if (operation != null) {
              if (connectivityResult != ConnectivityResult.none) {
                final OperationRepository operationRepository =
                    OperationRepository();
                final result = await operationRepository.addOperation(
                  id: operation.id,
                  date: operation.date.toString(),
                  categoryType: operation.category.name,
                  bankAccount: operation.bankAccount.id,
                  amount: operation.amount,
                );
                if (result.isSuccess) {
                  operation.isSyncOrDelete = true;
                  await operationService.updateOperation(operation);
                } else {
                  await services.check();
                }
              } else {
                await services.check();
              }
              restoreVar();
              if (mounted) {
                context.pop();
              }
            }
          };
  }

  // ..................
}
