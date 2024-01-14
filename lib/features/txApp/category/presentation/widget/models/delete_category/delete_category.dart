import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/category/repository/category_repository.dart';

class DeleteCategory extends StatefulWidget {
  final Category category;
  final FutureOr<void> Function(Category category)? onDelete;
  final FutureOr<void> Function(Category category)? onUpdate;
  const DeleteCategory({
    super.key,
    required this.category,
    this.onDelete,
    this.onUpdate,
  });

  @override
  State<DeleteCategory> createState() => _DeleteCategoryState();
}

class _DeleteCategoryState extends State<DeleteCategory> {
  final CategoryService categoryService = CategoryService.instance;
  final CategoryRepository categoryRepository = CategoryRepository();
  final Connectivity _connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Удалить категорию?",
                  style: AppData.theme.text.s18w700,
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: AppData.theme.button.acceptElevatedButton,
                      onPressed: () async {
                        final connectivityResult =
                            await _connectivity.checkConnectivity();
                        if (connectivityResult != ConnectivityResult.none) {
                          final result = await categoryRepository
                              .deleteCategory(id: widget.category.id);
                          if (result.isSuccess) {
                            print(result.message);
                          }
                          await widget.onDelete?.call(widget.category);
                        } else {
                          await widget.onUpdate?.call(widget.category);
                        }
                        final Services services = Services();
                        await services.check();

                        context.pop();
                      },
                      child: const Text("Да"),
                    ),
                    ElevatedButton(
                      style: AppData.theme.button.deleteElevatedButton,
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("Нет"),
                    ),
                  ],
                ),
              );
            });
        if (mounted) {
          context.pop();
        }
      },
      icon: Icon(
        Icons.delete,
        color: Colors.red.shade300,
      ),
    );
  }
}
