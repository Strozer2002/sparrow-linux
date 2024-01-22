import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/dashboard/domain/dashboard_service.dart';
import 'package:sparrow/features/txApp/widgets/bottom_nav_bar.dart';
import 'package:sparrow/features/txApp/widgets/drawer/custom_drawer.dart';
import 'package:reactive_variables/reactive_variables.dart';

class DashboardPage extends StatefulWidget {
  final Widget child;

  const DashboardPage({
    super.key,
    required this.child,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _dashboardService = GetIt.I.get<DashboardService>();
  final Services services = Services();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.upload,
                    size: 36,
                  ),
                  onPressed: () async => await services.onSync(),
                ),
                Obs(
                  rvList: [
                    _dashboardService.syncCount,
                  ],
                  builder: (BuildContext context) =>
                      _dashboardService.syncCount.value == 0
                          ? Container()
                          : Positioned(
                              right: 5,
                              bottom: 5,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Text(
                                  '${_dashboardService.syncCount.value}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: widget.child,
      drawer: const CustomDrawer(),
      bottomNavigationBar: Obs(
        rvList: [
          _dashboardService.shouldShowBottomBar,
        ],
        builder: (BuildContext context) =>
            BottomNavBar(initialRoute: _dashboardService.selectIndex.value!),
      ),
    );
  }
}
