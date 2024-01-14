import 'package:dio/dio.dart';
import 'package:sparrow/features/txApp/domain/object/list_response_body.dart';
import 'package:sparrow/features/txApp/domain/object/void_response_body.dart';
import 'package:sparrow/features/txApp/exchange_currency/repository/model/exchange_entity.dart';

import 'package:retrofit/retrofit.dart';

part 'exchange_client.g.dart';

@RestApi()
abstract class ExchangeClient {
  factory ExchangeClient(Dio dio, {String? baseUrl}) = _ExchangeClient;

  @GET('exchange/add.php')
  Future<HttpResponse<VoidResponseBody>> addExchange(
    @Query('id') int id,
    @Query('currency_from') String currencyFrom,
    @Query('currency_into') String currencyInto,
    @Query('amount_from') double amountFrom,
    @Query('amount_into') double amountInto,
  );

  @GET('exchange/update.php')
  Future<HttpResponse<VoidResponseBody>> updateExchange(
    @Query('id') int id,
    @Query('currency_from') String currencyFrom,
    @Query('currency_into') String currencyInto,
    @Query('amount_from') double amountFrom,
    @Query('amount_into') double amountInto,
  );

  @GET('exchange/delete.php')
  Future<HttpResponse<VoidResponseBody>> deleteExchange(
    @Query('id') int id,
  );

  @GET('exchange/getAll.php')
  Future<HttpResponse<ListResponseBody<ExchangeEntity>>> getAllExchange();
}
