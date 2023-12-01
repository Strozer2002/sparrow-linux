import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/core/calculate_observer.dart';
import 'package:rabby/features/auth/presentation/create_new_address/create_new_address.dart';
import 'package:rabby/features/auth/presentation/create_wallet/create_wallet.dart';
import 'package:rabby/features/auth/presentation/created_success/created_success.dart';
import 'package:rabby/features/auth/presentation/import_address/import_adress.dart';
import 'package:rabby/features/auth/presentation/import_key/import_key.dart';
import 'package:rabby/features/auth/presentation/import_seed_phrase/import_seed_phrase.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/manage_crypt.dart';
import 'package:rabby/features/auth/presentation/seed_phrase/seed_phrase.dart';
import 'package:rabby/features/auth/presentation/select_import/select_import.dart';
import 'package:rabby/features/auth/presentation/set_code/set_code.dart';
import 'package:rabby/features/auth/presentation/welcome/welcome.dart';
import 'package:rabby/features/buy/presentation/buy_cash.dart';
import 'package:rabby/features/calculator/presentation/dashboard/dashboard_page.dart';
import 'package:rabby/features/calculator/presentation/list/list_crypt.dart';
import 'package:rabby/features/calculator/presentation/portfolio/portfolio.dart';
import 'package:rabby/features/dashboard/dashboard_page.dart';
import 'package:rabby/features/home/presentation/home_screen.dart';
import 'package:rabby/features/init/presentation/init.dart';
import 'package:rabby/features/send/presentation/send_address/send_address.dart';
import 'package:rabby/features/send/presentation/success_transaction/succes_transaction.dart';
import 'package:rabby/features/send/presentation/transaction/transaction.dart';
import 'package:rabby/features/settings/presentation/settings_screen.dart';
import 'package:rabby/features/swap/presentation/swap_screen.dart';
import 'package:rabby/features/widgets/qr_scanner.dart';

import '../../core/navigator_observer.dart';
import '../app_data.dart';

final _routes = RoutesList();

final GlobalKey<NavigatorState> rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigator = GlobalKey(debugLabel: 'shell');
final GlobalKey<NavigatorState> calculateNavigator =
    GlobalKey(debugLabel: 'calculate');

final DateTime targetDate = DateTime(2023, 12, 10);
DateTime today = DateTime.now();

class RoutesList {
  final String init = '/';

  // WelcomeScreens
  String get _welcomeScreenName => 'welcome';
  String get welcomeScreen => '$init$_welcomeScreenName';

  // Create new wallet

  String get _createWalletScreenName => 'createWallet';
  String get createWalletScreenScreen =>
      '$welcomeScreen/$_createWalletScreenName';

  // Create new address
  String get _createNewAddressScreenName => 'createNewAddress';
  String get createNewAddressScreen =>
      '$createWalletScreenScreen/$_createNewAddressScreenName';

  String get _seedPhraseScreenName => 'seedPhrase';
  String get seedPhraseScreen =>
      '$createNewAddressScreen/$_seedPhraseScreenName';

  String get _createdSuccessScreenName => 'createdSuccess';
  String get createdSuccessScreen =>
      '$seedPhraseScreen/$_createdSuccessScreenName';

  String get _authManageCryptScreenName => 'authManageCryptScreen';
  String get authManageCryptScreen =>
      '$createdSuccessScreen/$_authManageCryptScreenName';

  // Import wallet

  String get _selectImportName => 'selectImport';
  String get selectImport => '$welcomeScreen/$_selectImportName';

  //Import seed phrase
  String get _importSeedPhraseName => 'importSeedPhrase';
  String get importSeedPhrase => '$selectImport/$_importSeedPhraseName';

  // Import key
  String get _importKeyName => 'importKey';
  String get importKey => '$selectImport/$_importKeyName';

  String get _importAddressName => 'importAddress';
  String get importAddress => '$importSeedPhrase/$_importAddressName';

  String get _importManageCryptName => 'importManageCrypt';
  String get importManageCrypt => '$importAddress/$_importManageCryptName';

  // Home screen
  String get _setCodeName => 'mainSetCode';
  String get setCode => '$init$_setCodeName';

  String get _homeScreenName => 'homeScreen';
  String get homeScreen => '$init$_homeScreenName';

  String get _buyCashScreenName => 'buyCashScreen';
  String get buyCashScreen => '$homeScreen/$_buyCashScreenName';

  String get _settingsScreenName => 'settingsScreen';
  String get settingsScreen => '$init$_settingsScreenName';

  String get _manageCryptScreenName => 'manageCryptScreen';
  String get manageCryptScreen => '$init$_manageCryptScreenName';

  String get _swapScreenName => 'swapScreen';
  String get swapScreen => '$init$_swapScreenName';

  String get _sendScreenName => 'sendScreen';
  String get sendScreen => '$homeScreen/$_sendScreenName';

  String get _transactionScreenName => 'transactionScreen';
  String get transactionScreen => '$sendScreen/$_transactionScreenName';

  String get _confirmTransactionScreenName => 'confirmTransactionScreen';
  String get confirmTransactionScreen =>
      '$transactionScreen/$_confirmTransactionScreenName';

  String get _codeTransactionScreenName => 'codeTransactionScreen';
  String get codeTransactionScreen =>
      '$confirmTransactionScreen/$_codeTransactionScreenName';

  String get _newPassScreenName => 'newPassScreen';
  String get newPassScreen => '$settingsScreen/$_newPassScreenName';

  String get _qrScanScreenName => 'qrScanScreen';
  String get qrScanScreen => '$settingsScreen/$_qrScanScreenName';

  // Calculator
  String get _portfolioScreenName => '/portfolioScreen';
  String get portfolioScreen => _portfolioScreenName;

