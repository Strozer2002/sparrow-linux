import 'package:flutter/material.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';

import '../../app_data.dart';
import 'lib/box_decoration.dart';
import 'lib/button_theme.dart';
import 'lib/text_theme.dart';

class AppTheme {
  final SettingsService settingsService = SettingsService();
  AppTheme();

  TextThemeCollection get text => TextThemeCollection();

  ButtonThemeCollection get button => ButtonThemeCollection();

  BoxDecorationThemeCollection get boxDecoration =>
      BoxDecorationThemeCollection();

  InputBorder get inputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppData.colors.gray2D2,
        ),
        borderRadius: BorderRadius.circular(4),
      );

  ThemeData themeData(BuildContext context) => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: settingsService.getTheme() == true
            ? AppData.colors.gray100
            : AppData.colors.gray900,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppData.colors.sky600,
          secondary: Colors.white,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: settingsService.getTheme() == true
                  ? AppData.colors.textColor
                  : AppData.colors.whiteTextColor,
              displayColor: AppData.colors.textColor,
              fontFamily: AppData.theme.text.fontFamily,
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppData.theme.button.defaultElevatedButton,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: AppData.theme.button.outlinedButton,
        ),
        textButtonTheme: TextButtonThemeData(
          style: AppData.theme.button.defaultTextButton,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.grey[500],
          selectionColor: Colors.grey[500],
        ),
        appBarTheme: AppBarTheme(
          surfaceTintColor: AppData.colors.backgroundColor,
          backgroundColor: AppData.colors.middlePurple,
          titleTextStyle: AppData.theme.text.s14w700.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: AppData.theme.text.fontFamily,
          ),
        ),
        checkboxTheme: const CheckboxThemeData(
          side: BorderSide(color: Colors.grey),
        ),
      );
}
