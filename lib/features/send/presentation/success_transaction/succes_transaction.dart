import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';
import '../../../auth/widgets/main_button.dart';
import 'success_transaction_bloc.dart';

class SuccessTransaction extends StatefulWidget {
  final Future<void> Function() createTransaction;
  const SuccessTransaction({
    super.key,
    required this.createTransaction,
  });

  @override
  State<SuccessTransaction> createState() => _SuccessTransactionState();
}

class _SuccessTransactionState extends SuccessTransactionBloc {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 100),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  AppData.colors.topImageColor,
                  BlendMode.darken,
                ),
                image: const AssetImage("assets/layouts/BG2.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                AppData.assets.svg.rabbit(size: 150),
                const SizedBox(height: 17),
                AppData.assets.svg.logo,
              ],
            ),
          ),
          const SizedBox(height: 13),
          errorText != null
              ? Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    errorText!,
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(),
          const SizedBox(height: 13),
          isSent
              ? Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  decoration: BoxDecoration(
                    color: AppData.colors.middlePurple.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "your_transacyion_send".tr(),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: MainButton(
          height: 48,
          width: double.infinity,
          onPressed: () => context.go(AppData.routes.homeScreen),
          child: Text(
            "continue".tr(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
