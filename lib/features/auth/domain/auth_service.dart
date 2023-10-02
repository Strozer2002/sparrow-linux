import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rabby/features/auth/adapters/user.dart';
import 'package:reactive_variables/reactive_variables.dart';

import 'models/auth_credentials.dart';

class AuthService {
  static final AuthService instance =
      GetIt.I.registerSingleton(AuthService._());
  Box<User>? box;

  final Rv<AuthCredentials?> authCreds = Rv(null)
    ..listen((value) {
      print('address: ${value?.address}');
    });

  bool get isLoggedIn => authCreds() != null;

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
