import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/features/txApp/category/domain/models/category_enum.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/operation/domain/models/operation.dart';
import 'package:sparrow/features/txApp/operation/domain/services/operation_service.dart';
import 'package:sparrow/features/txApp/operation/presentation/operation_page/operation_page.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class OperationBloc extends State<OperationPage> {
  final CategoryService categoryService = CategoryService.instance;
  final OperationService operationService = OperationService.instance;
  late final Rv<CategoryType> currentType = Rv(CategoryType.expense)
    ..listen((CategoryType value) async {
      tempOperation.value = await getTypeCategory(value);
    });
  Rv<List<Operation>> tempOperation = Rv([]);

  @override
  void initState() {
    (() async {
      tempOperation.value = await getTypeCategory(currentType.value);
    })();
    super.initState();
  }

  Future<List<Operation>> getTypeCategory(CategoryType type) async {
    List<Operation> operations = await operationService.getOperationList();
    return operations.where((obj) => obj.category.type == type).toList();
  }

  // Interaction with object

  FutureOr<void> createOperation(Operation operation) async {
    await operationService.addOperation(operation);
    tempOperation.value = await getTypeCategory(currentType());
  }

  FutureOr<void> onUpdateCategory(Operation operation) async {
    operation.isSyncOrDelete = null;
    await operationService.updateOperation(operation);
    tempOperation.value = await getTypeCategory(currentType());
  }

  FutureOr<void> updateOperation(Operation operation) async {
    await operationService.updateOperation(operation);
    if (mounted) {
      context.pop();
    }
    tempOperation.value = await getTypeCategory(currentType());
  }

  FutureOr<void> deleteOperation(Operation operation) async {
    await operationService.deleteOperation(operation);
    if (mounted) {
      context.pop();
    }
    tempOperation.value = await getTypeCategory(currentType());
  }

  //....................

  // Page settings

  void onIncome() => currentType.value = CategoryType.income;

  void onExpense() => currentType.value = CategoryType.expense;

  String get isEmptyList =>
      "You have not operations : ${currentType.value == CategoryType.expense ? "Expense" : "Income"}";

  //....................
}
