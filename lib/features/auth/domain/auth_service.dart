import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'adapters/user.dart';

class AuthService {
  static final AuthService instance =
      GetIt.I.registerSingleton(AuthService._());
  Box<User>? box;


  void put(User user) {
    box!.put('user', user);
  }

  User? get() {
    return box!.get('user');
  }

  AuthService._() {
    box = Hive.box<User>('user');
  }

  factory AuthService() => instance;
}
