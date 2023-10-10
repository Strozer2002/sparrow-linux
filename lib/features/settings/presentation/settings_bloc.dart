import 'package:flutter/material.dart';
import 'package:rabby/features/app/domain/app_service.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';

import 'settings_screen.dart';

abstract class SettingsBloc extends State<SettingsScreen> {
  final SettingsService settingsService = SettingsService();
  final AuthService authService = AuthService();
  final AppService appService = AppService();
  int selectedDuration = 0;
  @override
  void initState() {
    selectedDuration = settingsService.getDuration()!;
    super.initState();
  }
}
