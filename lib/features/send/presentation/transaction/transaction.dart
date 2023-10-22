import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../../../app_data/app_data.dart';
import '../../../auth/widgets/main_button.dart';
import 'transaction_bloc.dart';

class TransactionWidget extends StatefulWidget {
  final List<String> extra;
  const TransactionWidget({
    super.key,
    required this.extra,
  });

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends TransactionBloc {
  AppBar get appBar {
    return AppBar(
      title: const Text("Transaction"),
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get bottomButton {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        addressCtrl.text.isEmpty
            ? Container()
            : Text(
                "Rabby cannot recover any lost funds.",
                style: TextStyle(
                  color: AppData.colors.middlePurple.withOpacity(0.8),
                ),
              ),
        const SizedBox(height: 25),
        Container(
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
            gradient: amountCtrl.text.isEmpty
                ? LinearGradient(colors: [
                    AppData.colors.middlePurple.withOpacity(0.5),
                    AppData.colors.middlePurple.withOpacity(0.5)
                  ])
                : LinearGradient(colors: [
                    AppData.colors.middlePurple,
                    AppData.colors.middlePurple,
                  ]),
            onPressed: amountCtrl.text.isEmpty
                ? null
                : () {
                    print(AppData.utils.convertEtherToWei(
                      (double.parse(amountCtrl.text) /
                              authService.getSelectCurrency()!.rate) /
                          authService.getETH()!.priceForOne,
                    ));
                    context.push(
                      AppData.routes.confirmTransactionScreen,
                      extra: transaction,
                    );
                    // transaction();
                  },
            child: const Text(
              "Confirm transaction",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buyTab({
    required bool isFast,
    required BorderRadiusGeometry borderRadiusGeometry,
    required String text,
    required double precent,
  }) {
    return GestureDetector(
      onTap: () {
        isStandardTransaction.value = isFast;
        transform(precent);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isStandardTransaction.value == isFast
              ? AppData.colors.nightBottomNavColor
              : null,
          border: isStandardTransaction.value == isFast
              ? null
              : Border.all(
                  color: AppData.colors.middlePurple.withOpacity(0.4),
                  width: 1,
                ),
          borderRadius: borderRadiusGeometry,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: isStandardTransaction.value == isFast
                ? Border(
                    bottom: BorderSide(
                      color: AppData.colors.middlePurple,
                      width: 2,
                    ),
                  )
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isStandardTransaction.value == isFast
                  ? null
                  : AppData.colors.middlePurple,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    decoration: BoxDecoration(
                      color: AppData.colors.nightBottomNavColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          controller: amountCtrl,
                          onChanged: (value) => setState(() {
                            amountCtrl.text = value;
                          }),
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) {},
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            prefix: Text(
                              authService.getSelectCurrency()!.symbol,
                              style: TextStyle(
                                color: AppData.colors.middlePurple
                                    .withOpacity(0.8),
                                fontSize: 24,
                              ),
                            ),
                            suffix: Text(
                              amountCtrl.text.isEmpty
                                  ? ""
                                  : "${AppData.utils.doubleToSixValues((double.parse(amountCtrl.text) / authService.getSelectCurrency()!.rate) / mainCrypt!.priceForOne)} ${mainCrypt!.shortName}",
                              style: TextStyle(
                                color: AppData.colors.middlePurple
                                    .withOpacity(0.8),
                                fontSize: 16,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppData.colors.middlePurple
                                    .withOpacity(0.4),
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
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(fontSize: 16),
                          controller: addressCtrl,
                          onChanged: (value) => setState(() {
                            addressCtrl.text = value;
                          }),
                          onSubmitted: (value) {},
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: "Send to",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppData.colors.middlePurple
                                    .withOpacity(0.4),
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
                  const SizedBox(height: 30),
                  Obs(
                    rvList: [isStandardTransaction],
                    builder: () => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Transaction fee",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "~ ${AppData.utils.doubleToTwoValues(gasPrice)} ${authService.getSelectCurrency()!.name}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  buyTab(
                                    isFast: true,
                                    borderRadiusGeometry:
                                        const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                    ),
                                    text: "Fast",
                                    precent: 0.6,
                                  ),
                                  buyTab(
                                    isFast: false,
                                    borderRadiusGeometry:
                                        const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                    ),
                                    text: "Standart",
                                    precent: 0.2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 17),
                          decoration: BoxDecoration(
                            color: AppData.colors.nightBottomNavColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Reception time",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: isStandardTransaction.value
                                    ? [
                                        AppData.assets.image.light(),
                                        const SizedBox(width: 4),
                                        const Text(
                                          "Instant",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          "(0 to 30 minutes)",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ]
                                    : [
                                        AppData.assets.image.eco(),
                                        const SizedBox(width: 4),
                                        const Text(
                                          "2 hours in average",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomButton,
    );
  }
}
