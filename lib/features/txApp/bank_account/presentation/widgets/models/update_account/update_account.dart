import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/models/update_account/update_account_bloc.dart';
import 'package:reactive_variables/reactive_variables.dart';

class UpdateAccount extends StatefulWidget {
  final BankAccount account;
  final FutureOr<void> Function(BankAccount account)? onChange;
  const UpdateAccount({
    super.key,
    required this.account,
    this.onChange,
  });

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends UpdateAccountBloc {
  Widget get nameWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Введите название счета",
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
            controller: nameCtrl,
          ),
        ),
      ],
    );
  }

  Widget get amountWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Введите потраченную сумму",
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
            controller: amountCtrl,
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

  Widget get currencyWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Выберете валюту",
          style: AppData.theme.text.s16w500,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        "Выберете основную валюту",
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
                                newCurrency.value = currencies.value![index];
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
                child: Text('Открыть список валют'),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: newCurrency.value == null
                  ? const SizedBox()
                  : Text(newCurrency.value!.name),
            ),
          ],
        ),
      ],
    );
  }

  Widget get iconWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Выберете иконку",
          style: AppData.theme.text.s16w500,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: pickIcon,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('Открыть список иконок'),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: icon.value ?? Container(),
            ),
          ],
        ),
      ],
    );
  }

  Widget get iconColorWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Выберете цвет иконки",
          style: AppData.theme.text.s16w500,
        ),
        BlockPicker(
          useInShowDialog: true,
          pickerColor: color.value,
          onColorChanged: (Color color) => this.color.value = color,
        ),
      ],
    );
  }

  Widget get updateWidget {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onUpdateAccount(),
        child: const Text("Изменить счет"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Obs(
              rvList: [
                newCurrency,
                color,
                icon,
              ],
              builder: (BuildContext context) => AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                title: Text(
                  "Изменение счета",
                  style: AppData.theme.text.s18w700,
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      nameWidget,
                      const SizedBox(height: 20),
                      amountWidget,
                      const SizedBox(height: 20),
                      currencyWidget,
                      const SizedBox(height: 20),
                      iconWidget,
                      const SizedBox(height: 20),
                      iconColorWidget,
                      const SizedBox(height: 50),
                      updateWidget,
                    ],
                  ),
                ),
              ),
            );
          },
        );
        if (mounted) {
          context.pop();
        }
      },
      icon: Icon(
        Icons.edit,
        color: Colors.blue.shade300,
      ),
    );
  }
}
