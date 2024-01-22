import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/repository/exchange_repository.dart';

class DeleteExchange extends StatefulWidget {
  final ExchangeCurrency exchangeCurrency;
  final FutureOr<void> Function(ExchangeCurrency exchangeCurrency)? onDelete;
  final FutureOr<void> Function(ExchangeCurrency exchangeCurrency)? onUpdate;
  const DeleteExchange({
    super.key,
    this.onDelete,
    required this.exchangeCurrency,
    this.onUpdate,
  });

  @override
  State<DeleteExchange> createState() => _DeleteExchangeState();
}

class _DeleteExchangeState extends State<DeleteExchange> {
  final ExchangeRepository exchangeRepository = ExchangeRepository();
  final Connectivity _connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Delete operation?",
                  style: AppData.theme.text.s18w700,
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: AppData.theme.button.acceptElevatedButton,
                      onPressed: () async {
                        final connectivityResult =
                            await _connectivity.checkConnectivity();
                        if (connectivityResult != ConnectivityResult.none) {
                          final result = await exchangeRepository
                              .deleteExchange(id: widget.exchangeCurrency.id);
                          if (result.isSuccess) {
                            print(result.message);
                          }
                          await widget.onDelete?.call(widget.exchangeCurrency);
                        } else {
                          await widget.onUpdate?.call(widget.exchangeCurrency);
                        }
                        final Services services = Services();
                        await services.check();

                        context.pop();
                      },
                      child: const Text("Yes"),
                    ),
                    ElevatedButton(
                      style: AppData.theme.button.deleteElevatedButton,
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("No"),
                    ),
                  ],
                ),
              );
            });
      },
      icon: Icon(
        Icons.delete,
        color: Colors.red.shade300,
      ),
    );
  }
}
