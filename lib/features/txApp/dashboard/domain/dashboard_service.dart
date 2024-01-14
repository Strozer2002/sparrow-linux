import 'package:reactive_variables/reactive_variables.dart';

class DashboardService {
  Rv<bool> shouldShowBottomBar = Rv(true);
  Rv<int?> selectIndex = Rv(null);
  Rv<int?> syncCount = Rv(0);
}
