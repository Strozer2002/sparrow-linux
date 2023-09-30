
import '../base/app_locale.dart';

final class LocalizationService {
  final supportedLocalesList = [
    AppLocale(
      langCode: 'en',
      title: 'English',
      // TODO translate it
      translatedTitle: () => 'English',
    ),
    AppLocale(
      langCode: 'ru',
      title: 'Русский',
      // TODO translate it
      translatedTitle: () => 'Русский',
    ),
  ];

  AppLocale? currentLocale;
}
