import 'package:flutter/material.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/send/presentation/transaction/transaction.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';
import 'package:reactive_variables/reactive_variables.dart';
import 'package:web3dart/web3dart.dart';

import '../../../auth/presentation/manage_crypt/domain/crypt.dart';

abstract class TransactionBloc extends State<TransactionWidget> {
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final AuthService authService = AuthService();
  final SettingsService settingsService = SettingsService();
  double gasPrice = 0;
  Crypt? mainCrypt;
  Rv<bool> isStandardTransaction = Rv(true);
  @override
  void initState() {
    super.initState();

    amountCtrl.text = '0';
    addressCtrl.text = widget.extra[0];
    mainCrypt = authService.getCryptByName(widget.extra[1]);
    transform(0.6);
  }

  Future<void> transform(double precent) async {
    EtherAmount? gasPrice = await AppData.utils.getGasPrice(
      walletUrl: mainCrypt!.walletUrl,
    );

    double? amount = await AppData.utils.getGasLimit(
      crypt: mainCrypt!,
      gasPrice: gasPrice!,
      to: EthereumAddress.fromHex(addressCtrl.text),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        AppData.utils.convertEtherToWei(
          (double.parse(amountCtrl.text) /
                  authService.getSelectCurrency()!.rate) /
              mainCrypt!.priceForOne,
        ),
      ),
      precent: precent,
    );
    setState(() {
      this.gasPrice = amount!;
    });
  }

  Future<void> transaction() async {
    await AppData.utils.sendTx(
      privateKey: settingsService.getPrivateKey()!,
      toAddress: addressCtrl.text,
      walletUrl: mainCrypt!.walletUrl,
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        AppData.utils.convertEtherToWei(
          (double.parse(amountCtrl.text) /
                  authService.getSelectCurrency()!.rate) /
              mainCrypt!.priceForOne,
        ),
      ),
      chainId: mainCrypt!.swapId,
    );
  }
}
