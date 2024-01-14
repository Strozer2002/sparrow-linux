import 'dart:async';

import 'package:sparrow/core/data_source/inch_api.dart';
import 'package:sparrow/features/auth/repository/auth_client.dart';

import '../../../domain/object/general_callback_result.dart';
final class InchRepository extends InchApiRemoteDataSource {
  late final _client = AuthClient(dio);

  
}
