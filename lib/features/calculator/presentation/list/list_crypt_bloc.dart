import 'package:flutter/material.dart';
import 'package:rabby/features/calculator/domain/calculate_crypt.dart';
import 'package:rabby/features/calculator/domain/calculate_service.dart';
import 'package:rabby/features/calculator/presentation/list/list_crypt.dart';

abstract class ListCryptsBloc extends State<ListCryptsScreen> {
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
    crypts = calculateService.getCalculateCrypts()?.calculate;
    setState(() {
      isLoading = false;
    });
  }
}
