import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/dashboard/domain/dashboard_service.dart';

class BottomBarNavObserver extends NavigatorObserver {
  final _dashboardService = GetIt.I.get<DashboardService>();

  @override
  Future<void> didPush(Route route, Route? previousRoute) async {
    super.didPush(route, previousRoute);

    print('didPush');
    if (route.navigator?.context != null) {
      print(
          'GoRouter.of(route.navigator!.context).location: ${GoRouter.of(route.navigator!.context).location}');
      final currentLocation = GoRouter.of(route.navigator!.context).location;
      if (currentLocation != AppData.routes.bankAccountScreen &&
          currentLocation != AppData.routes.categoryScreen &&
          currentLocation != AppData.routes.operationScreen &&
          currentLocation != AppData.routes.reviewScreen) {
        print('_dashboardService.shouldShowBottomBar(false);');
        _dashboardService.shouldShowBottomBar(false);
      } else if (currentLocation == AppData.routes.bankAccountScreen) {
        _dashboardService.selectIndex.value = 0;
      } else if (currentLocation == AppData.routes.categoryScreen) {
        _dashboardService.selectIndex.value = 1;
      } else if (currentLocation == AppData.routes.operationScreen) {
        _dashboardService.selectIndex.value = 2;
      } else if (currentLocation == AppData.routes.reviewScreen) {
        _dashboardService.selectIndex.value = 3;
      }
    }
    final Services services = Services();
    await services.check();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    print('didPop');
    if (route.navigator?.context != null) {
      final currentLocation = GoRouter.of(route.navigator!.context).location;
      print(
          'GoRouter.of(route.navigator!.context).location: ${GoRouter.of(route.navigator!.context).location}');
      if (currentLocation == AppData.routes.bankAccountScreen ||
          currentLocation == AppData.routes.categoryScreen ||
          currentLocation == AppData.routes.operationScreen ||
          currentLocation == AppData.routes.reviewScreen) {
        print('_dashboardService.shouldShowBottomBar(true);');
        _dashboardService.shouldShowBottomBar(true);
      }
    }
  }
}
