import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';
import 'package:sparrow/features/txApp/category/domain/models/category_enum.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/category/presentation/category_page/category_page.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/settings/domain/services/settings_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class CategoryBloc extends State<CategoryPage> {
  final CategoryService categoryService = CategoryService.instance;
  final SettingsTxAppService settingsService = SettingsTxAppService.instance;
  late final Rv<CategoryType> currentType = Rv(CategoryType.expense)
    ..listen((CategoryType value) async {
      tempCategories.value = await getTypeCategory(value);
    });
  Rv<String?> currencySymbol = Rv(null);
  Rv<List<Category>> tempCategories = Rv([]);

  @override
  void initState() {
    (() async {
      tempCategories.value = await getTypeCategory(currentType.value);
      currencySymbol.value = await getMainCurrency();
    })();
    super.initState();
  }

  Future<List<Category>> getTypeCategory(CategoryType type) async {
    List<Category> categories = await categoryService.getCategoryList();
    return categories
        .where((obj) => obj.type == type && obj.isSyncOrDelete != null)
        .toList();
  }

  Future<String> getMainCurrency() async {
    Currency currency = await settingsService.getMainCurrency();
    return currency.symbol;
  }

  String getSumTypeCategory(List<Category> category) {
    return category.map((obj) => obj.amount).reduce((a, b) => a + b).toString();
  }

  // Interaction with object

  FutureOr<void> createCategory(Category category) async {
    await categoryService.addCategory(category);
    tempCategories.value = await getTypeCategory(currentType());
  }

  FutureOr<void> onUpdateCategory(Category account) async {
    account.isSyncOrDelete = null;
    await categoryService.updateCategory(account);

    tempCategories.value = await getTypeCategory(currentType());
  }

  FutureOr<void> updateCategory(Category category) async {
    await categoryService.updateCategory(category);
    if (mounted) {
      context.pop();
    }
    tempCategories.value = await getTypeCategory(currentType());
  }

  FutureOr<void> deleteCategory(Category category) async {
    await categoryService.deleteCategory(category);
    if (mounted) {
      context.pop();
    }
    tempCategories.value = await getTypeCategory(currentType());
  }

  //....................

  // Page settings

  void onIncome() => currentType.value = CategoryType.income;

  void onExpense() => currentType.value = CategoryType.expense;

  String get isEmptyList =>
      "У вас нет категорий : ${currentType.value == CategoryType.expense ? "Расходов" : "Доходов"}";

  String get allAmountForCategoryType =>
      "${getSumTypeCategory(tempCategories.value)} ${currencySymbol.value!}";

  MaterialColor colorFromCategoryType() {
    return tempCategories.value.first.type == CategoryType.income
        ? Colors.green
        : Colors.red;
  }

  //....................
}
