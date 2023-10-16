import 'package:dio/dio.dart';
import 'package:rabby/features/diagrammes/domain/diagram.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/object/single_response_body.dart';
import '../../swap/domain/data_swap_entity.dart';
import '../domain/models/user_entity.dart';
import 'domain/register/register_body.dart';

part 'auth_client.g.dart';

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String? baseUrl}) = _AuthClient;

  @POST('/date/spot/board')
  Future<HttpResponse<SingleResponseBody<UserEntity>>> register(
    @Body() RegisterBody body,
  );

  @GET('/{address}/getChart/{period}')
  Future<HttpResponse<SingleResponseBody<DiagramEntity>>> periods(
    @Path("address") String address,
    @Path("period") String period,
  );

  @GET('/swap')
  Future<HttpResponse<SingleResponseBody<DataSwapEntity>>> linch(
    @Query('src') String fromToken,
    @Query('dst') String toToken,
    @Query('amount') int amount,
    @Query('from') String fromAddress,
    @Query('slippage') double slippage,
    @Query('disableEstimate') bool disableEstimate,
  );
}
