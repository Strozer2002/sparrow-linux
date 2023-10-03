import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/object/single_response_body.dart';
import '../domain/models/user_entity.dart';
import 'domain/register/register_body.dart';

part 'auth_client.g.dart';

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String? baseUrl}) = _AuthClient;

  @POST('/board')
  Future<HttpResponse<SingleResponseBody<UserEntity>>> register(
    @Body() RegisterBody body,
  );
}
