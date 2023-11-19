import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:go_router/go_router.dart';
import 'package:rabby/features/dashboard/domain/dashboard_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../../app_data/app_data.dart';

class CalculateBottomNavBar extends StatefulWidget {
  const CalculateBottomNavBar({
    super.key,
  });

  @override
  State<CalculateBottomNavBar> createState() => _CalculateBottomNavBarState();
}

class _CalculateBottomNavBarState extends State<CalculateBottomNavBar> {
  final _dashboardService = GetIt.I.get<DashboardService>();

  void onItemTapped(int index) {
    _dashboardService.selectIndex.value = index;

    switch (_dashboardService.selectIndex.value) {
      case 0:
        context.go(AppData.routes.portfolioScreen);
        break;
      case 1:
        context.go(AppData.routes.listCryptScreen);
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
      color: AppData.colors.nightBottomNavColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomItem(
            child: const Icon(Icons.backpack),
            label: '',
            curIndex: 0,
          ),
          bottomItem(
            child: const Icon(Icons.list),
            label: '',
            curIndex: 1,
          ),
        ],
      ),
    );
  }
}
