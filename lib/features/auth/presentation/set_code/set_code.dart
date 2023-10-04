import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/widgets/main_button.dart';
import 'package:rabby/features/widgets/numpad.dart';

import 'set_code_bloc.dart';

class SetCodeScreen extends StatefulWidget {
  const SetCodeScreen({super.key});

  @override
  State<SetCodeScreen> createState() => _SetCodeScreenState();
}

class _SetCodeScreenState extends SetCodeBloc {
  Widget get topImage {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/layouts/BG2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 75),
          AppData.assets.svg.lock,
          const SizedBox(height: 8),
          Text(
            settingsService.getPassCode() != null ? "Confirm" : "Set Passcode",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 270,
            child: Text(
              settingsService.getPassCode() != null
                  ? ""
                  : "It will be used to unlock your wallet and encrypt local data",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget get next {
    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 80, bottom: 12),
      child: MainButton(
        gradient: !isNotFull()
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
        width: 200,
        onPressed: goNext,
        child: const Text("Next"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topImage,
          const SizedBox(height: 26),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: NumPad(
              numberCode: numberText,
              goNext: goNext,
              checkOnFull: isNotFull,
            ),
          ),
        ],
      ),
      bottomNavigationBar: next,
    );
  }
}
