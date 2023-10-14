import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';

class SelectImport extends StatefulWidget {
  const SelectImport({super.key});

  @override
  State<SelectImport> createState() => _SelectImportState();
}

class _SelectImportState extends State<SelectImport> {
  Widget get topImage {
    return Container(
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
          const SizedBox(height: 75),
          AppData.assets.svg.importPlus,
          const SizedBox(height: 12),
          const Text(
            "Select Import Method",
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

  Widget phrase(Widget icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: AppData.colors.nightBottomNavColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            AppData.assets.svg.chevron,
          ],
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
          GestureDetector(
            onTap: () => context.push(AppData.routes.importSeedPhrase),
            child: phrase(AppData.assets.svg.phrase, "Import Seed Phrase"),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              print("Key");
              context.push(AppData.routes.importKey);
            },
            child: phrase(AppData.assets.svg.key, "Import Private Key"),
          ),
        ],
      ),
    );
  }
}
