import 'package:flutter/material.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';

import 'manage_crypt.dart';

abstract class ManageCryptBloc extends State<ManageCrypt> {
  List<Crypt> icons = [
    Crypt(
      icon: AppData.assets.image.crypto(
        value: 'arbitrum',
        height: 30,
        width: 30,
      ),
      name: 'arbitrum',
      shortName: 'ARB',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.svg.crypto(
        value: 'aurora',
        size: 30,
      ),
      name: 'aurora',
      shortName: 'aur',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.svg.crypto(
        value: 'avalanche',
        size: 30,
      ),
      name: 'avalanche',
      shortName: 'ava',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.svg.crypto(
        value: 'binance-smart-chain',
        size: 30,
      ),
      name: 'binance-smart-chain',
      shortName: 'bin',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.svg.crypto(
        value: 'ethereum',
        size: 30,
      ),
      name: 'ethereum',
      shortName: 'eth',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.image.crypto(
        value: 'fantom',
        height: 30,
        width: 30,
      ),
      name: 'fantom',
      shortName: 'fan',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.svg.crypto(
        value: 'loopring',
        size: 30,
      ),
      name: 'loopring',
      shortName: 'loop',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.image.crypto(
        value: 'optimism',
        height: 30,
        width: 30,
      ),
      name: 'optimism',
      shortName: 'opt',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.svg.crypto(
        value: 'polygon',
        size: 30,
      ),
      name: 'polygon',
      shortName: 'pol',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.svg.crypto(
        value: 'solana',
        size: 30,
      ),
      name: 'solana',
      shortName: 'sol',
      isChoose: false,
    ),
    Crypt(
      icon: AppData.assets.image.crypto(
        value: 'xdai',
        height: 30,
        width: 30,
      ),
      name: 'xdai',
      shortName: 'xda',
      isChoose: false,
    ),
  ];
}
