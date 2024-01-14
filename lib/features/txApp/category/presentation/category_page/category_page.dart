import 'package:flutter/material.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/category/presentation/category_page/category_bloc.dart';
import 'package:sparrow/features/txApp/category/presentation/widget/models/add_category/add_category.dart';
import 'package:sparrow/features/txApp/category/presentation/widget/category_card/category_card.dart';
import 'package:reactive_variables/reactive_variables.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends CategoryBloc {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obs(
        rvList: [
          tempCategories,
          currentType,
          currencySymbol,
        ],
        builder: (BuildContext context) => Column(
          children: [
            Container(
              color: AppData.colors.sky600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: ElevatedButton(
                      onPressed: onExpense,
                      child: const Text("Расходы"),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: ElevatedButton(
                      onPressed: onIncome,
                      child: const Text("Доходы"),
                    ),
                  ),
                ],
              ),
            ),
            tempCategories.value.isEmpty
                ? Text(isEmptyList)
                : Column(
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Center(
                            child: Text(
                              allAmountForCategoryType,
                              style: AppData.theme.text.s28w700.copyWith(
                                color: colorFromCategoryType(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: tempCategories.value.length,
                        itemBuilder: (context, index) => CategoryCard(
                          category: tempCategories()[index],
                          onDelete: deleteCategory,
                          onChange: updateCategory,
                          onUpdate: onUpdateCategory,
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: AddCategory(onAdd: createCategory),
    );
  }
}
