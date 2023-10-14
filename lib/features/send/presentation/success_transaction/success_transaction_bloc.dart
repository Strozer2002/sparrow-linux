import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';

import 'succes_transaction.dart';

abstract class SuccessTransactionBloc extends State<SuccessTransaction> {
  final SettingsService settingsService = SettingsService();
  bool isSent = false;
  String? errorText;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    if (mounted) {
      if (settingsService.getConfirmTransaction()!) {
        final result =
            await context.push<bool?>(AppData.routes.codeTransactionScreen);
        if (result == true && mounted) {
          transaction();
        }
      } else {
        transaction();
      }
    }
  }

  Future<void> transaction() async {
    try {
      await widget.createTransaction();
      setState(() {
        isSent = true;
      });
    } catch (e) {
      setState(() {
        errorText = e.toString();
      });
      print(e);
    }
  }
}
