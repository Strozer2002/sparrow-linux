import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  int? getBalance() {
    User? user = getUser();
    if (user != null) {
      return user.sumBalance;
    }
    return null;
  }

  int? getMem() {
    User? user = getUser();
    if (user != null) {
      return user.sumMem;
    }
    return null;
  }

  int? getTxCount() {
    User? user = getUser();
    if (user != null) {
      return user.txCount;
    }
    return null;
  }

  AuthService._() {
    box = Hive.box<User>('user');
  }

  factory AuthService() => instance;
}
