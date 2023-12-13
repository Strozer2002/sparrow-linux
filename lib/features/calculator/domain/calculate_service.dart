import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rabby/features/calculator/domain/calculate_crypt.dart';
import 'package:rabby/features/calculator/domain/calculate_list.dart';

import '../../auth/repository/auth_repository.dart';

class CalculateService {
  final AuthRepository authRepository = AuthRepository();
  static final CalculateService instance =
      GetIt.I.registerSingleton(CalculateService._());
  Box<CalculateList>? box;

  void boxClear() {
    box!.clear();
  }

  void putCalculateCrypts(CalculateList crypt) {
    box!.put('calculate_list', crypt);
  }

  CalculateList? getCalculateCrypts() {
    if (box!.get('calculate_list') == null) {
      putCalculateCrypts(
        CalculateList(
          calculate: [
            CalculateCrypt(
              name: 'Arbitrum',
              shortName: 'ARB',
            ),
            CalculateCrypt(
              name: 'Aurora',
              shortName: 'AUR',
            ),
            CalculateCrypt(
              name: 'Avalanche',
              shortName: 'AVA',
            ),
            CalculateCrypt(
              name: 'Binance',
              shortName: 'BIN',
            ),
            CalculateCrypt(
              name: 'Ethereum',
              shortName: 'ETH',
            ),
            CalculateCrypt(
              name: 'Fantom',
              shortName: 'FAN',
            ),
            CalculateCrypt(
              name: 'Loopring',
              shortName: 'LOOP',
            ),
            CalculateCrypt(
              name: 'Optimism',
              shortName: 'OPT',
            ),
            CalculateCrypt(
              name: 'Matic Token',
              shortName: 'MATIC',
            ),
            CalculateCrypt(
              name: 'USD Coin',
              shortName: 'USDC',
            ),
            CalculateCrypt(
              name: 'Solana',
              shortName: 'SOL',
            ),
            CalculateCrypt(
              name: 'Xdai',
              shortName: 'XDA',
            ),
          ],
        ),
      );
    }
    return box!.get('calculate_list');
  }

  CalculateList? getFavoriteCalculateCrypts() {
    if (box!.get('calculate_list') == null) {
      putCalculateCrypts(
        CalculateList(
          calculate: [
            CalculateCrypt(
              name: 'Arbitrum',
              shortName: 'ARB',
            ),
            CalculateCrypt(
              name: 'Aurora',
              shortName: 'AUR',
            ),
            CalculateCrypt(
              name: 'Avalanche',
              shortName: 'AVA',
            ),
            CalculateCrypt(
              name: 'Binance',
              shortName: 'BIN',
            ),
            CalculateCrypt(
              name: 'Ethereum',
              shortName: 'ETH',
            ),
            CalculateCrypt(
              name: 'Fantom',
              shortName: 'FAN',
            ),
            CalculateCrypt(
              name: 'Loopring',
              shortName: 'LOOP',
            ),
            CalculateCrypt(
              name: 'Optimism',
              shortName: 'OPT',
            ),
            CalculateCrypt(
              name: 'Matic Token',
              shortName: 'MATIC',
            ),
            CalculateCrypt(
              name: 'USD Coin',
              shortName: 'USDC',
            ),
            CalculateCrypt(
              name: 'Solana',
              shortName: 'SOL',
            ),
            CalculateCrypt(
              name: 'Xdai',
              shortName: 'XDA',
            ),
          ],
        ),
      );
    }
    CalculateList? list = CalculateList(
      calculate: box!
          .get('calculate_list')!
          .calculate
          .where((element) => element.isChoose == true)
          .toList(),
    );
    return list;
  }

  void putCalculateCrypt(CalculateCrypt crypt) {
    CalculateList? crypts = getCalculateCrypts();
    if (crypts != null) {
      crypts.calculate.add(crypt);
      putCalculateCrypts(crypts);
    }
  }

  void updatePriceCalculateCrypt(String name, double price) {
    CalculateList? crypts = getCalculateCrypts();
    if (crypts != null) {
      getCalculateCryptByName(name)?.price = price;
      putCalculateCrypts(crypts);
    }
  }

  void updateChooseCalculateCrypt(String name, bool choose) {
    CalculateList? crypts = getCalculateCrypts();
    if (crypts != null) {
      getCalculateCryptByName(name)?.isChoose = choose;
      putCalculateCrypts(crypts);
    }
  }

  CalculateCrypt? getCalculateCryptByName(String name) {
    CalculateList? crypts = getCalculateCrypts();
    CalculateCrypt? findCrypt;
    if (crypts != null) {
      findCrypt = crypts.calculate.firstWhere((crypt) => crypt.name == name);
    }
    return findCrypt;
  }

  Future<void> updateCryptFromApi({
    required String name,
    required String tokenAddress,
  }) async {
    double price;
    final response = await authRepository.periods(
      tokenAddress,
      "hour",
    );
    if (response.isSuccess) {
      price = response.data!.attributes.stats.last;
    } else {
      price = 0;
    }

    updatePriceCalculateCrypt(name, price);
  }

  // Get crypts
  Future<void> getCrypts() async {
    await updateCryptFromApi(
      name: 'Arbitrum',
      tokenAddress: "0xB50721BCf8d664c30412Cfbc6cf7a15145234ad1",
    );
    await updateCryptFromApi(
      name: 'Aurora',
      tokenAddress: "0xAaAAAA20D9E0e2461697782ef11675f668207961",
    );
    await updateCryptFromApi(
      name: 'Avalanche',
      tokenAddress: "0xAaAAAA20D9E0e2461697782ef11675f668207961",
    );
    await updateCryptFromApi(
      name: 'Binance',
      tokenAddress: "0xAaAAAA20D9E0e2461697782ef11675f668207961",
    );
    await updateCryptFromApi(
      name: 'Ethereum',
      tokenAddress: "0xc0829421C1d260BD3cB3E0F06cfE2D52db2cE315",
    );
    await updateCryptFromApi(
      name: 'Fantom',
      tokenAddress: "0x4E15361FD6b4BB609Fa63C81A2be19d873717870",
    );
    await updateCryptFromApi(
      name: 'Loopring',
      tokenAddress: "0xBBbbCA6A901c926F240b89EacB641d8Aec7AEafD",
    );
    await updateCryptFromApi(
      name: 'Optimism',
      tokenAddress: "0x4200000000000000000000000000000000000042",
    );
    await updateCryptFromApi(
      name: 'Matic Token',
      tokenAddress: "0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0",
    );
    await updateCryptFromApi(
      name: 'USD Coin',
      tokenAddress: "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
    );
    await updateCryptFromApi(
      name: 'Solana',
      tokenAddress: "0xD31a59c85aE9D8edEFeC411D448f90841571b89c",
    );
    await updateCryptFromApi(
      name: 'Xdai',
      tokenAddress: "0x0Ae055097C6d159879521C384F1D2123D1f195e6",
    );
  }

  CalculateService._() {
    box = Hive.box<CalculateList>('calculate_list');
  }

  factory CalculateService() => instance;
}
