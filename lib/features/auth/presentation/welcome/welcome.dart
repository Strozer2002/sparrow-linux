import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rabby/features/auth/presentation/welcome/welcome_bloc.dart';
import 'package:rabby/features/auth/widgets/main_button.dart';
import 'package:rabby/features/auth/widgets/info_button.dart';

import '../../../../app_data/app_data.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends WelcomeBloc {
  // Logic site
  ImageProvider<Object> get backgroundImage {
    switch (selectedScreen) {
      case 0:
      case 3:
        return const AssetImage("assets/layouts/BG2.png");
      case 1:
        return const AssetImage("assets/layouts/BG2.png");
      case 2:
        return const AssetImage("assets/layouts/BG3.png");

      default:
        return const AssetImage("assets/layouts/BG2.png");
    }
  }

  Widget get imagesOnBg {
    switch (selectedScreen) {
      case 0:
        return Column(
          children: [
            const SizedBox(height: 16),
            AppData.assets.image.rabbitBank(),
            const SizedBox(height: 16),
            AppData.assets.svg.logo,
          ],
        );
      case 1:
        return Column(
          children: [
            const SizedBox(height: 51),
            AppData.assets.svg.rabbit(),
          ],
        );
      case 2:
        return Container();
      case 3:
        return Column(
          children: [
            AppData.assets.svg.rabbit(size: 150),
            const SizedBox(height: 17),
            AppData.assets.svg.logo,
            const SizedBox(height: 56),
            const Text(
              "Let's get you started!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        );
      default:
        return Column(
          children: [
            const SizedBox(height: 16),
            AppData.assets.image.rabbitBank(),
            const SizedBox(height: 16),
            AppData.assets.svg.logo,
          ],
        );
    }
  }

  String get slideText {
    switch (selectedScreen) {
      case 0:
        return 'The crypto wallet for everyone';
      case 1:
        return 'A non-custodial & secure wallet for';
      case 2:
        return 'Access the world of cryto & DeFi';
      default:
        return 'The crypto wallet for everyone';
    }
  }

  Widget get manyMore {
    switch (selectedScreen) {
      case 1:
        return Padding(
          padding: const EdgeInsets.only(top: 9),
          child: GestureDetector(
            onTap: toManyMore,
            child: Text(
              "and many more",
              style: TextStyle(
                fontSize: 16,
                color: AppData.colors.middlePurple,
              ),
            ),
          ),
        );
      case 0:
      case 2:
        return Container();
      default:
        return Container();
    }
  }

  Widget get skipScreens {
    return selectedScreen >= 3
        ? Container()
        : SizedBox(
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 6,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            width: selectedScreen == index
                                ? pickedWidth
                                : unpickedWidth,
                            height: 6,
                            decoration: BoxDecoration(
                              color: selectedScreen < index
                                  ? Colors.white30
                                  : Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(37),
                              ),
                            ),
                          ),
                          itemCount: 3,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(width: 6),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: toSkipScreens,
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget? get goNext {
    return selectedScreen == 3
        ? Container(
            width: 160,
            padding: const EdgeInsets.symmetric(horizontal: 106, vertical: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "By proceeding, you agree to App's Name ",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: 'Lato',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Terms of Use',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppData.colors.middlePurple,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = toTermsOfUse,
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: MainButton(
              height: 48,
              width: double.infinity,
              onPressed: goNextScreen,
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
  }

  Widget get selectedPart {
    return selectedScreen == 3
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: Column(
              children: [
                GestureDetector(
                  onTap: toCreateNewAddress,
                  child: InfoButton(
                    prefixIcon: AppData.assets.svg.plus,
                    child: const Text(
                      "Create New Address",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: toImportAddress,
                  child: InfoButton(
                      prefixIcon: AppData.assets.svg.import,
                      child: Row(
                        children: [
                          const Text(
                            "Import Address",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 14),
                          AppData.assets.svg.wallets,
                        ],
                      )),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 71),
              Text(
                slideText,
                style: const TextStyle(
                  fontSize: 36,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                ),
              ),
              manyMore,
            ],
          );
  }

  // ! Remarks designer
  double get bgHeight {
    return selectedScreen != 2 ? 400 : 450;
  }

  EdgeInsets get bgPaddings {
    return selectedScreen >= 3
        ? const EdgeInsets.only(top: 111, bottom: 20)
        : const EdgeInsets.symmetric(vertical: 45);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: bgHeight,
            padding: bgPaddings,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                skipScreens,
                imagesOnBg,
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: selectedPart,
            ),
          ),
        ],
      ),
      bottomNavigationBar: goNext,
    );
  }
}
