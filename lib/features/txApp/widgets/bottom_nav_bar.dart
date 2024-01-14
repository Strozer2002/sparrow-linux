import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/dashboard/domain/dashboard_service.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/screen_name_enum.dart';
import 'package:sparrow/features/txApp/settings/domain/services/settings_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

class BottomNavBar extends StatefulWidget {
  final int initialRoute;
  const BottomNavBar({
    super.key,
    required this.initialRoute,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _dashboardService = GetIt.I.get<DashboardService>();
  final SettingsTxAppService settingsService = SettingsTxAppService.instance;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    ScreensName screensName = await settingsService.getMainScreen();
    _dashboardService.selectIndex.value = screensName.id;
    onItemTapped(_dashboardService.selectIndex.value!);
  }

  void onItemTapped(int index) {
    _dashboardService.selectIndex.value = index;
    switch (_dashboardService.selectIndex.value) {
      case 0:
        context.go(AppData.routes.bankAccountScreen);
        break;
      case 1:
        context.go(AppData.routes.categoryScreen);
        break;
      case 2:
        context.go(AppData.routes.operationScreen);
        break;
      case 3:
        context.go(AppData.routes.reviewScreen);
        break;
      default:
        break;
    }
  }

  BottomNavigationBarItem bottomItem({
    required Widget passiveChild,
    required Widget activeChild,
    required String label,
    required int curIndex,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          color: _dashboardService.selectIndex.value == curIndex
              ? AppData.colors.sky700
              : null,
        ),
        child: _dashboardService.selectIndex.value == curIndex
            ? activeChild
            : passiveChild,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _dashboardService.shouldShowBottomBar.value &&
            _dashboardService.selectIndex.value != null
        ? Obs(
            rvList: [_dashboardService.selectIndex],
            builder: (BuildContext context) => BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                bottomItem(
                  passiveChild:
                      const Icon(Icons.account_balance_wallet_outlined),
                  activeChild: const Icon(Icons.account_balance_wallet_rounded),
                  label: ScreensName.bankAccount.name,
                  curIndex: 0,
                ),
                bottomItem(
                  passiveChild: const Icon(Icons.category_outlined),
                  activeChild: const Icon(Icons.category_rounded),
                  label: ScreensName.category.name,
                  curIndex: 1,
                ),
                bottomItem(
                  passiveChild:
                      const Icon(Icons.swap_horizontal_circle_outlined),
                  activeChild: const Icon(Icons.swap_horizontal_circle_rounded),
                  label: ScreensName.operation.name,
                  curIndex: 2,
                ),
                bottomItem(
                  passiveChild: const Icon(Icons.area_chart_outlined),
                  activeChild: const Icon(Icons.area_chart_rounded),
                  label: ScreensName.review.name,
                  curIndex: 3,
                ),
              ],
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppData.colors.sky600,
              currentIndex: _dashboardService.selectIndex.value!,
              selectedItemColor: Colors.white,
              selectedLabelStyle: AppData.theme.text.s12w600,
              unselectedFontSize: 12,
              unselectedItemColor: Colors.white,
              onTap: onItemTapped,
            ),
          )
        : const SizedBox();
  }
}
