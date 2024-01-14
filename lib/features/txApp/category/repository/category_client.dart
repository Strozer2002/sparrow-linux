import 'package:dio/dio.dart';
import 'package:sparrow/features/txApp/domain/object/list_response_body.dart';
import 'package:sparrow/features/txApp/domain/object/void_response_body.dart';
import 'package:sparrow/features/txApp/category/repository/model/category_entity.dart';

import 'package:retrofit/retrofit.dart';

part 'category_client.g.dart';

@RestApi()
abstract class CategoryClient {
  factory CategoryClient(Dio dio, {String? baseUrl}) = _CategoryClient;

  @GET('category/add.php')
  Future<HttpResponse<VoidResponseBody>> addCategory(
    @Query('id') int id,
    @Query('name') String name,
    @Query('currency') String currency,
    @Query('category_type') String categoryType,
    @Query('color') int color,
    @Query('icon') int icon,
    @Query('amount') double amount, {
    @Query('description') required String? description,
  });

  @GET('category/update.php')
  Future<HttpResponse<VoidResponseBody>> updateCategory(
    @Query('id') int id,
    @Query('name') String name,
    @Query('currency') String currency,
    @Query('category_type') String categoryType,
    @Query('color') int color,
    @Query('icon') int icon,
    @Query('amount') double amount, {
    @Query('description') required String? description,
  });

  @GET('category/delete.php')
  Future<HttpResponse<VoidResponseBody>> deleteCategory(
    @Query('id') int id,
  );

  @GET('category/getAll.php')
  Future<HttpResponse<ListResponseBody<CategoryEntity>>> getAllCategory();
}
