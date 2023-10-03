import 'package:flutter/material.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';

import 'created_success.dart';

abstract class CreatedSuccessBloc extends State<CreatedSuccess> {
  final AuthService authService = AuthService();
  
}
