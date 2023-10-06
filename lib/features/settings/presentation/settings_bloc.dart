import 'package:flutter/material.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';

import 'settings_screen.dart';

abstract class SettingsBloc extends State<SettingsScreen> {
  final SettingsService settingsService = SettingsService();
  int selectedDuration = 0;
  @override
  void initState() {
    selectedDuration = settingsService.getDuration()!;
    super.initState();
  }
}
