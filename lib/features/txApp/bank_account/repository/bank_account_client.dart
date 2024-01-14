import 'package:dio/dio.dart';
import 'package:sparrow/features/txApp/domain/object/list_response_body.dart';
import 'package:sparrow/features/txApp/domain/object/single_response_body.dart';
import 'package:sparrow/features/txApp/domain/object/void_response_body.dart';
import 'package:sparrow/features/txApp/bank_account/repository/model/bank_account_entity.dart';
import 'package:sparrow/features/txApp/bank_account/repository/model/last_id.dart';

import 'package:retrofit/retrofit.dart';

part 'bank_account_client.g.dart';

@RestApi()
abstract class BankAccountClient {
  factory BankAccountClient(Dio dio, {String? baseUrl}) = _BankAccountClient;

  @GET('bank_account/add.php')
  Future<HttpResponse<VoidResponseBody>> addBankAccount(
    @Query('id') int id,
    @Query('name') String name,
    @Query('currency') String currency,
    @Query('color') int color,
    @Query('icon') int icon,
    @Query('amount') double amount, {
    @Query('description') required String? description,
  });

  @GET('bank_account/update.php')
  Future<HttpResponse<VoidResponseBody>> updateBankAccount(
    @Query('id') int id,
    @Query('name') String name,
    @Query('currency') String currency,
    @Query('color') int color,
    @Query('icon') int icon,
    @Query('amount') double amount, {
    @Query('description') required String? description,
  });

  @GET('bank_account/delete.php')
  Future<HttpResponse<VoidResponseBody>> deleteBankAccount(
    @Query('id') int id,
  );

  @GET('bank_account/getLastId.php')
  Future<HttpResponse<SingleResponseBody<LastIdEntity>>> getLastId();

  @GET('bank_account/getAll.php')
  Future<HttpResponse<ListResponseBody<BankAccountEntity>>>
      getAllBankAccounts();
}
