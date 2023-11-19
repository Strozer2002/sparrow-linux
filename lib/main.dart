import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rabby/features/auth/domain/adapters/transaction.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';
import 'package:rabby/features/calculator/domain/calculate_crypt.dart';
import 'package:rabby/features/calculator/domain/calculate_list.dart';
import 'package:rabby/features/currency/domain/custom_currency.dart';

import 'package:rabby/features/settings/domain/settings.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';
import 'package:window_size/window_size.dart';

import 'app_data/app_data.dart';
import 'features/auth/domain/adapters/attributes.dart';
import 'features/auth/domain/adapters/changes.dart';
import 'features/auth/domain/adapters/portfolio.dart';
import 'features/auth/domain/adapters/position_by_chain.dart';
import 'features/auth/domain/adapters/position_by_type.dart';
import 'features/auth/domain/adapters/total.dart';
import 'features/auth/domain/adapters/user.dart';
import 'features/localization/domain/base/app_locale.dart';

StreamController<bool> setTheme = StreamController();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Rabby');
    setWindowMaxSize(const Size(500, 1000));
    setWindowMinSize(const Size(400, 900));
  }
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
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(CustomCurrencyAdapter());
  Hive.registerAdapter(CalculateCryptAdapter());
  Hive.registerAdapter(CalculateListAdapter());

  await Hive.openBox<User>('user');
  await Hive.openBox<Settings>('settings');
  await Hive.openBox<CalculateList>('calculate_list');

  // final SettingsService settingsService = SettingsService();
  // settingsService.putPassCode("111111");

  // Box box = await Hive.openBox<User>('user');
  // Box box2 = await Hive.openBox<Settings>('settings');
  // Box box3 = await Hive.openBox<List<CalculateCrypt>>('calculate_list');
  // box.clear();
  // box2.clear();
  // box3.clear();

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
        AppLocale(
          langCode: 'de',
          title: 'Deutsche',
          translatedTitle: () => 'deutsche'.tr(),
        ),
        AppLocale(
          langCode: 'ja',
          title: 'Japanese',
          translatedTitle: () => 'japanese'.tr(),
        ),
        AppLocale(
          langCode: 'zh',
          title: 'Chinese',
          translatedTitle: () => 'chinese'.tr(),
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
  final SettingsService _settingsService = SettingsService.instance;

  @override
  void initState() {
    super.initState();

    _settingsService.addListener(_settingsService.lockApp);

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final SettingsService settingsService = SettingsService();
    super.didChangeAppLifecycleState(state);
    // Обработка изменений состояния жизненного цикла приложения

    switch (state) {
      case AppLifecycleState.resumed:
        print("resume");
        // Приложение в фокусе
        settingsService.mainRelocate();
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
    return StreamBuilder<bool>(
        initialData: true,
        stream: setTheme.stream,
        builder: (context, snapshot) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: AppData.routesConfig.routerConfig,
            title: 'Flutter Demo',
            theme: snapshot.data!
                ? AppData.theme.themeData(context)
                : AppData.theme.themeData(context),
          );
        });
  }
}
