import 'package:flutter/material.dart';
import 'package:rabby/features/home/domain/home_screen_enum.dart';
import 'package:rabby/features/home/domain/wallet_type_enum.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../../app_data/app_data.dart';
import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeBloc {
  Widget get topImage {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 64),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/layouts/BG2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    AppData.assets.svg.upper,
                    const SizedBox(width: 4),
                    const Text(
                      "+7.5%",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Today’s Profit",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            "\$174.669",
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Obs(
            rvList: [selectedScreen],
            builder: () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    homeButton(
                      selectedIndex: HomeScreenEnum.wallet,
                      icon: selectedScreen.value == HomeScreenEnum.wallet
                          ? AppData.assets.svg.wallet(color: Colors.white)
                          : AppData.assets.svg
                              .wallet(color: Colors.white.withOpacity(0.4)),
                      text: "Wallet",
                    ),
                    const SizedBox(width: 6),
                    homeButton(
                      selectedIndex: HomeScreenEnum.activity,
                      icon: selectedScreen.value == HomeScreenEnum.activity
                          ? AppData.assets.svg.wallet(color: Colors.white)
                          : AppData.assets.svg
                              .wallet(color: Colors.white.withOpacity(0.4)),
                      text: "Activity",
                    ),
                  ],
                ),
                homeButton(
                    selectedIndex: HomeScreenEnum.settings,
                    icon: selectedScreen.value == HomeScreenEnum.settings
                        ? AppData.assets.svg.settings(color: Colors.white)
                        : AppData.assets.svg
                            .settings(color: Colors.white.withOpacity(0.4)),
                    padding: const EdgeInsets.all(8)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget homeButton({
    required HomeScreenEnum selectedIndex,
    required Widget icon,
    String? text,
    EdgeInsetsGeometry? padding,
  }) {
    return GestureDetector(
      onTap: () {
        selectedScreen.value = selectedIndex;
        print(selectedIndex);
        print(selectedScreen.value);
      },
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          border: Border.all(
            color: selectedScreen.value == selectedIndex
                ? Colors.white
                : Colors.white.withOpacity(0.4),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            icon,
            text == null
                ? Container()
                : Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 12,
                          color: selectedScreen.value == selectedIndex
                              ? Colors.white
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget get body {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wallet',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Obs(
                rvList: [selectedWalletType],
                builder: () => Row(
                  children: [
                    cryptType(
                      selectWallet: WalletTypeEnum.send,
                      icon: AppData.assets.svg.vector,
                      text: "Send",
                      borderRadiusGeometry: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    cryptType(
                      selectWallet: WalletTypeEnum.resive,
                      icon: AppData.assets.svg.recive,
                      text: "Resive",
                      borderRadiusGeometry: const BorderRadius.only(
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget cryptType({
    required WalletTypeEnum selectWallet,
    required Widget icon,
    required String text,
    BorderRadiusGeometry? borderRadiusGeometry,
  }) {
    return GestureDetector(
      onTap: () => selectedWalletType.value = selectWallet,
      child: Container(
        decoration: BoxDecoration(
          color: selectedWalletType.value == selectWallet ? Colors.white : null,
          border: selectedWalletType.value == selectWallet
              ? null
              : Border.all(
                  color: AppData.colors.middlePurple.withOpacity(0.4),
                  width: 1,
                ),
          borderRadius: borderRadiusGeometry,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: selectedWalletType.value == selectWallet
                ? Border(
                    bottom: BorderSide(
                      color: AppData.colors.middlePurple,
                      width: 2,
                    ),
                  )
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: selectedWalletType.value == selectWallet
                      ? null
                      : AppData.colors.middlePurple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get cryptsWidget {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20),
        shrinkWrap: true,
        itemCount: crypts.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => showBottomDialog(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppData.assets.image.crypto(
                  value: crypts[index].iconName,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(crypts[index].amount.toString()),
                      Text(
                        crypts[index].shortName,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppData.colors.middlePurple.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("\$29"),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppData.colors.middlePurple.withOpacity(0.2),
                      ),
                      child: Text(
                        "+7.5%",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppData.colors.middlePurple.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showBottomDialog(int index) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppData.colors.middlePurple.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppData.colors.middlePurple.withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          AppData.assets.image.crypto(
                            value: crypts[index].iconName,
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(crypts[index].name),
                                Text(
                                  crypts[index].shortName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppData.colors.middlePurple
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppData.colors.middlePurple,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Color of the shadow
                                  spreadRadius: 4, // Spread radius
                                  blurRadius: 7, // Blur radius
                                  offset: const Offset(
                                      0, 3), // Offset in the x, y axis
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    cryptDiagram,
                    const SizedBox(height: 26),
                    const Text(
                      'Balance',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppData.colors.middlePurple.withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          AppData.assets.svg.walletPlus,
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Available",
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${crypts[index].amount} ${crypts[index].shortName}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppData.colors.middlePurple
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            "\$0,0",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  Widget get cryptDiagram {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      '\$10,945.00 ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '+7.5%',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppData.colors.middlePurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Obs(
              rvList: [selectedWalletType],
              builder: () => Row(
                children: [
                  cryptType(
                    selectWallet: WalletTypeEnum.send,
                    icon: AppData.assets.svg.vector,
                    text: "Send",
                    borderRadiusGeometry: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                  ),
                  cryptType(
                    selectWallet: WalletTypeEnum.resive,
                    icon: AppData.assets.svg.recive,
                    text: "Resive",
                    borderRadiusGeometry: const BorderRadius.only(
                      topRight: Radius.circular(12),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          height: 300,
          color: Colors.white,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            topImage,
            const SizedBox(height: 27),
            body,
            cryptsWidget,
            const SizedBox(height: 27),
          ],
        ),
      ),
    );
  }
}
