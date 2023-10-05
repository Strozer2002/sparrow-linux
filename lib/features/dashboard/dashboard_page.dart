import 'package:flutter/material.dart';
import 'package:rabby/features/dashboard/domain/dashboard_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../widgets/bottom_nav_bar.dart';

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
  final DashboardService _dashboardService = DashboardService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Obs(
        rvList: [_dashboardService.shouldShowBottomBar],
        builder: () => _dashboardService.shouldShowBottomBar()
            ? const BottomNavBar()
            : const SizedBox(),
      ),
    );
  }
}
