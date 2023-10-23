import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/widgets/loading_widget.dart';

import '../../../../app_data/app_data.dart';
import '../../widgets/main_button.dart';
import 'import_seed_phrase_bloc.dart';

class ImportSeedPhrase extends StatefulWidget {
  const ImportSeedPhrase({super.key});

  @override
  State<ImportSeedPhrase> createState() => _ImportSeedPhraseState();
}

class _ImportSeedPhraseState extends ImportSeedPhraseBloc {
  AppBar get appBar {
    return AppBar(
      title: const Text("Import Seed Phrase"),
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
      child: mnemonicList == null
          ? MainButton(
              gradient: LinearGradient(colors: [
                AppData.colors.middlePurple.withOpacity(0.5),
                AppData.colors.middlePurple.withOpacity(0.5)
              ]),
              onPressed: null,
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            )
          : MainButton(
              gradient: mnemonicList!.length < mnemonicCount
                  ? LinearGradient(colors: [
                      AppData.colors.middlePurple.withOpacity(0.5),
                      AppData.colors.middlePurple.withOpacity(0.5)
                    ])
                  : LinearGradient(colors: [
                      AppData.colors.middlePurple,
                      AppData.colors.middlePurple,
                    ]),
              onPressed: mnemonicList!.length < mnemonicCount ? null : next,
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }

  Widget get attention {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppData.colors.middlePurple.withOpacity(0.1),
        border: Border.all(
          color: AppData.colors.middlePurple.withOpacity(0.1),
          width: 1,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(13),
          topLeft: Radius.circular(13),
        ),
      ),
      child: Row(
        children: [
          AppData.assets.svg.star(color: AppData.colors.middlePurple),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              "You can paste your entire secret recovery phrase in 1st field",
              style:
                  TextStyle(fontSize: 12, color: AppData.colors.middlePurple),
            ),
          ),
        ],
      ),
    );
  }

  Widget get phrases {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 20),
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
            color: AppData.colors.nightBottomNavColor,
            borderRadius: BorderRadius.only(
              topLeft: index == 0 ? const Radius.circular(8) : Radius.zero,
              topRight: index == 2 ? const Radius.circular(8) : Radius.zero,
              bottomLeft: index == mnemonicCount - 3
                  ? const Radius.circular(8)
                  : Radius.zero,
              bottomRight: index == mnemonicCount - 1
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
              index == 0 && !isSubmit
                  ? Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            phraseController.text = value;
                          });
                        },
                        onSubmitted: onSubmitted,
                        controller: phraseController,
                        decoration: const InputDecoration(
                          labelText: 'Here...',
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  : mnemonicList == null
                      ? Container()
                      : Text(
                          " ${mnemonicList!.length <= index ? "" : mnemonicList?[index]}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
            ],
          ),
        ),
        itemCount: mnemonicCount,
      ),
    );
  }

  Widget get clearAll {
    return TextButton(
      onPressed: onClear,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.clear_all_rounded,
            color: AppData.colors.middlePurple,
          ),
          const SizedBox(width: 6),
          Text(
            "Clear All",
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
    return isLoading
        ? const Scaffold(
            body: LoadingWidget(),
          )
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 36, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    attention,
                    const SizedBox(height: 23),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<int>(
                            value: mnemonicCount,
                            onChanged: (int? newValue) {
                              setState(() {
                                mnemonicCount = newValue!;
                              });
                            },
                            items: possibleCount
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text("I have a $value- word phrase"),
                              );
                            }).toList(),
                            dropdownColor: Colors.white,
                          ),
                          clearAll,
                        ],
                      ),
                    ),
                    phrases,
                    const SizedBox(height: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What is a Seed Phrase?",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "A 12, 18 or 24- word phrase used to control your assets.",
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
                          "A 12, 18 or 24- word phrase used to control your assets.",
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
