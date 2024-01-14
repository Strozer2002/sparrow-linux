import 'dart:async';

import 'package:sparrow/core/data_source/remote_data_source.dart';
import 'package:sparrow/features/txApp/category/repository/category_client.dart';
import 'package:sparrow/features/txApp/category/repository/model/category_entity.dart';
import 'package:sparrow/features/txApp/domain/object/general_callback_result.dart';


final class CategoryRepository extends TxAppRemoteDataSource {
  late final _client = CategoryClient(dio);

  Future<RemoteCbResult<CategoryEntity?>> addCategory({
    required int id,
    required String name,
    required String currency,
    required String categoryType,
    required int icon,
    required int color,
    String? description,
    required double amount,
  }) =>
      request(
        () => _client.addCategory(
          id,
          name,
          currency,
          categoryType,
          color,
          icon,
          amount,
          description: description,
        ),
      );

  Future<RemoteCbResult<CategoryEntity?>> updateCategory({
    required int id,
    required String name,
    required String currency,
    required String categoryType,
    required int icon,
    required int color,
    String? description,
    required double amount,
  }) =>
      request(
        () => _client.updateCategory(
          id,
          name,
          currency,
          categoryType,
          color,
          icon,
          amount,
          description: description,
        ),
      );

  Future<RemoteCbResult<CategoryEntity?>> deleteCategory({required int id}) =>
      request(
        () => _client.deleteCategory(id),
      );

  Future<RemoteCbResult<List<CategoryEntity>?>> getAllCategory() =>
      request(() => _client.getAllCategory());
}
