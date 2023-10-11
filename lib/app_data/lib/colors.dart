import 'package:flutter/material.dart';

import '../../features/settings/domain/settings_service.dart';

class ColorsCollection {
  final SettingsService settingsService = SettingsService();
  bool isLightTheme() {
    return settingsService.getTheme() == true;
  }

  /// Цвет фона страниц
  Color get backgroundColor => Colors.white;
  Color get backgroundBlackColor => Colors.black;

  /// Цвет фона страниц, который чуть темнее, чем [backgroundColor]
  Color get lightBackgroundColor => gray6F6;

  /// Цвет текста
  Color get textColor => isLightTheme() ? gray700 : gray100;

  /// Цвет ошибок
  Color get red040 => const Color(0xFFD94040);

  /// Основные цвета
  Color get lightPurple50 => const Color(0xFFAAB5FF);
  Color get lightPurple => const Color(0xFF88ABFF);
  Color get middlePurple => const Color(0xFF7983FF);
  Color get middleDarkPurple => const Color.fromARGB(255, 39, 42, 84);
  Color get sky700 => const Color(0xFF0369A1);
  Color get sky600 => const Color(0xFF0284C7);
  Color get sky200 => const Color(0xFFBAE6FD);
  Color get gray100 => const Color(0xFFF3F4F6);
  Color get gray200 => const Color(0xFFe5e7eb);
  Color get gray300 => const Color(0xFFD1D5DB);
  Color get gray400 => const Color(0xFF9CA3AF);
  Color get gray500 => const Color(0xFF6B7280);
  Color get gray600 => const Color(0xFF4B5563);
  Color get nightBottomNavColor =>
      isLightTheme() ? Colors.white : const Color.fromARGB(255, 42, 61, 100);

  Color get topImageColor =>
      isLightTheme() ? Colors.white : const Color.fromARGB(193, 42, 61, 100);

  Color get appBarColor =>
      isLightTheme() ? middlePurple : const Color.fromARGB(255, 42, 61, 100);

  Color get nightBgColor =>
      isLightTheme() ? gray100 : const Color.fromARGB(255, 27, 41, 65);

  Color get iconColor => isLightTheme() ? Colors.black : Colors.white;

  Color get gray6F6 => const Color(0xFFF6F6F6);
  Color get grayCEE => const Color(0xFFEAECEE);
  Color get gray50 => const Color(0xFFF9FAFB);
  Color get gray700 => const Color(0xFF374151);

  Color get grayEDE => const Color(0xFFDEDEDE);
  Color get gray2D2 => const Color(0xFFD2D2D2);
  Color get gray4A4 => const Color(0xFFA4A4A4);

  Color get green100 => const Color(0xFFDCFCE7);
  Color get green500 => const Color(0xFF22C55E);

  Color get red100 => const Color(0xFFFEE2E2);
  Color get red500 => const Color(0xFFEF4444);
}
