import 'package:bip39_mnemonic/bip39_mnemonic.dart';

import 'package:flutter/material.dart';

import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

import 'create_wallet.dart';

abstract class CreateWalletBloc extends State<CreateWalletScreen> {
  final SettingsService _settingsService = SettingsService();

  Rv<int> loading = Rv(0);
  bool isInit = false;

  Mnemonic? mnemonic;

  String r = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {
    mnemonic = Mnemonic.generate(
      Language.english,
      passphrase: "Something",
      entropyLength: 128,
    );

    loading.value += 1;
    await AppData.utils.importData(
      public: mnemonic!.sentence,
      isNew: true,
      putPrivateKey: true,
    );
    loading.value += 1;

    _settingsService.putMnemonicSentence(mnemonic!.sentence);
    print(
        "_settingsService.getMnemonicSentence() ${_settingsService.getMnemonicSentence()}");
    loading.value += 1;
  }
}
