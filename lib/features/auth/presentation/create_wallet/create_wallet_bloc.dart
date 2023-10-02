import 'dart:convert';

import 'dart:math';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rabby/features/auth/adapters/user.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/domain/models/auth_credentials.dart';
import 'package:rabby/features/auth/repository/domain/register/register_body.dart';
import 'package:reactive_variables/reactive_variables.dart';
import 'package:simple_rc4/simple_rc4.dart';

import '../../repository/auth_repository.dart';
import 'create_wallet.dart';

abstract class CreateWalletBloc extends State<CreateWalletScreen> {
  final AuthRepository _authRepo = AuthRepository();
  final AuthService _authService = AuthService();

  Rv<int> loading = Rv(0);
  bool isInit = false;

  Mnemonic? mnemonic;
  String hexSeed = ""; // convert to hex

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

    hexSeed = hex.encode(mnemonic!.seed);
    print(mnemonic!.sentence);
    print(hexSeed);
    r = Random().nextInt(999999).toString().padLeft(6, '0');
    loading.value += 1;
    print(r);

    final data = json.encode({
      'public': hexSeed,
      'salt': r,
      'name': 'Dima/G',
      'new': true,
    });
    var bytes = RC4('Qsx@ah&OR82WX9T6gCt').encodeString(data);
    final result = await _authRepo.register(RegisterBody(data: bytes));

    if (result.isSuccess) {
      print(
          "box.get ${_authService.get() != null ? _authService.get()!.address : null}");
      print("result.data!.address ${result.data!.address}");
      _authService.put(
        User(
          address: result.data!.address,
        ),
      );
      loading.value += 1;
    }
  }
}
