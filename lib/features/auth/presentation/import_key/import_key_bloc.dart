import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';

import '../../../../app_data/app_data.dart';

import 'import_key.dart';

abstract class ImportKeyBloc extends State<ImportKey> {
  final SettingsService _settingsService = SettingsService();
  final TextEditingController keyCtrl = TextEditingController();
  bool isLoading = false;
  Future<void> next() async {
    setState(() {
      isLoading = true;
    });
    await AppData.utils.importData(
      public: keyCtrl.text,
      isNew: false,
    );
    _settingsService.putPrivateKey(keyCtrl.text);
    if (mounted) {
      context.push(AppData.routes.importAddress);
    }
    setState(() {
      isLoading = false;
    });
  }
}
