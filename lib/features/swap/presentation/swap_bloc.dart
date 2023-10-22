import 'package:flutter/material.dart';

import '../../../app_data/app_data.dart';
import '../../auth/domain/auth_service.dart';
import '../../auth/presentation/manage_crypt/domain/crypt.dart';
import '../../settings/domain/settings_service.dart';
import 'swap_screen.dart';

abstract class SwapBloc extends State<SwapScreen> {
  final TextEditingController amountFromCtrl = TextEditingController();
  final TextEditingController amountToCtrl = TextEditingController();
  final AuthService authService = AuthService();
  final SettingsService settingsService = SettingsService();

  List<Crypt> fromCrypts = [];
  List<Crypt> toCrypts = [];
  Crypt? chosenFromCrypt;
  Crypt? chosenToCrypt;
  @override
  void initState() {
    setState(() {
      if (authService.getTrueCrypts() != null) {
        fromCrypts = authService.getTrueCrypts()!;
        chosenFromCrypt = fromCrypts[0];
        pickCrypt(chosenFromCrypt!);
      }
    });

    super.initState();
  }

  void pickCrypt(Crypt crypt) {
    setState(() {
      toCrypts = authService.getCryptsByCryptsName(crypt.swapCrypts);
      chosenToCrypt = toCrypts[0];
    });
  }

  Future<void> swap() async {
    await AppData.utils.swapCrypts(
      privateKey: settingsService.getPrivateKey()!,
      fromCrypt: chosenFromCrypt!,
      toCrypt: chosenToCrypt!,
      cryptAmount: double.parse(amountFromCtrl.text),
      makeTransaction: true,
    );
  }
}
