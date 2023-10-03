import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rabby/features/auth/domain/adapters/position_by_chain.dart';

import '../presentation/manage_crypt/domain/crypt.dart';
import 'adapters/user.dart';

class AuthService {
  static final AuthService instance =
      GetIt.I.registerSingleton(AuthService._());
  Box<User>? box;

  void putUser(User user) {
    box!.put('user', user);
  }

  User? getUser() {
    return box!.get('user');
  }

  PositionByChain? getPositionByChain() {
    User? user = getUser();
    if (user != null) {
      return user.portfolio.attributes.positionsDistributionByChain;
    }
    return null;
  }

  AuthService._() {
    box = Hive.box<User>('user');
  }

  factory AuthService() => instance;
}
