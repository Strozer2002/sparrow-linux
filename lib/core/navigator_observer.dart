import 'package:flutter/material.dart';

class BottomBarNavObserver extends NavigatorObserver {
  // final _dashboardService = GetIt.I.get<DashboardService>();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    print('didPush');

    // if (route.navigator?.context != null) {
    //   print(
    //       'GoRouter.of(route.navigator!.context).location: ${GoRouterState.of(route.navigator!.context).uri.toString()}');
    //   final currentLocation =
    //       GoRouterState.of(route.navigator!.context).uri.toString();
    //   if (currentLocation != AppData.routes.homeScreen &&
    //       currentLocation != AppData.routes.formsScreen &&
    //       currentLocation != AppData.routes.visitsScreen &&
    //       currentLocation != AppData.routes.profileScreen) {
    //     print('_dashboardService.shouldShowBottomBar(false);');
    //     _dashboardService.shouldShowBottomBar(false);
    //   } else if (currentLocation == AppData.routes.homeScreen) {
    //     _dashboardService.selectIndex.value = 0;
    //   } else if (currentLocation == AppData.routes.visitsScreen) {
    //     _dashboardService.selectIndex.value = 1;
    //   } else if (currentLocation == AppData.routes.profileScreen) {
    //     _dashboardService.selectIndex.value = 2;
    //   }
    // }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    print('didPop');
    // if (route.navigator?.context != null) {
    //   final currentLocation =
    //       GoRouterState.of(route.navigator!.context).uri.toString();
    //   print(
    //       'GoRouter.of(route.navigator!.context).location: ${GoRouterState.of(route.navigator!.context).uri.toString()}');
    //   if (currentLocation == AppData.routes.homeScreen ||
    //       currentLocation == AppData.routes.formsScreen ||
    //       currentLocation == AppData.routes.visitsScreen ||
    //       currentLocation == AppData.routes.profileScreen) {
    //     print('_dashboardService.shouldShowBottomBar(true);');
    //     _dashboardService.shouldShowBottomBar(true);
    //   }
    // }
  }
}
