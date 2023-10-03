import 'dart:async';

import 'package:rabby/features/auth/repository/auth_client.dart';
import 'package:rabby/features/auth/repository/domain/register/register_body.dart';

import '../../../core/data_source/dev_remote_data_source.dart';
import '../../../domain/object/general_callback_result.dart';
import '../domain/adapters/user.dart';

final class AuthRepository extends DevRemoteDataSource {
  late final _client = AuthClient(dio);

  Future<RemoteCbResult<User?>> register(RegisterBody body) =>
      request(() => _client.register(body));
}
