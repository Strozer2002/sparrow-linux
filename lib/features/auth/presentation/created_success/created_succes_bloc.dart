import 'package:flutter/material.dart';

import 'created_success.dart';

abstract class CreatedSuccessBloc extends State<CreatedSuccess> {
  String formatText(String input) {
    if (input.length <= 14) {
      return input;
    } else {
      return '${input.substring(0, 6)}....${input.substring(input.length - 4)}';
    }
  }
}
