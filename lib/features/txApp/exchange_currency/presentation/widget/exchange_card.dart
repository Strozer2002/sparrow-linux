import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/presentation/widget/delete_exchange/delete_exchange.dart';
import 'package:sparrow/features/txApp/exchange_currency/presentation/widget/update_exchange/update_exchange.dart';

class ExchangeCard extends StatefulWidget {
  final ExchangeCurrency exchangeCurrency;
  final FutureOr<void> Function(ExchangeCurrency exchangeCurrency)? onDelete;
  final FutureOr<void> Function(ExchangeCurrency exchangeCurrency)? onChange;
  final FutureOr<void> Function(ExchangeCurrency exchangeCurrency)? onUpdate;
  const ExchangeCard({
    super.key,
    this.onDelete,
    this.onChange,
    required this.exchangeCurrency,
    this.onUpdate,
  });

  @override
  State<ExchangeCard> createState() => _ExchangeCardState();
}

class _ExchangeCardState extends State<ExchangeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: AppData.colors.sky200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.exchangeCurrency.currencyFrom.name,
                  style: AppData.theme.text.s20w500,
                ),
                Text(
                  "${widget.exchangeCurrency.amountFrom.toString() + widget.exchangeCurrency.currencyFrom.symbol} : ${widget.exchangeCurrency.amountInto.toString() + widget.exchangeCurrency.currencyInto.symbol}",
                  style: AppData.theme.text.s20w500,
                ),
                Text(
                  widget.exchangeCurrency.currencyInto.name,
                  style: AppData.theme.text.s20w500,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    backgroundColor: Colors.white,
                    title: Text(
                      "Choose method",
                      style: AppData.theme.text.s18w700,
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text("Update"),
                            UpdateExchange(
                              onChange: widget.onChange,
                              exchangeCurrency: widget.exchangeCurrency,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Delete"),
                            DeleteExchange(
                              exchangeCurrency: widget.exchangeCurrency,
                              onDelete: widget.onDelete,
                              onUpdate: widget.onUpdate,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
