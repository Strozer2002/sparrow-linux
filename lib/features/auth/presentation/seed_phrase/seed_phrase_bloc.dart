import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/settings/settings_service.dart';

import '../../../../app_data/app_data.dart';
import 'seed_phrase.dart';

abstract class SeedPhraseBloc extends State<SeedPhraseScreen> {
  final SettingsService _settingsService = SettingsService();
  List<String> mnemonicList = [];
  String? mnemonic;

  @override
  void initState() {
    if (_settingsService.getSettings() != null) {
      mnemonic = _settingsService.getSettings()?.mnemonicSentence;
      mnemonicList = mnemonic!.split(' ');
    }
    super.initState();
  }

  void next() => context.push(
        AppData.routes.createdSuccessScreen,
      );
}
