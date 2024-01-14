import 'package:flutter/material.dart';
import 'package:sparrow/features/txApp/exchange_currency/presentation/exchange_page/exchange_bloc.dart';
import 'package:sparrow/features/txApp/exchange_currency/presentation/widget/add_exchange/add_exchange.dart';
import 'package:sparrow/features/txApp/exchange_currency/presentation/widget/exchange_card.dart';
import 'package:reactive_variables/reactive_variables.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends ExchangeBloc {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obs(
        rvList: [
          tempExchange,
        ],
        builder: (BuildContext context) => tempExchange.value.isEmpty
            ? Text(isEmptyList)
            : ListView.separated(
                shrinkWrap: true,
                itemCount: tempExchange.value.length,
                itemBuilder: (context, index) => ExchangeCard(
                  exchangeCurrency: tempExchange()[index],
                  onDelete: deleteExchange,
                  onChange: updateExchange,
                  onUpdate: onUpdateCategory,
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
      ),
      floatingActionButton: AddExchange(onAdd: createExchange),
    );
  }
}
