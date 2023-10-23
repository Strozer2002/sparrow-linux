import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';
import '../../../settings/domain/settings_service.dart';

import 'import_seed_phrase.dart';

abstract class ImportSeedPhraseBloc extends State<ImportSeedPhrase> {
  final SettingsService _settingsService = SettingsService();

  final TextEditingController phraseController = TextEditingController();
  List<String>? mnemonicList;
  int mnemonicCount = 12;
  List<int> possibleCount = [12, 15, 18, 21, 24];
  bool isSubmit = false;
  bool isLoading = false;
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

  Future<void> next() async {
    setState(() {
      isLoading = true;
    });
    await AppData.utils.importData(
      public: phraseController.text,
      isNew: false,
      putPrivateKey: true,
    );
    _settingsService.putMnemonicSentence(phraseController.text);
    if (mounted) {
      context.push(AppData.routes.importAddress);
    }
    setState(() {
      isLoading = false;
    });
  }
}
