import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';
import '../../widgets/main_button.dart';
import 'seed_phrase_bloc.dart';

class SeedPhraseScreen extends StatefulWidget {
  final Mnemonic mnemonic;
  const SeedPhraseScreen({
    super.key,
    required this.mnemonic,
  });

  @override
  State<SeedPhraseScreen> createState() => _SeedPhraseScreenState();
}

class _SeedPhraseScreenState extends SeedPhraseBloc {
  AppBar get appBar {
    return AppBar(
      title: const Text("Backup Seed Phrase"),
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
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppData.colors.middlePurple.withOpacity(0.5),
          ),
        ),
      ),
      child: MainButton(
        onPressed: () {},
        child: const Text("I’ve Saved the Phrase"),
      ),
    );
  }

  Widget get attention {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(
          color: Colors.red.shade100,
          width: 1,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(13),
          topLeft: Radius.circular(13),
        ),
      ),
      child: Row(
        children: [
          AppData.assets.svg.star(color: Colors.red),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              "Make sure no one else is watching your screen when you back up the seed phrase",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget get phrases {
    return Container(
      padding: const EdgeInsets.only(top: 24, right: 20),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 2 / 1,
        ),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: index == 0 ? const Radius.circular(8) : Radius.zero,
              topRight: index == 2 ? const Radius.circular(8) : Radius.zero,
              bottomLeft: index == mnemonicList.length - 3
                  ? const Radius.circular(8)
                  : Radius.zero,
              bottomRight: index == mnemonicList.length - 1
                  ? const Radius.circular(8)
                  : Radius.zero,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Row(
            children: [
              Text(
                "${index + 1}.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                " ${mnemonicList[index]}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        itemCount: mnemonicList.length,
      ),
    );
  }

  Widget get copyPhrase {
    return TextButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: widget.mnemonic.sentence)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Seed phrase was copied"),
            ),
          );
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.copy_rounded,
            color: AppData.colors.middlePurple,
          ),
          const SizedBox(width: 6),
          Text(
            "Copy seed phrase",
            style: TextStyle(
              fontSize: 14,
              color: AppData.colors.middlePurple,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.only(top: 36, left: 20),
        child: Column(
          children: [
            attention,
            phrases,
            const SizedBox(height: 20),
            copyPhrase,
          ],
        ),
      ),
      bottomSheet: bottomButton,
    );
  }
}
