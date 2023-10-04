import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/settings/settings_service.dart';

import 'init.dart';

abstract class InitBloc extends State<InitPage> {
  final SettingsService _settingsService = SettingsService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      relocate();
    });
  }

  void relocate() {
    if (mounted) {
      if (_settingsService.getPassCode() == null) {
        context.push(AppData.routes.welcomeScreen);
      } else {
        context.push(AppData.routes.setCode);
      }
    }
  }
}
