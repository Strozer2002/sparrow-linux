import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';

import 'import_adress.dart';

abstract class ImportAddressBloc extends State<ImportAddress> {
  final AuthService _authService = AuthService();
    
  String get addressString {
    if (_authService.getAddress() != null) {
      return _authService.getAddress()!;
    } else {
      return "";
    }
  }

  void next() => context.push(AppData.routes.manageCryptScreen);
}
