import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/exchange_currency/domain/models/exchange_currency.dart';
import 'package:sparrow/features/txApp/exchange_currency/presentation/widget/add_exchange/add_exchange_bloc.dart';
import 'package:reactive_variables/reactive_variables.dart';

class AddExchange extends StatefulWidget {
  final FutureOr<void> Function(ExchangeCurrency exchangeCurrency)? onAdd;

  const AddExchange({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddExchange> createState() => _AddExchangeState();
}

class _AddExchangeState extends AddExchangeBloc {
  Widget get amountFromWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter sum from course",
          style: AppData.theme.text.s16w500,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppData.colors.sky600,
              width: 2,
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: amountCtrlFrom,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(amountAllow),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get amountIntoWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter sum in course",
          style: AppData.theme.text.s16w500,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppData.colors.sky600,
              width: 2,
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: amountCtrlInto,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(amountAllow),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get currencyFromWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Choose currency from course",
          style: AppData.theme.text.s16w500,
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                currencies.value = await currencyService.getCurrencyList();
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        "Choose currency",
                        style: AppData.theme.text.s18w700,
                      ),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: currencies.value!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ElevatedButton(
                              style: AppData.theme.button.whiteElevatedButton,
                              onPressed: () {
                                newCurrencyFrom.value =
                                    currencies.value![index];
                                context.pop();
                              },
                              child: Text(
                                currencies.value![index].name,
                                style: AppData.theme.text.s14w500,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Open list currency'),
              ),
            ),
            const SizedBox(height: 10),
            newCurrencyFrom.value == null
                ? const SizedBox()
                : Text(newCurrencyFrom.value!.name),
          ],
        ),
      ],
    );
  }

  Widget get currencyIntoWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Choose currency в курса",
          style: AppData.theme.text.s16w500,
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                currencies.value = await currencyService.getCurrencyList();
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        "Choose currency",
                        style: AppData.theme.text.s18w700,
                      ),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: currencies.value!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ElevatedButton(
                              style: AppData.theme.button.whiteElevatedButton,
                              onPressed: () {
                                newCurrencyInto.value =
                                    currencies.value![index];
                                context.pop();
                              },
                              child: Text(
                                currencies.value![index].name,
                                style: AppData.theme.text.s14w500,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Open list currency'),
              ),
            ),
            const SizedBox(height: 10),
            newCurrencyInto.value == null
                ? const SizedBox()
                : Text(newCurrencyInto.value!.name),
          ],
        ),
      ],
    );
  }

  Widget get createWidget {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onCreateExchange(),
        child: const Text("Create course"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Obs(
              rvList: [
                currencies,
                newCurrencyFrom,
                newCurrencyInto,
              ],
              builder: (BuildContext context) => AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                title: Text(
                  "Creation course",
                  style: AppData.theme.text.s18w700,
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      amountFromWidget,
                      const SizedBox(height: 20),
                      amountIntoWidget,
                      const SizedBox(height: 20),
                      currencyFromWidget,
                      const SizedBox(height: 20),
                      currencyIntoWidget,
                      const SizedBox(height: 50),
                      createWidget,
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
