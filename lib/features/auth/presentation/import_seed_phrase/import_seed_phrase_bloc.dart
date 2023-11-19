import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';
import '../../../settings/domain/settings_service.dart';

import 'import_seed_phrase.dart';

abstract class ImportSeedPhraseBloc extends State<ImportSeedPhrase> {
  final SettingsService _settingsService = SettingsService();

  final TextEditingController phraseController = TextEditingController();
  int mnemonicCount = 12;
  List<String> mnemonicList = List.filled(12, "");
  List<TextEditingController> controllers = List.generate(
      12,
      (index) => TextEditingController(),
    );
  List<int> possibleCount = [12, 15, 18, 21, 24];
  bool isLoading = false;
  void onClear() {
    setState(() {
      phraseController.text = "";
      mnemonicList = List.filled(mnemonicCount, "");
      controllers =  List.generate(
      mnemonicCount,
      (index) => TextEditingController(),
    );
    });
  }

  void onSubmitted(String value) {
    setState(() {
      mnemonicList = phraseController.text.split(' ');
    });
  }

  Future<void> next() async {
    setState(() {
      isLoading = true;
      phraseController.text = mnemonicList.join(' ');
      print(phraseController.text);
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
