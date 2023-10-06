import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:go_router/go_router.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../app_data/app_data.dart';
import '../dashboard/domain/dashboard_service.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _dashboardService = GetIt.I.get<DashboardService>();

  void onItemTapped(int index) {
    _dashboardService.selectIndex.value = index;

    switch (_dashboardService.selectIndex.value) {
      case 0:
        context.go(AppData.routes.homeScreen);
        break;
      case 1:
        context.go(AppData.routes.buyCashScreen);
        break;
      // case 2:
      //   context.go(AppData.routes.homeScreen);
      //   break;
      case 3:
        context.go(AppData.routes.settingsScreen);
        break;
      default:
        break;
    }
  }

  Widget bottomItem({
    required Widget child,
    required String label,
    required int curIndex,
  }) {
    return Obs(
      rvList: [_dashboardService.selectIndex],
      builder: () => GestureDetector(
        onTap: () => onItemTapped(curIndex),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            border: Border(
              top: _dashboardService.selectIndex.value == curIndex
                  ? BorderSide(
                      color: AppData.colors.middlePurple,
                      width: 3,
                    )
                  : BorderSide.none,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomItem(
            child: AppData.assets.svg.clearAll,
            label: '',
            curIndex: 0,
          ),
          bottomItem(
            child: AppData.assets.svg.wallet(),
            label: '',
            curIndex: 1,
          ),
          bottomItem(
            child: AppData.assets.svg.walletSend,
            label: '',
            curIndex: 2,
          ),
          bottomItem(
            child: AppData.assets.svg.settings(),
            label: '',
            curIndex: 3,
          ),
        ],
      ),
    );
  }
}
