import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/dashboard/domain/dashboard_service.dart';

import '../app_data/app_data.dart';

class CalculateObserver extends NavigatorObserver {
  final _dashboardService = DashboardService.instance;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    print('didPush');

    if (route.navigator?.context != null) {
      print(
          'GoRouter.of(route.navigator!.context).location: ${GoRouterState.of(route.navigator!.context).uri.toString()}');
      final currentLocation =
          GoRouterState.of(route.navigator!.context).uri.toString();
      if (currentLocation != AppData.routes.portfolioScreen &&
          currentLocation != AppData.routes.listCryptScreen) {
        print('_dashboardService.shouldShowBottomBar(false);');
        _dashboardService.shouldShowBottomBar(false);
      } else if (currentLocation == AppData.routes.portfolioScreen) {
        _dashboardService.selectIndex.value = 0;
      } else if (currentLocation == AppData.routes.listCryptScreen) {
        _dashboardService.selectIndex.value = 1;
      }
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    print('didPop');
    if (route.navigator?.context != null) {
      final currentLocation =
          GoRouterState.of(route.navigator!.context).uri.toString();
      print(
          'GoRouter.of(route.navigator!.context).location: ${GoRouterState.of(route.navigator!.context).uri.toString()}');
      if (currentLocation == AppData.routes.portfolioScreen ||
          currentLocation == AppData.routes.listCryptScreen) {
        print('_dashboardService.shouldShowBottomBar(true);');
        _dashboardService.shouldShowBottomBar(true);
      }
    }
  }
}
