import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/domain/services/bank_account_service.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/operation/domain/models/operation.dart';
import 'package:sparrow/features/txApp/operation/repository/operation_repository.dart';

class OperationService {
  static OperationService instance = GetIt.I.get<OperationService>();

  final String _boxName = 'operation';

  late Box<Operation> operationBox;
  late Future<void> ready;

  OperationService() {
    ready = _initAsync();
  }

  Future<void> _initAsync() async => operationBox = Hive.isBoxOpen(_boxName)
      ? Hive.box<Operation>(_boxName)
      : await Hive.openBox<Operation>(_boxName);

  Future<List<Operation>> getOperationList() async {
    await ready;
    return operationBox.values.toList();
  }

  Future<void> _add(Operation obj) async {
    final OperationRepository operationRepository = OperationRepository();
    final updatedOperation = await operationRepository.addOperation(
      id: obj.id,
      date: obj.date.toString(),
      bankAccount: obj.bankAccount.id,
      categoryType: obj.category.name,
      amount: obj.amount,
    );
    if (updatedOperation.isSuccess) {
      print(" updatedOperation.data ${updatedOperation.data}");
      obj.isSyncOrDelete = true;
      await updateOperation(obj);
    }
    final Services services = Services();
    await services.check();
  }

  Future<void> _delete(Operation obj) async {
    final OperationRepository operationRepository = OperationRepository();
    final deletedAccount =
        await operationRepository.deleteOperation(id: obj.id);
    if (deletedAccount.isSuccess) {
      await deleteOperation(obj);
    }
    final Services services = Services();
    await services.check();
  }

  Future<void> updateOrAddInDb() async {
    // Update or add async bank accounts
    var accounts = await getOperationList();
    accounts.where((obj) => obj.isSyncOrDelete == false).forEach(_add);
  }

  Future<void> deleteInDb() async {
    // Delete async bank accounts
    var accounts = await getOperationList();
    accounts.where((obj) => obj.isSyncOrDelete == null).forEach(_delete);
  }

  Future<void> syncWithDatabase() async {
    await ready;
    await updateOrAddInDb();
    await deleteInDb();
    log(" Длина массива ${operationBox.values.toList().length}");
  }

  Future<void> importFromDb() async {
    await ready;
    operationBox.clear();
    final OperationRepository operationRepository = OperationRepository();
    final BankAccountService bankAccountService = BankAccountService();
    final CategoryService categoryService = CategoryService();
    final operations = await operationRepository.getAllOperation();
    if (operations.data != null) {
      for (int i = operations.data!.first.id;
          i <= operations.data!.last.id;
          i++) {
        BankAccount? account = await bankAccountService
            .getAccountById(operations.data![i].bankAccount);
        Category? category = await categoryService
            .getCategoryById(operations.data![i].categoryType);
        if (account != null && category != null) {
          await addOperation(
            Operation(
              bankAccount: account,
              category: category,
              date: operations.data![i].date,
              amount: operations.data![i].amount,
              id: operations.data![i].id,
              isSyncOrDelete: true,
            ),
          );
        }
      }
    }

    log(" Длина импортированного массива ${operationBox.values.toList().length}");
  }

  Future<int> getAsyncCount() async {
    await ready;
    int count = 0;
    var accounts = await getOperationList();
    accounts
        .where(
            (obj) => obj.isSyncOrDelete == false || obj.isSyncOrDelete == null)
        .forEach((obj) {
      count++;
    });
    log(" Длина async операций $count");
    return count;
  }

  Future<void> addOperation(Operation operation) async {
    await ready;
    await operationBox.put(operation.date.toString(), operation);
  }

  Future<void> updateOperation(Operation operation) async {
    await ready;
    await operationBox.put(operation.date.toString(), operation);
  }

  Future<void> deleteOperation(Operation operation) async {
    await ready;
    await operationBox.delete(operation.date.toString());
  }
}
