import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/models/update_account/update_account.dart';
import 'package:sparrow/features/txApp/bank_account/repository/bank_account_repository.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class UpdateAccountBloc extends State<UpdateAccount> {
  // Page variables
  final CurrencyService currencyService = CurrencyService.instance;
  final BankAccountService accountService = BankAccountService.instance;
  final Connectivity _connectivity = Connectivity();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();

  Rv<List<Currency>?> currencies = Rv(null);
  Rv<Currency?> newCurrency = Rv(null);

  Rv<Color> color = Rv(Colors.red);
  Rv<Icon?> icon = Rv(null);
  // .............
  // Initialize
  @override
  void initState() {
    super.initState();
    initVar();
  }

  Future<void> initVar() async {
    nameCtrl.text = widget.account.name;
    newCurrency.value = widget.account.currency;
    color.value = Color(widget.account.color);
    icon.value = Icon(
      IconData(
        widget.account.icon,
        fontFamily: 'MaterialIcons',
      ),
      color: Colors.white,
    );
    amountCtrl.text = widget.account.amount.toString();
  }

  //...........

  pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);
    this.icon.value = Icon(icon);

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

  Future<void> Function()? onUpdateAccount() {
    return isValidForm
        ? null
        : () async {
            final connectivityResult = await _connectivity.checkConnectivity();
            BankAccount account = BankAccount(
              id: widget.account.id,
              name: nameCtrl.text,
              currency: newCurrency.value!,
              color: color.value.value,
              icon: icon.value!.icon!.codePoint,
              amount: amountCtrl.text.isNotEmpty
                  ? double.parse(amountCtrl.text)
                  : 0,
              isSyncOrDelete: false,
            );
            await widget.onChange?.call(account);
            if (connectivityResult != ConnectivityResult.none) {
              final BankAccountRepository bankAccountRepository =
                  BankAccountRepository();
              final result = await bankAccountRepository.updateBankAccount(
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
            if (mounted) {
              context.pop();
            }
          };
  }

  // ..................
}
