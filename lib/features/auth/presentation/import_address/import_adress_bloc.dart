import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';

import 'import_adress.dart';

abstract class ImportAddressBloc extends State<ImportAddress> {
  final TextEditingController addressCtrl = TextEditingController();

  void onSubmitted(String value) {}

  void next() {
    context.push(
      AppData.routes.createdSuccessScreen,
      extra: "Imported Successfull",
    );
  }
}
