import 'dart:async';

import 'package:rabby/features/auth/domain/models/user_entity.dart';
import 'package:rabby/features/auth/repository/auth_client.dart';
import 'package:rabby/features/auth/repository/domain/register/register_body.dart';

import '../../../core/data_source/dev_remote_data_source.dart';
import '../../../domain/object/general_callback_result.dart';
import '../../diagrammes/domain/diagram.dart';

final class AuthRepository extends OrdinalRemoteDataSource {
  late final _client = AuthClient(dio);

  Future<RemoteCbResult<UserEntity?>> register(RegisterBody body) =>
      request(() => _client.register(body));

  Future<RemoteCbResult<DiagramEntity?>> periods(
    String address,
    String period,
  ) =>
      request(
        () => _client.periods(
          address,
          period,
        ),
      );
}
