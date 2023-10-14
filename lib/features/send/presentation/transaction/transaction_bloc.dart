import 'package:flutter/material.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/send/presentation/transaction/transaction.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';
import 'package:reactive_variables/reactive_variables.dart';
import 'package:web3dart/web3dart.dart';

abstract class TransactionBloc extends State<TransactionWidget> {
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final AuthService authService = AuthService();
  final SettingsService settingsService = SettingsService();
  double gasPrice = 0;
  Rv<bool> isStandardTransaction = Rv(true);
  @override
  void initState() {
    super.initState();

    amountCtrl.text = '0';
    addressCtrl.text = widget.address;
  }

  Future<void> transform(double precent) async {
    EtherAmount? gasPrice = await AppData.utils.getGasPrice();

    double? amount = await AppData.utils.getGasLimit(
      gasPrice: gasPrice!,
      to: EthereumAddress.fromHex(addressCtrl.text),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        AppData.utils.convertEtherToWei(
          (double.parse(amountCtrl.text) /
                  authService.getSelectCurrency()!.rate) /
              authService.getETH()!.priceForOne,
        ),
      ),
      precent: precent,
    );
    setState(() {
      this.gasPrice = amount!;
    });
  }

  Future<void> transaction() async {
    EthPrivateKey credentials =
        EthPrivateKey.fromHex(settingsService.getPrivateKey()!);
    final address = credentials.address;
    if (AppData.utils.ethClient != null) {
      await AppData.utils.ethClient!.sendTransaction(
        credentials,
        Transaction(
          from: address,
          to: EthereumAddress.fromHex(addressCtrl.text),
          value: EtherAmount.fromUnitAndValue(
            EtherUnit.wei,
            AppData.utils.convertEtherToWei(
              (double.parse(amountCtrl.text) /
                      authService.getSelectCurrency()!.rate) /
                  authService.getETH()!.priceForOne,
            ),
          ),
        ),
      );
      print("send");
    }
  }
}
