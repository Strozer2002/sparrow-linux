import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';

import 'manage_crypt.dart';

abstract class ManageCryptBloc extends State<ManageCrypt> {
  final AuthService _authService = AuthService();
  List<Crypt>? crypts;

  @override
  void initState() {
    crypts = _authService.getPositionByChain()!.crypts;

    super.initState();
  }

  void onSave() {
    _authService.putCrypts(crypts);
    if (mounted) {
      context.push(
        AppData.routes.setCode,
        extra: AppData.routes.createNewAddressScreen,
      );
    }
  }
}
