import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';
import '../../domain/auth_service.dart';
import 'seed_phrase.dart';

abstract class SeedPhraseBloc extends State<SeedPhraseScreen> {
  final AuthService _authService = AuthService();
  List<String> mnemonicList = [];
  String? mnemonic;

  @override
  void initState() {
    if (_authService.get() != null) {
      mnemonic = _authService.get()?.mnemonicSentence;
      mnemonicList = mnemonic!.split(' ');
    }
    super.initState();
  }

  void next() => context.push(
        AppData.routes.createdSuccessScreen,
        extra: _authService.get()?.address,
      );
}
