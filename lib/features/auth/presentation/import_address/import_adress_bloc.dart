import 'package:flutter/material.dart';

import 'import_adress.dart';

abstract class ImportAddressBloc extends State<ImportAddress> {
  final TextEditingController addressCtrl = TextEditingController();

  void onSubmitted(String value) {}

  void next(){
    
  }
}
