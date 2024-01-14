import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/account_card/widgets/account_logo.dart';
import 'package:sparrow/features/txApp/category/presentation/widget/category_card/widgets/category_logo.dart';
import 'package:sparrow/features/txApp/operation/domain/models/operation.dart';
import 'package:sparrow/features/txApp/operation/presentation/widget/update_operation/update_operation_bloc.dart';
import 'package:reactive_variables/reactive_variables.dart';

class UpdateOperation extends StatefulWidget {
  final Operation operation;
  final FutureOr<void> Function(Operation operation)? onChange;

  const UpdateOperation({
    super.key,
    this.onChange,
    required this.operation,
  });

  @override
  State<UpdateOperation> createState() => _UpdateOperationState();
}

class _UpdateOperationState extends UpdateOperationBloc {
  Widget get amountWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Введите потраченную сумму",
          style: AppData.theme.text.s16w500,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppData.colors.sky600,
              width: 2,
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: amountCtrl,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(amountAllow),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get dateWidget {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => selectDate(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(date.value != null
                ? DateFormat("yMMMd").format(date.value!)
                : 'Выберете дату'),
          ),
        ),
      ],
    );
  }

  Widget get categoryWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Выберете категорию",
          style: AppData.theme.text.s16w500,
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                categories.value = await categoryService.getCategoryList();
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        "Выберете категорию",
                        style: AppData.theme.text.s18w700,
                      ),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: categories.value!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ElevatedButton(
                              style: AppData.theme.button.whiteElevatedButton,
                              onPressed: () {
                                newCategory.value = categories.value![index];
                                context.pop();
                              },
                              child: Text(
                                categories.value![index].name,
                                style: AppData.theme.text.s14w500,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Открыть список категорий'),
              ),
            ),
            const SizedBox(height: 10),
            newCategory.value == null
                ? const SizedBox()
                : Column(
                    children: [
                      CategoryLogo(category: newCategory.value!),
                      Text(newCategory.value!.name),
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  Widget get accountWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Выберете счет",
          style: AppData.theme.text.s16w500,
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                accounts.value = await accountService.getBankAccountList();
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        "Выберете счет",
                        style: AppData.theme.text.s18w700,
                      ),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: accounts.value!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ElevatedButton(
                              style: AppData.theme.button.whiteElevatedButton,
                              onPressed: () {
                                newAccount.value = accounts.value![index];
                                context.pop();
                              },
                              child: Text(
                                accounts.value![index].name,
                                style: AppData.theme.text.s14w500,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Открыть список счетов'),
              ),
            ),
            const SizedBox(height: 10),
            newAccount.value == null
                ? const SizedBox()
                : Column(
                    children: [
                      AccountLogo(account: newAccount.value!),
                      Text(newAccount.value!.name),
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  Widget get updateWidget {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onUpdateCategory(),
        child: const Text("Изменить операцию"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Obs(
              rvList: [
                categories,
                newCategory,
                accounts,
                newAccount,
              ],
              builder: (BuildContext context) => AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                title: Text(
                  "Создание категории",
                  style: AppData.theme.text.s18w700,
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      amountWidget,
                      const SizedBox(height: 20),
                      dateWidget,
                      const SizedBox(height: 20),
                      categoryWidget,
                      const SizedBox(height: 20),
                      accountWidget,
                      const SizedBox(height: 50),
                      updateWidget,
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: Icon(
        Icons.edit,
        color: Colors.blue.shade300,
      ),
    );
  }
}
