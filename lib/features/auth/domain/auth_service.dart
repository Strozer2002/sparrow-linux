import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rabby/features/auth/domain/adapters/position_by_chain.dart';
import 'package:rabby/features/auth/domain/adapters/transaction.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';

import 'adapters/user.dart';

class AuthService {
  static final AuthService instance =
      GetIt.I.registerSingleton(AuthService._());
  Box<User>? box;

  void boxClear() {
    box!.clear();
  }

  void putUser(User user) {
    box!.put('user', user);
  }

  User? getUser() {
    return box!.get('user');
  }

  void putAddress(String address) {
    User? user = getUser();
    if (user != null) {
      user.address = address;
      putUser(user);
    }
  }

  String? getAddress() {
    User? user = getUser();
    if (user != null) {
      return user.address;
    }
    return null;
  }

  PositionByChain? getPositionByChain() {
    User? user = getUser();
    if (user != null) {
      return user.portfolio.attributes.positionsDistributionByChain;
    }
    return null;
  }

  void putCrypts(List<Crypt>? crypts) {
    User? user = getUser();
    if (user != null) {
      user.portfolio.attributes.positionsDistributionByChain.crypts = crypts!;
      putUser(user);
    }
  }

  Crypt? getCryptByName(String name) {
    User? user = getUser();
    if (user != null) {
      return user.portfolio.attributes.positionsDistributionByChain.crypts
          .firstWhere((crypt) => crypt.name == name);
    }
    return null;
  }

  List<Crypt>? getCrypts() {
    User? user = getUser();
    if (user != null) {
      return user.portfolio.attributes.positionsDistributionByChain.crypts;
    }
    return null;
  }

  List<Crypt>? getTrueCrypts() {
    User? user = getUser();
    if (user != null) {
      return user.portfolio.attributes.positionsDistributionByChain.crypts
          .where((crypt) => crypt.isChoose)
          .toList();
    }
    return null;
  }

  double? getWallet() {
    User? user = getUser();
    if (user != null) {
      return user.portfolio.attributes.positionsDistributionByType.wallet;
    }
    return null;
  }

  double? getChangesAbsoluteWallet() {
    User? user = getUser();
    if (user != null) {
      return user.portfolio.attributes.changes.absoluteId;
    }
    return null;
  }

  List<Transaction>? getTransactions() {
    User? user = getUser();
    if (user != null) {
      return user.transactions;
    }
    return null;
  }

  AuthService._() {
    box = Hive.box<User>('user');
  }

  factory AuthService() => instance;
}
