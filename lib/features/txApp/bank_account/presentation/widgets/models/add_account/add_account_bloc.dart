import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/models/add_account/add_account.dart';
import 'package:sparrow/features/txApp/bank_account/repository/bank_account_repository.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class AddAccountBloc extends State<AddAccount> {
  final CurrencyService currencyService = CurrencyService.instance;
  final BankAccountService accountService = BankAccountService.instance;

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();

  Rv<List<Currency>?> currencies = Rv(null);
  Rv<Currency?> newCurrency = Rv(null);

  Rv<Color> color = Rv(Colors.red);
  Rv<Icon?> icon = Rv(null);

  pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    this.icon.value = Icon(icon);
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }

  Future<List<Currency>> getCurrencyList() async {
    List<Currency>? currencyList = await currencyService.getCurrencyList();
    return currencyList;
  }

  // Page settings
  bool get isValidForm {
    return nameCtrl.text == "" ||
        newCurrency.value == null ||
        icon.value == null;
  }

  String get amountAllow =>
      r'([+-]?(?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))?';

  //........................

  // Interaction with object
  void restoreVar() {
    nameCtrl.text = '';
    newCurrency.value = null;
    color.value = Colors.red;
    icon.value = null;
    amountCtrl.text = "";
  }

  Future<void> Function()? onCreateAccount() {
    return isValidForm
        ? null
        : () async {
            final Connectivity connectivity = Connectivity();
            final connectivityResult = await connectivity.checkConnectivity();
            final list = await accountService.getBankAccountList();
            BankAccount account = BankAccount(
              id: list.isEmpty ? 0 : list.last.id + 1,
              name: nameCtrl.text,
              currency: newCurrency.value!,
              color: color.value.value,
              icon: icon.value!.icon!.codePoint,
              amount: amountCtrl.text.isNotEmpty
                  ? double.parse(amountCtrl.text)
                  : 0,
              isSyncOrDelete: false,
            );
            await widget.onAdd?.call(account);
            if (connectivityResult != ConnectivityResult.none) {
              final BankAccountRepository bankAccountRepository =
                  BankAccountRepository();
              final result = await bankAccountRepository.addBankAccount(
                id: account.id,
                name: account.name,
                currency: account.currency.name,
                icon: account.icon,
                color: account.color,
                amount: account.amount,
                description: null,
              );
              if (result.isSuccess) {
                account.isSyncOrDelete = true;
                await accountService.updateAccount(account);
              } else {
                final Services services = Services();
                await services.check();
              }
            } else {
              final Services services = Services();
              await services.check();
            }

            restoreVar();
            if (mounted) {
              context.pop();
            }
          };
  }
}
