import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';
import 'package:sparrow/features/txApp/category/presentation/widget/category_card/widgets/category_logo.dart';
import 'package:sparrow/features/txApp/category/presentation/widget/models/delete_category/delete_category.dart';
import 'package:sparrow/features/txApp/category/presentation/widget/models/update_category/update_category.dart';

class CategoryCard extends StatefulWidget {
  final Category category;
  final FutureOr<void> Function(Category category)? onDelete;
  final FutureOr<void> Function(Category category)? onChange;
  final FutureOr<void> Function(Category category)? onUpdate;
  const CategoryCard({
    super.key,
    required this.category,
    this.onDelete,
    this.onChange,
    this.onUpdate,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              backgroundColor: Colors.white,
              title: Text(
                "Choose method",
                style: AppData.theme.text.s18w700,
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("Update"),
                      UpdateCategory(
                        onChange: widget.onChange,
                        category: widget.category,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Delete"),
                      DeleteCategory(
                        category: widget.category,
                        onDelete: widget.onDelete,
                        onUpdate: widget.onUpdate,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.category.name,
            style: AppData.theme.text.s18w500,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          CategoryLogo(category: widget.category),
          const SizedBox(height: 5),
          Text(
            widget.category.getAmountAndCurrency,
            style: AppData.theme.text.s18w700.copyWith(
              color: widget.category.amount > 0 ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
