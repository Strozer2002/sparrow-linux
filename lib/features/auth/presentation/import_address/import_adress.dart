import 'package:flutter/material.dart';

import '../../../../app_data/app_data.dart';
import '../../widgets/main_button.dart';
import 'import_adress_bloc.dart';

class ImportAddress extends StatefulWidget {
  const ImportAddress({super.key});

  @override
  State<ImportAddress> createState() => _ImportAddressState();
}

class _ImportAddressState extends ImportAddressBloc {
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
          AppData.assets.image.party(),
          const SizedBox(height: 12),
          const Text(
            "Imported Successfull",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 49),
        ],
      ),
    );
  }

  Widget get phrase {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Text(
              "1.",
              style: TextStyle(fontSize: 16, color: Colors.black26),
            ),
            const SizedBox(width: 12),
            Text(
              AppData.utils.formatText(addressString),
            ),
          ],
        ),
      ),
    );
  }

  Widget get bottomButton {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 82, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppData.colors.middlePurple.withOpacity(0.5),
          ),
        ),
      ),
      child: MainButton(
        gradient: addressString.isEmpty
            ? LinearGradient(colors: [
                AppData.colors.middlePurple.withOpacity(0.5),
                AppData.colors.middlePurple.withOpacity(0.5)
              ])
            : LinearGradient(colors: [
                AppData.colors.middlePurple,
                AppData.colors.middlePurple,
              ]),
        onPressed: addressString.isEmpty ? null : next,
        child: const Text(
          "Next",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topImage,
          const SizedBox(height: 34),
          phrase,
        ],
      ),
      bottomSheet: bottomButton,
    );
  }
}
