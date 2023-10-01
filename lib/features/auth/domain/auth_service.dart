import 'package:get_it/get_it.dart';
import 'package:reactive_variables/reactive_variables.dart';

import 'models/auth_credentials.dart';

class AuthService {
  static final AuthService instance =
      GetIt.I.registerSingleton(AuthService._());

  final Rv<AuthCredentials?> authCreds = Rv(null)
    ..listen((value) {
      print('token: ${value?.token}');
      print('role: ${value?.role}');
      print('subdomain: ${value?.subdomain}');
    });

  bool get isLoggedIn => authCreds() != null;

  AuthService._();

  factory AuthService() => instance;
}
