import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rabby/features/auth/adapters/user.dart';

import 'app_data/app_data.dart';
import 'features/localization/domain/base/app_locale.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('user');
  // box.clear();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      startLocale: AppLocale(
        langCode: 'en',
        title: 'English',
        translatedTitle: () => 'english'.tr(),
      ),
      useOnlyLangCode: true,
      supportedLocales: [
        AppLocale(
          langCode: 'en',
          title: 'English',
          translatedTitle: () => 'english'.tr(),
        ),
        AppLocale(
          langCode: 'ru',
          title: 'Русский',
          translatedTitle: () => 'russian'.tr(),
        ),
      ],
      fallbackLocale: AppLocale(
        langCode: 'en',
        title: 'English',
        translatedTitle: () => 'english'.tr(),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: AppData.routesConfig.routerConfig,
      title: 'Flutter Demo',
      theme: AppData.theme.themeData(context),
    );
  }
}
