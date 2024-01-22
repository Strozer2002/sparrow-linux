import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';
import 'package:sparrow/features/txApp/category/domain/models/category_enum.dart';
import 'package:sparrow/features/txApp/category/presentation/widget/models/update_category/update_category_bloc.dart';
import 'package:reactive_variables/reactive_variables.dart';

class UpdateCategory extends StatefulWidget {
  final Category category;
  final FutureOr<void> Function(Category category)? onChange;

  const UpdateCategory({
    super.key,
    this.onChange,
    required this.category,
  });

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends UpdateCategoryBloc {
  Widget get nameWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter category name",
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
            controller: nameCtrl,
          ),
        ),
      ],
    );
  }

  Widget get amountWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter sum",
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

  Widget get currencyWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose currency",
          style: AppData.theme.text.s16w500,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                currencies.value = await currencyService.getCurrencyList();
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        "Choose main currency",
                        style: AppData.theme.text.s18w700,
                      ),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: currencies.value!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ElevatedButton(
                              style: AppData.theme.button.whiteElevatedButton,
                              onPressed: () {
                                newCurrency.value = currencies.value![index];
                                context.pop();
                              },
                              child: Text(
                                currencies.value![index].name,
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
                child: Text('Open list currency'),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: newCurrency.value == null
                  ? const SizedBox()
                  : Text(newCurrency.value!.name),
            ),
          ],
        ),
      ],
    );
  }

  Widget get iconWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose icon",
          style: AppData.theme.text.s16w500,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: pickIcon,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('Open icon list'),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: icon.value ?? Container(),
            ),
          ],
        ),
      ],
    );
  }

  Widget get iconColorWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose icon color",
          style: AppData.theme.text.s16w500,
        ),
        BlockPicker(
          useInShowDialog: true,
          pickerColor: color.value,
          onColorChanged: (Color color) => this.color.value = color,
        ),
      ],
    );
  }

  Widget get categoryTypeWidget {
    return Column(
      children: [
        Text(
          chooseCategoryTypeText,
          style: AppData.theme.text.s16w500,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => categoryType.value = CategoryType.expense,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('Expense'),
              ),
            ),
            ElevatedButton(
              onPressed: () => categoryType.value = CategoryType.income,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('Income'),
              ),
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
        child: const Text("Update category"),
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
                categoryType,
                newCurrency,
                color,
                icon,
              ],
              builder: (BuildContext context) => AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                title: Text(
                  "Updating category",
                  style: AppData.theme.text.s18w700,
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      nameWidget,
                      const SizedBox(height: 20),
                      amountWidget,
                      const SizedBox(height: 20),
                      currencyWidget,
                      const SizedBox(height: 20),
                      iconWidget,
                      const SizedBox(height: 20),
                      iconColorWidget,
                      const SizedBox(height: 20),
                      categoryTypeWidget,
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
