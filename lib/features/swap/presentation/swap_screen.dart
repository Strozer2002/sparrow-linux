import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/auth/presentation/manage_crypt/domain/crypt.dart';

import '../../../app_data/app_data.dart';
import '../../auth/widgets/main_button.dart';
import 'swap_bloc.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends SwapBloc {
  AppBar get appBar {
    return AppBar(
      title: Text("swap".tr()),
      leading: IconButton(
        onPressed: () => context.go(AppData.routes.homeScreen),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get bottomButton {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 82, vertical: 20),
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppData.colors.middlePurple.withOpacity(0.5),
          ),
        ),
      ),
      child: MainButton(
        gradient: amountFromCtrl.text.isEmpty
            ? LinearGradient(colors: [
                AppData.colors.middlePurple.withOpacity(0.5),
                AppData.colors.middlePurple.withOpacity(0.5)
              ])
            : LinearGradient(colors: [
                AppData.colors.middlePurple,
                AppData.colors.middlePurple,
              ]),
        onPressed: amountFromCtrl.text.isEmpty
            ? null
            : () {
                context.push(
                  AppData.routes.confirmTransactionScreen,
                  extra: swap,
                );
              },
        child: Text(
          "swap".tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppData.colors.nightBottomNavColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "pay_with".tr(),
                        style: TextStyle(color: AppData.colors.middlePurple),
                      ),
                      DropdownButton<Crypt>(
                        value: chosenFromCrypt,
                        onChanged: (Crypt? newValue) {
                          setState(() {
                            chosenFromCrypt = newValue!;
                            pickCrypt(chosenFromCrypt!);
                          });
                        },
                        items: fromCrypts
                            .map<DropdownMenuItem<Crypt>>((Crypt value) {
                          return DropdownMenuItem<Crypt>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        dropdownColor: AppData.colors.nightBgColor,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        controller: amountFromCtrl,
                        onChanged: (value) => setState(() {
                          amountFromCtrl.text = value;
                          amountToCtrl.text = (AppData.utils.doubleToSixValues(
                              (double.parse(amountFromCtrl.text) *
                                      authService.getSelectCurrency()!.rate *
                                      chosenFromCrypt!.priceForOne) /
                                  chosenToCrypt!.priceForOne));
                        }),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,6}')),
                        ],
                        onSubmitted: (value) {},
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              chosenFromCrypt!.shortName,
                              style: TextStyle(
                                color: AppData.colors.middlePurple
                                    .withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          suffix: Text(
                            amountFromCtrl.text.isEmpty
                                ? ""
                                : "${AppData.utils.doubleToTwoValues(double.parse(amountFromCtrl.text) * authService.getSelectCurrency()!.rate * chosenFromCrypt!.priceForOne)} ${authService.getSelectCurrency()!.symbol}",
                            style: TextStyle(
                              color:
                                  AppData.colors.middlePurple.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  AppData.colors.middlePurple.withOpacity(0.4),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppData.colors.middlePurple,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        "receive".tr(),
                        style: TextStyle(color: AppData.colors.middlePurple),
                      ),
                      DropdownButton<Crypt>(
                        value: chosenToCrypt,
                        onChanged: (Crypt? newValue) {
                          setState(() {
                            chosenToCrypt = newValue!;
                          });
                        },
                        items: toCrypts
                            .map<DropdownMenuItem<Crypt>>((Crypt value) {
                          return DropdownMenuItem<Crypt>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        dropdownColor: AppData.colors.nightBgColor,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        controller: amountToCtrl,
                        onChanged: (value) => setState(() {
                          amountToCtrl.text = value;
                          amountFromCtrl.text = (AppData.utils
                              .doubleToSixValues(
                                  (double.parse(amountToCtrl.text) *
                                          authService
                                              .getSelectCurrency()!
                                              .rate *
                                          chosenToCrypt!.priceForOne) /
                                      chosenFromCrypt!.priceForOne));
                        }),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,6}')),
                        ],
                        onSubmitted: (value) {},
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              chosenToCrypt!.shortName,
                              style: TextStyle(
                                color: AppData.colors.middlePurple
                                    .withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          suffix: Text(
                            amountToCtrl.text.isEmpty
                                ? ""
                                : "${AppData.utils.doubleToTwoValues(double.parse(amountToCtrl.text) * authService.getSelectCurrency()!.rate * chosenToCrypt!.priceForOne)} ${authService.getSelectCurrency()!.symbol}",
                            style: TextStyle(
                              color:
                                  AppData.colors.middlePurple.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  AppData.colors.middlePurple.withOpacity(0.4),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppData.colors.middlePurple,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomButton,
      ),
    );
  }
}
