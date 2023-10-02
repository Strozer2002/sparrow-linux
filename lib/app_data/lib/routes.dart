import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/auth/presentation/create_new_address/create_new_address.dart';
import 'package:rabby/features/auth/presentation/create_wallet/create_wallet.dart';
import 'package:rabby/features/auth/presentation/created_success/created_success.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/manage_crypt.dart';
import 'package:rabby/features/auth/presentation/seed_phrase/seed_phrase.dart';
import 'package:rabby/features/auth/presentation/set_code/set_code.dart';
import 'package:rabby/features/auth/presentation/welcome/welcome.dart';

import '../app_data.dart';

final _routes = RoutesList();

final GlobalKey<NavigatorState> rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigator = GlobalKey(debugLabel: 'shell');

class RoutesList {
  final String init = '/';

  // WelcomeScreens
  String get _welcomeScreenName => 'welcome';
  String get welcomeScreen => '$init$_welcomeScreenName';

  // Create new wallet

  String get _createWalletScreenName => 'createWallet';
  String get createWalletScreenScreen =>
      '$welcomeScreen/$_createWalletScreenName';

  String get _manageCryptScreenName => 'createWallet';
  String get manageCryptScreen =>
      '$createWalletScreenScreen/$_createWalletScreenName';

  // Create new address
  String get _setCodeScreenName => 'setCode';
  String get setCodeScreen => '$manageCryptScreen/$_setCodeScreenName';

  String get _createNewAddressScreenName => 'createNewAddress';
  String get createNewAddressScreen =>
      '$setCodeScreen/$_createNewAddressScreenName';

  String get _seedPhraseScreenName => 'seedPhrase';
  String get seedPhraseScreen =>
      '$createNewAddressScreen/$_seedPhraseScreenName';

  String get _createdSuccessScreenName => 'createdSuccess';
  String get createdSuccessScreen =>
      '$seedPhraseScreen/$_createdSuccessScreenName';
}

class Routes {
  Routes();
  // final authService = AuthService.instance;

  late final GoRouter routerConfig = GoRouter(
    navigatorKey: rootNavigator,
    // errorBuilder: (context, state) => ErrorScreen(state.error),
    // refreshListenable: _serviceManager.authService.rvIsAuthorized,
    // navigatorKey: mainNavigatorKey,
    // redirect: (context, state) async {
    //   final extraText = state.extra == null ? '' : ', extra: ${state.extra}';
    //   String queryParamsText = '';
    //   String paramsText = '';
    //   if (state.params.isNotEmpty) {
    //     queryParamsText = ', params: ${state.params}';
    //   }
    //   if (state.queryParams.isNotEmpty) {
    //     queryParamsText = ', queryParams: ${state.queryParams}';
    //   }
    //   log('<GO ROUTER> ${state.location}$extraText$paramsText$queryParamsText');

    //   if (!_serviceManager.initialized.value) {
    //     return null;
    //   }

    //   final isAuthorized = _serviceManager.authService.isAuthorized;
    //   final bool isAuthRoute = state.subloc.startsWith(_routes.auth);
    //   if (!isAuthorized) {
    //     if (isAuthRoute && !state.subloc.startsWith(_routes.authPinCode)) {
    //       return null;
    //     }
    //     return _routes.auth;
    //   }

    //   final mustAuthPinCode = await _serviceManager.storageService
    //       .getItem(key: AppData.constants.mustAuthPinCode);

    //   // Если необходимо пройти авторизацию по пинкоду
    //   if (mustAuthPinCode == 'true' &&
    //       !_serviceManager.authService.isPinCodeEntered) {
    //     return _routes.authPinCode;
    //   }

    //   if (isAuthRoute) {
    //     return _routes.init;
    //   }

    //   if (state.subloc.startsWith(_routes.home)) {
    //     return null;
    //   }

    //   return _routes.main;
    // },
    // redirect: (context, state) {
    //   if (_authService.isAuthorized) {
    //     return AppData.routes.homeScreen;
    //   } else {
    //     return null;
    //   }
    // },
    initialLocation: AppData.routes.welcomeScreen,

    routes: [
      GoRoute(
        path: AppData.routes.init,
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold();
        },
        routes: [
          GoRoute(
            path: AppData.routes._welcomeScreenName,
            builder: (BuildContext context, GoRouterState state) {
              return const WelcomeScreen();
            },
            routes: [
              GoRoute(
                path: AppData.routes._createWalletScreenName,
                builder: (BuildContext context, GoRouterState state) {
                  return const CreateWalletScreen();
                },
                routes: [
                  GoRoute(
                    path: AppData.routes._manageCryptScreenName,
                    builder: (BuildContext context, GoRouterState state) {
                      return const ManageCrypt();
                    },
                    routes: [
                      GoRoute(
                        path: AppData.routes._setCodeScreenName,
                        builder: (BuildContext context, GoRouterState state) {
                          return const SetCodeScreen();
                        },
                        routes: [
                          GoRoute(
                            path: AppData.routes._createNewAddressScreenName,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return const CreateNewAddress();
                            },
                            routes: [
                              GoRoute(
                                path: AppData.routes._seedPhraseScreenName,
                                builder: (BuildContext context,
                                    GoRouterState state) {
                                  return const SeedPhraseScreen();
                                },
                                routes: [
                                  GoRoute(
                                    path: AppData
                                        .routes._createdSuccessScreenName,
                                    builder: (BuildContext context,
                                        GoRouterState state) {
                                      return CreatedSuccess(
                                        address: state.extra as String,
                                      );
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
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
