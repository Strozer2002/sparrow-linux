import 'dart:async';

import 'package:sparrow/core/data_source/remote_data_source.dart';
import 'package:sparrow/features/txApp/currency/repository/currency_client.dart';
import 'package:sparrow/features/txApp/currency/repository/model/currency_entity.dart';
import 'package:sparrow/features/txApp/domain/object/general_callback_result.dart';


final class CurrencyRepository extends TxAppRemoteDataSource {
  late final _client = CurrencyClient(dio);

  Future<RemoteCbResult<CurrencyEntity?>> getByName(String name) =>
      request(() => _client.getByName(name));

  Future<RemoteCbResult<List<CurrencyEntity>?>> getAllCurrency() =>
      request(() => _client.getAllCurrency());
}
