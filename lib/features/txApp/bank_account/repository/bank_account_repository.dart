import 'dart:async';

import 'package:sparrow/core/data_source/remote_data_source.dart';
import 'package:sparrow/features/txApp/bank_account/repository/bank_account_client.dart';
import 'package:sparrow/features/txApp/bank_account/repository/model/bank_account_entity.dart';
import 'package:sparrow/features/txApp/bank_account/repository/model/last_id.dart';
import 'package:sparrow/features/txApp/domain/object/general_callback_result.dart';




final class BankAccountRepository extends TxAppRemoteDataSource {
  late final _client = BankAccountClient(dio);

  Future<RemoteCbResult<BankAccountEntity?>> addBankAccount({
    required int id,
    required String name,
    required String currency,
    required int icon,
    required int color,
    String? description,
    required double amount,
  }) =>
      request(
        () => _client.addBankAccount(
          id,
          name,
          currency,
          color,
          icon,
          amount,
          description: description,
        ),
      );

  Future<RemoteCbResult<BankAccountEntity?>> updateBankAccount({
    required int id,
    required String name,
    required String currency,
    required int icon,
    required int color,
    String? description,
    required double amount,
  }) =>
      request(
        () => _client.updateBankAccount(
          id,
          name,
          currency,
          color,
          icon,
          amount,
          description: description,
        ),
      );

  Future<RemoteCbResult<BankAccountEntity?>> deleteBankAccount(
          {required int id}) =>
      request(
        () => _client.deleteBankAccount(id),
      );

  Future<RemoteCbResult<LastIdEntity?>> getLastId() => request(
        () => _client.getLastId(),
      );

  Future<RemoteCbResult<List<BankAccountEntity>?>> getAllBankAccounts() =>
      request(() => _client.getAllBankAccounts());
}
