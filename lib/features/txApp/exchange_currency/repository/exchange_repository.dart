import 'dart:async';

import 'package:sparrow/core/data_source/remote_data_source.dart';
import 'package:sparrow/features/txApp/domain/object/general_callback_result.dart';
import 'package:sparrow/features/txApp/exchange_currency/repository/exchange_client.dart';
import 'package:sparrow/features/txApp/exchange_currency/repository/model/exchange_entity.dart';



final class ExchangeRepository extends TxAppRemoteDataSource {
  late final _client = ExchangeClient(dio);

  Future<RemoteCbResult<ExchangeEntity?>> addExchange({
    required int id,
    required String currencyFrom,
    required String currencyInto,
    required double amountFrom,
    required double amountInto,
  }) =>
      request(
        () => _client.addExchange(
          id,
          currencyFrom,
          currencyInto,
          amountFrom,
          amountInto,
        ),
      );

  Future<RemoteCbResult<ExchangeEntity?>> updateExchange({
    required int id,
    required String currencyFrom,
    required String currencyInto,
    required double amountFrom,
    required double amountInto,
  }) =>
      request(
        () => _client.updateExchange(
          id,
          currencyFrom,
          currencyInto,
          amountFrom,
          amountInto,
        ),
      );

  Future<RemoteCbResult<ExchangeEntity?>> deleteExchange({required int id}) =>
      request(
        () => _client.deleteExchange(id),
      );

  Future<RemoteCbResult<List<ExchangeEntity>?>> getAllExchange() =>
      request(() => _client.getAllExchange());
}
