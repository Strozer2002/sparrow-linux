import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/dashboard/domain/dashboard_service.dart';

import '../app_data/app_data.dart';

class BottomBarNavObserver extends NavigatorObserver {
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
      if (currentLocation != AppData.routes.homeScreen) {
        print('_dashboardService.shouldShowBottomBar(false);');
        _dashboardService.shouldShowBottomBar(false);
      } else if (currentLocation == AppData.routes.homeScreen) {
        _dashboardService.selectIndex.value = 0;
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
      if (currentLocation == AppData.routes.homeScreen) {
        print('_dashboardService.shouldShowBottomBar(true);');
        _dashboardService.shouldShowBottomBar(true);
        _dashboardService.selectIndex.value = 0;
      }
    }
  }
}
