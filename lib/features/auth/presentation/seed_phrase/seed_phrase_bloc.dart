import 'package:flutter/material.dart';

import 'seed_phrase.dart';

abstract class SeedPhraseBloc extends State<SeedPhraseScreen> {
  List<String> mnemonicList = [];

  @override
  void initState() {
    mnemonicList = widget.mnemonic.sentence.split(' ');
    super.initState();
  }
}
