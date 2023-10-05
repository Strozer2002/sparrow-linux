import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';
import 'package:rabby/features/dashboard/domain/dashboard_service.dart';
import 'package:rabby/features/settings/domain/settings.dart';
import 'package:rabby/features/settings/settings_service.dart';

import 'app_data/app_data.dart';
import 'features/auth/domain/adapters/attributes.dart';
import 'features/auth/domain/adapters/changes.dart';
import 'features/auth/domain/adapters/portfolio.dart';
import 'features/auth/domain/adapters/position_by_chain.dart';
import 'features/auth/domain/adapters/position_by_type.dart';
import 'features/auth/domain/adapters/total.dart';
import 'features/auth/domain/adapters/user.dart';
import 'features/localization/domain/base/app_locale.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PortfolioAdapter());
  Hive.registerAdapter(AttributesAdapter());
  Hive.registerAdapter(PositionByTypeAdapter());
  Hive.registerAdapter(PositionByChainAdapter());
  Hive.registerAdapter(TotalAdapter());
  Hive.registerAdapter(ChangesAdapter());
  Hive.registerAdapter(CryptAdapter());
  Hive.registerAdapter(SettingsAdapter());

  // await Hive.openBox<User>('user');
  // await Hive.openBox<Settings>('settings');
  Box box = await Hive.openBox<User>('user');
  Box box2 = await Hive.openBox<Settings>('settings');
  box.clear();
  box2.clear();
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final SettingsService _settingsService = SettingsService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Обработка изменений состояния жизненного цикла приложения

    switch (state) {
      case AppLifecycleState.resumed:
        print("resume");
        // Приложение в фокусе
        if (_settingsService.getPassCode() != null) {
          AppData.routesConfig.routerConfig.push(AppData.routes.setCode);
        }
        break;
      case AppLifecycleState.inactive:

        // Приложение в неактивном состоянии (например, вызов телефона)
        print("inactive");
        break;
      case AppLifecycleState.paused:
        print("paused");
        // Приложение на паузе
        break;
      case AppLifecycleState.detached:
        print("detached");
        // Приложение отключено от системы
        break;
      case AppLifecycleState.hidden:
        print("hidden");
        break;
    }
  }

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