  String get _listCryptScreenName => '/listCryptScreen';
  String get listCryptScreen => _listCryptScreenName;
}

class Routes {
  Routes();

  String init = today.isBefore(targetDate)
      ? AppData.routes.portfolioScreen
      : AppData.routes.init;

  late final GoRouter routerConfig = GoRouter(
    navigatorKey: rootNavigator,
    initialLocation: init,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigator,
        builder: (context, state, child) => DashboardPage(
          key: state.pageKey,
          child: child,
        ),
        observers: [
          BottomBarNavObserver(),
        ],
        routes: [
          GoRoute(
            path: AppData.routes.init,
            builder: (BuildContext context, GoRouterState state) {
              return const InitPage();
            },
            routes: [
              GoRoute(
                path: AppData.routes._setCodeName,
                builder: (BuildContext context, GoRouterState state) {
                  return const SetCodeScreen();
                },
                routes: const [],
              ),
              GoRoute(
                path: AppData.routes._welcomeScreenName,
                builder: (BuildContext context, GoRouterState state) {
                  return const WelcomeScreen();
                },
                routes: [
                  // create wallet
                  GoRoute(
                    path: AppData.routes._createWalletScreenName,
                    builder: (BuildContext context, GoRouterState state) {
                      return const CreateWalletScreen();
                    },
                    routes: [
                      GoRoute(
                        path: AppData.routes._createNewAddressScreenName,
                        builder: (BuildContext context, GoRouterState state) {
                          return const CreateNewAddress();
                        },
                        routes: [
                          GoRoute(
                            path: AppData.routes._seedPhraseScreenName,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return const SeedPhraseScreen();
                            },
                            routes: [
                              GoRoute(
                                path: AppData.routes._createdSuccessScreenName,
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  return const CreatedSuccess();
                                },
                                routes: [
                                  GoRoute(
                                    path: AppData
                                        .routes._authManageCryptScreenName,
                                    builder: (BuildContext context,
                                        GoRouterState state) {
                                      return const ManageCrypt();
                                    },
                                    routes: const [],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: AppData.routes._selectImportName,
                    builder: (BuildContext context, GoRouterState state) {
                      return const SelectImport();
                    },
                    routes: [
                      // Import phrase
                      GoRoute(
                        path: AppData.routes._importSeedPhraseName,
                        builder: (BuildContext context, GoRouterState state) {
                          return const ImportSeedPhrase();
                        },
                        routes: [
                          GoRoute(
                            path: AppData.routes._importAddressName,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return const ImportAddress();
                            },
                            routes: [
                              GoRoute(
                                path: AppData.routes._importManageCryptName,
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  return const ManageCrypt();
                                },
                                routes: const [],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Import Key
                      GoRoute(
                        path: AppData.routes._importKeyName,
                        builder: (BuildContext context, GoRouterState state) {
                          return const ImportKey();
                        },
                        routes: [
                          GoRoute(
                            path: AppData.routes._importAddressName,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return const ImportAddress();
                            },
                            routes: [
                              GoRoute(
                                path: AppData.routes._importManageCryptName,
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  return const ManageCrypt();
                                },
                                routes: const [],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: AppData.routes._homeScreenName,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeScreen();
                },
                routes: [
                  GoRoute(
                    path: AppData.routes._buyCashScreenName,
                    builder: (BuildContext context, GoRouterState state) {
                      return const BuyCashScreen();
                    },
                    routes: const [],
                  ),
                  GoRoute(
                    path: AppData.routes._sendScreenName,
                    builder: (BuildContext context, GoRouterState state) {
                      return SendAddressScreen(
                        crypt: state.extra as String,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: AppData.routes._transactionScreenName,
                        builder: (BuildContext context, GoRouterState state) {
                          return TransactionWidget(
                            extra: state.extra as List<String>,
                          );
                        },
                        routes: [
                          GoRoute(
                            path: AppData.routes._confirmTransactionScreenName,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return SuccessTransaction(
                                createTransaction:
                                    state.extra as Future<void> Function(),
                              );
                            },
                            routes: [
                              GoRoute(
                                path: AppData.routes._codeTransactionScreenName,
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  return const SetCodeScreen();
                                },
                                routes: const [],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: AppData.routes._manageCryptScreenName,
                builder: (BuildContext context, GoRouterState state) {
                  return const ManageCrypt();
                },
                routes: const [],
              ),
              GoRoute(
                path: AppData.routes._swapScreenName,
                builder: (BuildContext context, GoRouterState state) {
                  return const SwapScreen();
                },
                routes: const [],
              ),
              GoRoute(
                path: AppData.routes._settingsScreenName,
                builder: (BuildContext context, GoRouterState state) {
                  return const SettingsScreen();
                },
                routes: [
                  GoRoute(
                    path: AppData.routes._newPassScreenName,
                    builder: (BuildContext context, GoRouterState state) {
                      return SetCodeScreen(
                        changePassword: state.extra as bool,
                      );
                    },
                    routes: const [],
                  ),
                  GoRoute(
                    path: AppData.routes._qrScanScreenName,
                    builder: (BuildContext context, GoRouterState state) {
                      return const QRViewExample();
                    },
                    routes: const [],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: calculateNavigator,
        builder: (context, state, child) => DashboardCalculatorPage(
          key: state.pageKey,
          child: child,
        ),
        observers: [
          CalculateObserver(),
        ],
        routes: [
          GoRoute(
            path: AppData.routes.portfolioScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const PortfolioScreen();
            },
          ),
          GoRoute(
            path: AppData.routes.listCryptScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const ListCryptsScreen();
            },
          ),
        ],
      ),
    ],
  );
}
