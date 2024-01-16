import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sparrow/features/auth/presentation/welcome/welcome_bloc.dart';
import 'package:sparrow/features/auth/widgets/main_button.dart';
import 'package:sparrow/features/auth/widgets/info_button.dart';
import 'package:sparrow/features/widgets/custom_button.dart';

import '../../../../app_data/app_data.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends WelcomeBloc {
  // Logic site

  Widget get titleText {
    switch (selectedScreen) {
      case 0:
      case 1:
      case 2:
      case 3:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Welcome to Sparrow",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppData.assets.image.sparrow_logo48(),
            ],
          ),
        );

      default:
        return const Row();
    }
  }

  Widget get body {
    switch (selectedScreen) {
      case 0:
      case 1:
      case 2:
      case 3:
        return Expanded(
          child: Container(
            margin:
                const EdgeInsets.only(top: 34, left: 24, right: 24, bottom: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        iconTitle,
                        const SizedBox(width: 5),
                        Text(
                          titleBody,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 32),
                    textBody,
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppData.colors.backgroundColor.withOpacity(0.7),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        AppData.colors.gray100,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(titleSwitch),
                      Switch(
                        value: isSwitch,
                        onChanged: (bool change) => setState(() {}),
                        activeTrackColor: colorSwitch,
                        inactiveThumbColor: AppData.colors.gray300,
                        trackOutlineColor: MaterialStateProperty.resolveWith(
                          (final Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return null;
                            }

                            return AppData.colors.gray300;
                          },
                        ),
                        thumbColor: MaterialStateProperty.resolveWith(
                          (final Set<MaterialState> states) {
                            return Colors.white;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIcon(
                      onPressed: selectedScreen == 0 ? null : goBackScreen,
                      child: const Text("Back"),
                    ),
                    goNext,
                  ],
                )
              ],
            ),
          ),
        );

      default:
        return const Row();
    }
  }

  Widget get goNext {
    switch (selectedScreen) {
      case 0:
      case 1:
      case 2:
        return CustomIcon(
          onPressed: selectedScreen == 3 ? null : goNextScreen,
          child: const Text("Next"),
        );
      case 3:
        return Row(
          children: [
            const CustomIcon(
              onPressed: null,
              child: Text("Later or Offline mode"),
            ),
            const SizedBox(width: 10),
            CustomIcon(
              onPressed: toCreateNewAddress,
              child: const Text("Configure Server"),
            ),
          ],
        );
      default:
        return CustomIcon(
          onPressed: selectedScreen == 3 ? null : goNextScreen,
          child: const Text("Next"),
        );
    }
  }

  SvgPicture get iconTitle {
    switch (selectedScreen) {
      case 0:
        return AppData.assets.svg.switch_off;
      case 1:
        return AppData.assets.svg.switch_yellow;
      case 2:
        return AppData.assets.svg.switch_green;
      case 3:
        return AppData.assets.svg.switch_blue;
      default:
        return AppData.assets.svg.switch_off;
    }
  }

  Color get colorSwitch {
    switch (selectedScreen) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.green;
      case 3:
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  String get titleBody {
    switch (selectedScreen) {
      case 0:
        return "Introduction";
      case 1:
        return "Connecting to a Public Server";
      case 2:
        return "Connecting to a Bitcoin Core node";
      case 3:
        return "Connecting to a Private Electrum Server";
      default:
        return "Introduction";
    }
  }

  String get titleSwitch {
    switch (selectedScreen) {
      case 0:
        return "Offline";
      case 1:
        return "Connected to a Public Server (demonstration only)";
      case 2:
        return "Connected to Bitcoin Core (demonstration only)";
      case 3:
        return "Connecting to a Private Electrum Server";
      default:
        return "Offline";
    }
  }

  Widget get textBody {
    switch (selectedScreen) {
      case 0:
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sparrow is a Bitcoin wallet with a focus on security and usability.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Sparrow can operate in both an online and offline mode. In the online mode it connects to a server to display transaction history. In the offline mode it is useful as a transaction editor and as an airgapped multisig coordinator.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "The status bar at the bottom displays the connection status, as demonstrated below:",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        );
      case 1:
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "If you are beginning your journey in self custody, or just storing a small amount, the easiest way to connect Sparrow to the Bitcoin blockchain is via one of the preconfigured public Electrum servers.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "However, although Sparrow only connects to servers that have a record of respecting privacy, it is still not ideal as you are sharing your transaction history and balance with them.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "A yellow toggle means you are connected to a public server.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        );
      case 2:
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "If you are running your own Bitcoin Core node, you can configure Sparrow to connect to it directly.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "This means you are not sharing your transaction data, but be aware Bitcoin Core stores your balance, transactions and public keys unencrypted on that node, which is not ideal for true cold storage.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "A green toggle means you are connected to a Bitcoin Core node.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        );
      case 3:
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The most private way to connect is to your own Electrum server, which in turn connects to your Bitcoin Core node.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Because these servers index all Bitcoin transactions equally, your wallet transactions are never stored on the server in an identifiable way, and your server forgets your requests immediately after serving them.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "A blue toggle means you are connected to a private Electrum server. You're now ready to configure a server and start using Sparrow!",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        );

      default:
        return const Column();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            titleText,
            body,
          ],
        ),
      ),
    );
  }
}
