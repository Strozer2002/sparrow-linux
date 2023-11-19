import 'package:flutter/widgets.dart';
import 'package:rabby/features/calculator/presentation/portfolio/portfolio.dart';

import '../../domain/calculate_crypt.dart';
import '../../domain/calculate_service.dart';

abstract class PortfolioBloc extends State<PortfolioScreen> {
  // Services
  final CalculateService calculateService = CalculateService();

  

  // Variables
  bool isLoading = true;
  List<CalculateCrypt>? crypts;

  // Initialize
  @override
  void initState() {
    super.initState();
    loading();
  }

  // Loading for init
  Future<void> loading() async {
    crypts = calculateService.getFavoriteCalculateCrypts()?.calculate;
    setState(() {
      isLoading = false;
    });
  }
}
