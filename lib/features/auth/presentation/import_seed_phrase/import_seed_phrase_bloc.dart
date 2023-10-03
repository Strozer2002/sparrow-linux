import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';
import '../../../settings/settings_service.dart';
import 'import_seed_phrase.dart';

abstract class ImportSeedPhraseBloc extends State<ImportSeedPhrase> {
  final SettingsService _settingsService = SettingsService();
  final TextEditingController phraseController = TextEditingController();
  List<String>? mnemonicList;
  int mnemonicCount = 12;
  List<int> possibleCount = [12, 15, 18, 21, 24];
  bool isSubmit = false;

  void onClear() {
    setState(() {
      phraseController.text = "";
      isSubmit = false;
      mnemonicList = null;
    });
  }

  void onSubmitted(String value) {
    setState(() {
      isSubmit = true;
      mnemonicList = phraseController.text.split(' ');
    });
  }

  void next() {
    String hexSeed = hex.encode(utf8.encode(phraseController.text));
    print(hexSeed);
    print(phraseController.text);
    _settingsService.putHexSeedMnemonic(hexSeed);
    _settingsService.putMnemonicSentence(phraseController.text);
    context.push(AppData.routes.importAddress);
  }
}
