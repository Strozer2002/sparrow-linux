import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/auth/presentation/welcome/welcome.dart';

import '../app_data.dart';

final _routes = RoutesList();

final GlobalKey<NavigatorState> rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigator = GlobalKey(debugLabel: 'shell');

class RoutesList {
  final String init = '/';

  // Registration

  String get _welcomeScreenName => 'welcome';
  String get welcomeScreen => '/$_welcomeScreenName';
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
          ),
        ],
      ),
    ],
  );
}
