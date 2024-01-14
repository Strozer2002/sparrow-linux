import 'package:dio/dio.dart';
import 'package:sparrow/features/txApp/domain/object/list_response_body.dart';
import 'package:sparrow/features/txApp/currency/repository/model/currency_entity.dart';

import 'package:retrofit/retrofit.dart';
import 'package:sparrow/features/txApp/domain/object/single_response_body.dart';

part 'currency_client.g.dart';

@RestApi()
abstract class CurrencyClient {
  factory CurrencyClient(Dio dio, {String? baseUrl}) = _CurrencyClient;

  @GET('currency/by_name.php')
  Future<HttpResponse<SingleResponseBody<CurrencyEntity>>> getByName(
    @Query('name') String name,
  );

  @GET('currency/all.php')
  Future<HttpResponse<ListResponseBody<CurrencyEntity>>> getAllCurrency();
}
