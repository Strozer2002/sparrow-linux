import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/buy/presentation/buy_bloc.dart';
import 'package:rabby/features/widgets/icon_button.dart';
import 'package:rabby/features/widgets/numpad.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../app_data/app_data.dart';
import '../../auth/presentation/manage_crypt/domain/crypt.dart';
import '../../auth/widgets/main_button.dart';

class BuyCashScreen extends StatefulWidget {
  const BuyCashScreen({super.key});

  @override
  State<BuyCashScreen> createState() => _BuyCashScreenState();
}

class _BuyCashScreenState extends BuyCashBloc {
  AppBar get appBar {
    return AppBar(
      title: Text("add_cash".tr()),
      leading: IconButton(
        onPressed: () => context.go(AppData.routes.homeScreen),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get child {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: errorText.isEmpty
                  ? AppData.colors.middlePurple.withOpacity(0.2)
                  : Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    amountCtrl.text,
                    style: TextStyle(
                      color: errorText.isEmpty ? null : Colors.red,
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    authService.getSelectCurrency()!.symbol,
                    style: TextStyle(
                      fontSize: 36,
                      color: AppData.colors.middlePurple.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
              CustomIconButton(
                onPressed: toMax,
                isPressed: isMax,
                child: const Text(
                  "MAX",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 10),
          child: Text(
            errorText,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        DropdownButton<Crypt>(
          value: chosenToCrypt,
          onChanged: (Crypt? newValue) {
            setState(() {
              chosenToCrypt = newValue!;
            });
          },
          items: toCrypts.map<DropdownMenuItem<Crypt>>((Crypt value) {
            return DropdownMenuItem<Crypt>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
          dropdownColor: AppData.colors.nightBgColor,
        ),
        NumPad(numberCode: amountCtrl),
      ],
    );
  }

  Widget get bottomButton {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 82, vertical: 20),
      child: MainButton(
        gradient: errorText.isEmpty
            ? const LinearGradient(colors: [
                Color.fromARGB(255, 136, 171, 255),
                Color.fromARGB(255, 121, 131, 255),
                Color.fromARGB(255, 121, 131, 255)
              ])
            : const LinearGradient(colors: [
                Color.fromARGB(125, 136, 171, 255),
                Color.fromARGB(125, 121, 131, 255),
                Color.fromARGB(125, 121, 131, 255)
              ]),
        onPressed: errorText.isNotEmpty
            ? () {}
            : () => launchUrlString("https://www.moonpay.com/"),
        child: Text("buy".tr()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
        child: child,
      ),
      bottomNavigationBar: bottomButton,
    );
  }
}
