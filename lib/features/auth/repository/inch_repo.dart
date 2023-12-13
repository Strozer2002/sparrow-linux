import 'dart:async';

import 'package:rabby/core/data_source/inch_api.dart';
import 'package:rabby/features/auth/repository/auth_client.dart';

import '../../../domain/object/general_callback_result.dart';
import '../../swap/domain/data_swap_entity.dart';

final class InchRepository extends InchApiRemoteDataSource {
  late final _client = AuthClient(dio);

  Future<RemoteCbResult<DataSwapEntity?>> linch({
    required int id,
    required String fromToken,
    required String toToken,
    required int amount,
    required String fromAddress,
    required double slippage,
    required bool disableEstimate,
  }) =>
      request(
        () => _client.linch(
          id,
          fromToken,
          toToken,
          amount,
          fromAddress,
          slippage,
          disableEstimate,
        ),
      );
}
