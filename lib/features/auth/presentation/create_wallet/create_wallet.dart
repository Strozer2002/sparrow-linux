import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/widgets/gradient_container.dart';
import 'package:rabby/features/auth/widgets/option.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../widgets/main_button.dart';
import 'create_wallet_bloc.dart';

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({super.key});

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends CreateWalletBloc {
  Widget option(String text, Widget icon) {
    return Option(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(255, 136, 171, 255),
          Color.fromARGB(255, 121, 131, 255),
          Color.fromARGB(255, 121, 131, 255)
        ],
      ),
      borderColor: Colors.white,
      bgColor: AppData.colors.middlePurple,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get loadingProgress {
    return Obs(
      rvList: [loading],
      builder: () => Column(
        children: [
          loading.value >= 0
              ? option(
                  "Generating your new",
                  AppData.assets.image.walletIcon(),
                )
              : Container(),
          const SizedBox(height: 10),
          loading.value >= 1
              ? option(
                  "Accumulating a large amount of random numbers",
                  AppData.assets.image.rabbyIcon(),
                )
              : Container(),
          const SizedBox(height: 10),
          loading.value >= 2
              ? option(
                  "Storing your wallet with secure encryption in your phone",
                  AppData.assets.image.rabbyIcon(),
                )
              : Container(),
          const SizedBox(height: 10),
          loading.value >= 3
              ? option(
                  "And we're done.",
                  AppData.assets.image.rabbyIcon(),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      Future.delayed(const Duration(seconds: 1), () {
        init();
        isInit = true;
      });
    }
    return Scaffold(
      body: GradientContainer(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 114, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppData.assets.svg.rabbit(),
              const SizedBox(height: 25),
              AppData.assets.svg.logo,
              const SizedBox(height: 10),
              const Text(
                "Create Wallet",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              loadingProgress,
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GradientContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Obs(
            rvList: [loading],
            builder: () => MainButton(
              gradient: loading.value < 3
                  ? LinearGradient(colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.5)
                    ])
                  : const LinearGradient(colors: [Colors.white, Colors.white]),
              height: 48,
              width: double.infinity,
              onPressed: loading.value < 3
                  ? null
                  : () => context.push(AppData.routes.createNewAddressScreen),
              child: Text(
                "Continue",
                style: TextStyle(
                  fontSize: 16,
                  color: AppData.colors.middlePurple,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
