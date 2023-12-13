import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'base/app_locale.dart';

extension AppLocalizationExt on BuildContext {
  AppLocale get appLocale => locale as AppLocale;

  List<AppLocale> get supportedAppLocales =>
      supportedLocales.map((e) => e as AppLocale).toList();
}
