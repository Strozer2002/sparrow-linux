import 'package:flutter/material.dart';
import 'package:rabby/features/calculator/domain/calculate_service.dart';
import 'package:rabby/features/dashboard/domain/dashboard_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../widgets/bottom_nav_bar.dart';

class DashboardCalculatorPage extends StatefulWidget {
  final Widget child;

  const DashboardCalculatorPage({
    super.key,
    required this.child,
  });

  @override
  State<DashboardCalculatorPage> createState() =>
      _DashboardCalculatorPageState();
}

class _DashboardCalculatorPageState extends State<DashboardCalculatorPage> {
  final DashboardService _dashboardService = DashboardService.instance;
  final CalculateService calculateService = CalculateService();

  @override
  void initState() {
    calculateService.getCrypts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Obs(
        rvList: [_dashboardService.shouldShowBottomBar],
        builder: () => _dashboardService.shouldShowBottomBar()
            ? const CalculateBottomNavBar()
            : const SizedBox(),
      ),
    );
  }
}
