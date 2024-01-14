import 'dart:async';

import 'package:sparrow/core/data_source/remote_data_source.dart';
import 'package:sparrow/features/txApp/domain/object/general_callback_result.dart';
import 'package:sparrow/features/txApp/operation/repository/model/operation_entity.dart';
import 'package:sparrow/features/txApp/operation/repository/operation_client.dart';

final class OperationRepository extends TxAppRemoteDataSource {
  late final _client = OperationClient(dio);

  Future<RemoteCbResult<OperationEntity?>> addOperation({
    required int id,
    required String date,
    required String categoryType,
    required int bankAccount,
    required double amount,
  }) =>
      request(
        () => _client.addOperation(
          id,
          date,
          categoryType,
          bankAccount,
          amount,
        ),
      );

  Future<RemoteCbResult<OperationEntity?>> updateOperation({
    required int id,
    required String date,
    required String categoryType,
    required int bankAccount,
    required double amount,
  }) =>
      request(
        () => _client.updateOperation(
          id,
          date,
          categoryType,
          bankAccount,
          amount,
        ),
      );

  Future<RemoteCbResult<OperationEntity?>> deleteOperation({required int id}) =>
      request(
        () => _client.deleteOperation(id),
      );

  Future<RemoteCbResult<List<OperationEntity>?>> getAllOperation() =>
      request(() => _client.getAllOperation());
}
