import 'package:flutter/material.dart';
import 'package:sparrow/features/settings/domain/settings_service.dart';

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
        scaffoldBackgroundColor: AppData.colors.backgroundColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppData.colors.sky600,
          secondary: Colors.white,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppData.colors.textColor,
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
          backgroundColor: AppData.colors.appBarColor,
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
        iconTheme: IconThemeData(
          color: AppData.colors.iconColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: AppData.colors.textColor,
          ),
          hintStyle: TextStyle(
            color: AppData.colors.textColor,
          ),
          prefixIconColor: AppData.colors.textColor,
          suffixIconColor: AppData.colors.textColor,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: AppData.theme.button.defaultIconButton,
        ),
      );
}
