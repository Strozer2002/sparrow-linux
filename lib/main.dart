import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sparrow/features/auth/domain/adapters/transaction.dart';
import 'package:sparrow/features/crypt/domain/crypt.dart';
import 'package:sparrow/features/currency/domain/custom_currency.dart';

import 'package:sparrow/features/settings/domain/settings.dart';
import 'package:sparrow/features/settings/domain/settings_service.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';
import 'package:sparrow/features/txApp/category/domain/models/category_enum.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:sparrow/features/txApp/dashboard/domain/dashboard_service.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/services/exchange_currency_service.dart';
import 'package:sparrow/features/txApp/operation/domain/models/operation.dart';
import 'package:sparrow/features/txApp/operation/domain/services/operation_service.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/screen_name_enum.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/week_day_enum.dart';
import 'package:sparrow/features/txApp/settings/domain/models/settings.dart';
import 'package:sparrow/features/txApp/settings/domain/services/settings_service.dart';
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

// Future<void> getData() async {
//   Firestore.initialize(projectId);
//   var map =
//       await Firestore.instance.collection("price").document('checker').get();
//   print("Value ${map['check']}");

//   if (map['check'] != true) {
//     AppData.routesConfig.init = AppData.routes.init;
//   } else {
//     AppData.routesConfig.init = AppData.routes.bankAccountScreen;
//   }
// }

// const apiKey = "AIzaSyDUHJ0P602HTW9NhcuOt5KwVsiEanP7unM";
// const projectId = "sparrow-pc";
// const messagingSenderId = "174699269079";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     apiKey: apiKey,
  //     appId: projectId,
  //     messagingSenderId: messagingSenderId,
  //     projectId: projectId,
  //   ),
  // );
  // await getData();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Sparrow');
    setWindowMaxSize(const Size(1920, 1080));
    setWindowMinSize(const Size(1029, 740));
  }

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter()); // 10
  Hive.registerAdapter(PortfolioAdapter()); //11
  Hive.registerAdapter(AttributesAdapter()); //12
  Hive.registerAdapter(PositionByTypeAdapter()); //13
  Hive.registerAdapter(PositionByChainAdapter()); //14
  Hive.registerAdapter(TotalAdapter()); //15
  Hive.registerAdapter(ChangesAdapter()); //16
  Hive.registerAdapter(CryptAdapter()); //17
  Hive.registerAdapter(SettingsAdapter()); //18
  Hive.registerAdapter(TransactionAdapter()); //19
  Hive.registerAdapter(CustomCurrencyAdapter()); //20

  Hive.registerAdapter(CurrencyAdapter()); //1
  GetIt.I.registerSingleton(CurrencyService());

  Hive.registerAdapter(SettingsTxAppAdapter()); //5
  GetIt.I.registerSingleton(SettingsTxAppService());

  Hive.registerAdapter(CategoryAdapter()); //2
  GetIt.I.registerSingleton(CategoryService());

  Hive.registerAdapter(CategoryTypeAdapter()); //3

  Hive.registerAdapter(OperationAdapter()); //4
  GetIt.I.registerSingleton(OperationService());

  Hive.registerAdapter(WeekDayAdapter()); //6

  Hive.registerAdapter(ScreensNameAdapter()); //7

  Hive.registerAdapter(BankAccountAdapter()); //8
  GetIt.I.registerSingleton(BankAccountService());

  Hive.registerAdapter(ExchangeCurrencyAdapter()); //9
  GetIt.I.registerSingleton(ExchangeCurrencyService());

  GetIt.I.registerSingleton(DashboardService());

  await Hive.openBox<User>('user');
  await Hive.openBox<Settings>('settings');

  // final SettingsService settingsService = SettingsService();
  // settingsService.putPassCode("111111");

  // Box box = await Hive.openBox<User>('user');
  // Box box2 = await Hive.openBox<Settings>('settings');
  // // Box box3 = await Hive.openBox<List<CalculateCrypt>>('calculate_list');
  // // box3.clear();
  // box.clear();
  // box2.clear();

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
