import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';
import 'package:sparrow/features/txApp/category/domain/models/category_enum.dart';
import 'package:sparrow/features/txApp/category/repository/category_repository.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:sparrow/features/txApp/settings/domain/services/settings_service.dart';

class CategoryService {
  static CategoryService instance = GetIt.I.get<CategoryService>();
  final SettingsTxAppService settingsService = SettingsTxAppService.instance;

  final String _boxName = 'category';

  late Box<Category> categoryBox;
  late Future<void> ready;

  CategoryService() {
    ready = _initAsync();
  }

  Future<void> _initAsync() async {
    categoryBox = Hive.isBoxOpen(_boxName)
        ? Hive.box<Category>(_boxName)
        : await Hive.openBox<Category>(_boxName);

    if (categoryBox.isEmpty) {
      await _firstInit();
    }
  }

  Future<void> _firstInit() async {
    // await categoryBox.put(
    //   "Продукты",
    //   Category(
    //     name: "Продукты",
    //     currency: await settingsService.getMainCurrency(),
    //     color: Colors.blue.value,
    //     icon: Icons.shop.codePoint,
    //     type: CategoryType.expense,
    //   ),
    // );
    // await categoryBox.put(
    //   "Здоровье",
    //   Category(
    //     name: "Здоровье",
    //     currency: await settingsService.getMainCurrency(),
    //     color: Colors.green.value,
    //     icon: Icons.health_and_safety.codePoint,
    //     type: CategoryType.expense,
    //     amount: 20,
    //   ),
    // );
    // await categoryBox.put(
    //   "Подарки",
    //   Category(
    //     name: "Подарки",
    //     currency: await settingsService.getMainCurrency(),
    //     color: Colors.orange.value,
    //     icon: Icons.card_giftcard_sharp.codePoint,
    //     type: CategoryType.expense,
    //   ),
    // );
    // await categoryBox.put(
    //   "Транспорт",
    //   Category(
    //     name: "Транспорт",
    //     currency: await settingsService.getMainCurrency(),
    //     color: Colors.yellow.value,
    //     icon: Icons.bus_alert_rounded.codePoint,
    //     type: CategoryType.expense,
    //   ),
    // );
    // await categoryBox.put(
    //   "Покупки",
    //   Category(
    //     name: "Покупки",
    //     currency: await settingsService.getMainCurrency(),
    //     color: Colors.brown.value,
    //     icon: Icons.shopping_bag.codePoint,
    //     type: CategoryType.expense,
    //   ),
    // );
    // await categoryBox.put(
    //   "Зарплата",
    //   Category(
    //     name: "Зарплата",
    //     currency: await settingsService.getMainCurrency(),
    //     color: Colors.green.value,
    //     icon: Icons.attach_money_outlined.codePoint,
    //     type: CategoryType.income,
    //   ),
    // );
  }

  Future<List<Category>> getCategoryList() async {
    await ready;
    return categoryBox.values.toList();
  }

  Future<void> _add(Category obj) async {
    final CategoryRepository categoryRepository = CategoryRepository();
    final updatedCategory = await categoryRepository.addCategory(
      id: obj.id,
      name: obj.name,
      currency: obj.currency.name,
      categoryType: obj.type.name,
      icon: obj.icon,
      color: obj.color,
      amount: obj.amount,
    );
    if (updatedCategory.isSuccess) {
      print(" updatedCategory.data ${updatedCategory.data}");
      obj.isSyncOrDelete = true;
      await updateCategory(obj);
    }
    final Services services = Services();
    await services.check();
  }

  Future<void> _delete(Category obj) async {
    final CategoryRepository categoryRepository = CategoryRepository();
    final deletedAccount = await categoryRepository.deleteCategory(id: obj.id);
    if (deletedAccount.isSuccess) {
      await deleteCategory(obj);
    }
    final Services services = Services();
    await services.check();
  }

  Future<void> updateOrAddInDb() async {
    // Update or add async bank accounts
    var accounts = await getCategoryList();
    accounts.where((obj) => obj.isSyncOrDelete == false).forEach(_add);
  }

  Future<void> deleteInDb() async {
    // Delete async bank accounts
    var accounts = await getCategoryList();
    accounts.where((obj) => obj.isSyncOrDelete == null).forEach(_delete);
  }

  Future<void> syncWithDatabase() async {
    await ready;
    await updateOrAddInDb();
    await deleteInDb();
    log(" Длина массива ${categoryBox.values.toList().length}");
  }

  Future<void> importFromDb() async {
    await ready;
    categoryBox.clear();
    final CategoryRepository categoryRepository = CategoryRepository();
    final CurrencyService currencyService = CurrencyService();
    final accounts = await categoryRepository.getAllCategory();
    if (accounts.data != null) {
      for (int i = accounts.data!.first.id; i <= accounts.data!.last.id; i++) {
        Currency currency =
            await currencyService.getCurrencyByName(accounts.data![i].currency);
        await addCategory(
          Category(
            type: accounts.data![i].categoryType == "income"
                ? CategoryType.income
                : CategoryType.expense,
            name: accounts.data![i].name,
            currency: currency,
            color: accounts.data![i].color,
            icon: accounts.data![i].icon,
            amount: accounts.data![i].amount,
            id: accounts.data![i].id,
            isSyncOrDelete: true,
          ),
        );
      }
    }
    log(" Длина импортированного массива ${categoryBox.values.toList().length}");
  }

  Future<int> getAsyncCount() async {
    await ready;
    int count = 0;
    var accounts = await getCategoryList();
    accounts
        .where(
            (obj) => obj.isSyncOrDelete == false || obj.isSyncOrDelete == null)
        .forEach((obj) {
      count++;
    });
    log(" Длина async категорий $count");
    return count;
  }

  Future<void> addCategory(Category category) async {
    await ready;
    await categoryBox.put(category.name, category);
  }

  Future<Category?> getCategoryById(String name) async {
    await ready;
    return categoryBox.get(name);
  }

  Future<void> updateCategory(Category category) async {
    await ready;
    await categoryBox.put(category.name, category);
  }

  Future<void> deleteCategory(Category category) async {
    await ready;
    await categoryBox.delete(category.name);
  }

  // Category? getCategoryById(dynamic key) {
  //   ready;
  //   return categoryBox.get(key);
  // }
}
