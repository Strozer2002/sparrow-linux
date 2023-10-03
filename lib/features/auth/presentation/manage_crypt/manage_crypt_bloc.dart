import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';
import 'package:rabby/features/settings/settings_service.dart';

import 'manage_crypt.dart';

abstract class ManageCryptBloc extends State<ManageCrypt> {
  final SettingsService _settingsService = SettingsService();
  final AuthService _authService = AuthService();
  List<Crypt>? crypts;

  @override
  void initState() {
    crypts = [
      Crypt(
        icon: AppData.assets.image.crypto(
          value: 'arbitrum',
          height: 30,
          width: 30,
        ),
        name: 'arbitrum',
        shortName: 'ARB',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![0].isChoose,
        amount: _authService.getPositionByChain()!.arbitrum,
      ),
      Crypt(
        icon: AppData.assets.svg.crypto(
          value: 'aurora',
          size: 30,
        ),
        name: 'aurora',
        shortName: 'aur',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![1].isChoose,
        amount: _authService.getPositionByChain()!.aurora,
      ),
      Crypt(
        icon: AppData.assets.svg.crypto(
          value: 'avalanche',
          size: 30,
        ),
        name: 'avalanche',
        shortName: 'ava',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![2].isChoose,
        amount: _authService.getPositionByChain()!.avalanche,
      ),
      Crypt(
        icon: AppData.assets.svg.crypto(
          value: 'binance-smart-chain',
          size: 30,
        ),
        name: 'binance-smart-chain',
        shortName: 'bin',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![3].isChoose,
        amount: _authService.getPositionByChain()!.binanceSmartChain,
      ),
      Crypt(
        icon: AppData.assets.svg.crypto(
          value: 'ethereum',
          size: 30,
        ),
        name: 'ethereum',
        shortName: 'eth',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![4].isChoose,
        amount: _authService.getPositionByChain()!.ethereum,
      ),
      Crypt(
        icon: AppData.assets.image.crypto(
          value: 'fantom',
          height: 30,
          width: 30,
        ),
        name: 'fantom',
        shortName: 'fan',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![5].isChoose,
        amount: _authService.getPositionByChain()!.fantom,
      ),
      Crypt(
        icon: AppData.assets.svg.crypto(
          value: 'loopring',
          size: 30,
        ),
        name: 'loopring',
        shortName: 'loop',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![6].isChoose,
        amount: _authService.getPositionByChain()!.loopring,
      ),
      Crypt(
        icon: AppData.assets.image.crypto(
          value: 'optimism',
          height: 30,
          width: 30,
        ),
        name: 'optimism',
        shortName: 'opt',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![7].isChoose,
        amount: _authService.getPositionByChain()!.optimism,
      ),
      Crypt(
        icon: AppData.assets.svg.crypto(
          value: 'polygon',
          size: 30,
        ),
        name: 'polygon',
        shortName: 'pol',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![8].isChoose,
        amount: _authService.getPositionByChain()!.polygon,
      ),
      Crypt(
        icon: AppData.assets.svg.crypto(
          value: 'solana',
          size: 30,
        ),
        name: 'solana',
        shortName: 'sol',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![9].isChoose,
        amount: _authService.getPositionByChain()!.solana,
      ),
      Crypt(
        icon: AppData.assets.image.crypto(
          value: 'xdai',
          height: 30,
          width: 30,
        ),
        name: 'xdai',
        shortName: 'xda',
        isChoose: _settingsService.getCrypt() == null
            ? false
            : _settingsService.getCrypt()![10].isChoose,
        amount: _authService.getPositionByChain()!.xdai,
      ),
    ];

    super.initState();
  }

  void onSave() {
    _settingsService.putCrypts(crypts!);
    if (mounted) {
      context.push(
        AppData.routes.setCodeScreen,
        extra: AppData.routes.createNewAddressScreen,
      );
    }
  }
}
