import 'package:dio/dio.dart';
import 'package:sparrow/features/txApp/domain/object/list_response_body.dart';
import 'package:sparrow/features/txApp/domain/object/void_response_body.dart';
import 'package:sparrow/features/txApp/operation/repository/model/operation_entity.dart';

import 'package:retrofit/retrofit.dart';

part 'operation_client.g.dart';

@RestApi()
abstract class OperationClient {
  factory OperationClient(Dio dio, {String? baseUrl}) = _OperationClient;

  @GET('operation/add.php')
  Future<HttpResponse<VoidResponseBody>> addOperation(
    @Query('id') int id,
    @Query('date') String date,
    @Query('category') String categoryType,
    @Query('bank_account') int bankAccount,
    @Query('amount') double amount,
  );

  @GET('operation/update.php')
  Future<HttpResponse<VoidResponseBody>> updateOperation(
    @Query('id') int id,
    @Query('date') String date,
    @Query('category') String categoryType,
    @Query('bank_account') int bankAccount,
    @Query('amount') double amount,
  );

  @GET('operation/delete.php')
  Future<HttpResponse<VoidResponseBody>> deleteOperation(
    @Query('id') int id,
  );

  @GET('operation/getAll.php')
  Future<HttpResponse<ListResponseBody<OperationEntity>>> getAllOperation();
}
