import 'package:flutter/material.dart';

base class AppLocale extends Locale {
  final String title;
  final String Function() translatedTitle;

  const AppLocale({
    required String langCode,
    String? countryCode,
    required this.title,
    required this.translatedTitle,
  }) : super(langCode, countryCode);
}
