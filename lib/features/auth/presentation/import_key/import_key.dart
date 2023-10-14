import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';
import '../../widgets/main_button.dart';
import 'import_key_bloc.dart';

class ImportKey extends StatefulWidget {
  const ImportKey({super.key});

  @override
  State<ImportKey> createState() => _ImportKeyState();
}

class _ImportKeyState extends ImportKeyBloc {
  AppBar get appBar {
    return AppBar(
      title: const Text("Import Private key"),
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
        gradient: keyCtrl.text.isEmpty
            ? LinearGradient(colors: [
                AppData.colors.middlePurple.withOpacity(0.5),
                AppData.colors.middlePurple.withOpacity(0.5)
              ])
            : LinearGradient(colors: [
                AppData.colors.middlePurple,
                AppData.colors.middlePurple,
              ]),
        onPressed: keyCtrl.text.isEmpty ? null : next,
        child: const Text(
          "Confirm",
          style: TextStyle(color: Colors.white),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: keyCtrl,
                onChanged: (value) => setState(() {
                  keyCtrl.text = value;
                }),
                onSubmitted: (value) {},
                decoration: InputDecoration(
                  hintText: 'Enter your  Private key',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppData.colors.middlePurple,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppData.colors.middlePurple,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What is a Private key?",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "A string of letters and numbers used to control your assets",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Is it safe to import it in Rabby?",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Yes, it will be stored locally on your browser and only accessible to you.",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomButton,
    );
  }
}
