import 'dart:async';

import 'package:sparrow/features/auth/domain/models/user_entity.dart';
import 'package:sparrow/features/auth/repository/auth_client.dart';
import 'package:sparrow/features/auth/repository/domain/register/register_body.dart';

import '../../../core/data_source/dev_remote_data_source.dart';
import '../../../domain/object/general_callback_result.dart';

final class AuthRepository extends OrdinalRemoteDataSource {
  late final _client = AuthClient(dio);

  Future<RemoteCbResult<UserEntity?>> register(RegisterBody body) =>
      request(() => _client.register(body));


}
