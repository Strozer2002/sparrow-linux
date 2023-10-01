import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/auth/widgets/main_button.dart';
import 'package:rabby/features/auth/widgets/option.dart';

import 'create_new_address_bloc.dart';

class CreateNewAddress extends StatefulWidget {
  const CreateNewAddress({super.key});

  @override
  State<CreateNewAddress> createState() => _CreateNewAddressState();
}

class _CreateNewAddressState extends CreateNewAddressBloc {
  AppBar get appBar {
    return AppBar(
      title: const Text("Create New Address"),
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get child {
    return const Column(
      children: [
        Text(
          "Before starting, please read and keep the following security points in mind",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 24),
        Option(
          text: "If i lose my seed phrase, my assets will be lost forever.",
        ),
        SizedBox(height: 10),
        Option(
          text:
              "If share my seed phrase with others, my assets will be stolen.",
        ),
        SizedBox(height: 10),
        Option(
          text:
              "The seed phrase is only stored on my computer, and Rabby has no access to it.",
        ),
        SizedBox(height: 10),
        Option(
          text:
              "If I uninstall Rabby without backing up the seed phrase, Rabby cannot retrive it for me.",
        ),
      ],
    );
  }

  Widget get bottomButton {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 82, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppData.colors.middlePurple.withOpacity(0.5),
          ),
        ),
      ),
      child: MainButton(
        onPressed: () => context.push(AppData.routes.seedPhraseScreen),
        child: const Text("Show Seed Phrase"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(top: 36, right: 20, left: 20),
        child: child,
      ),
      bottomSheet: bottomButton,
    );
  }
}
