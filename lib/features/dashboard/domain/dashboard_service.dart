import 'package:get_it/get_it.dart';
import 'package:reactive_variables/reactive_variables.dart';

class DashboardService {
  static DashboardService instance =
      GetIt.I.registerSingleton(DashboardService._());

  DashboardService._();

  factory DashboardService() => instance;

  Rv<bool> shouldShowBottomBar = Rv(true);
  Rv<int> selectIndex = Rv(0);
}
