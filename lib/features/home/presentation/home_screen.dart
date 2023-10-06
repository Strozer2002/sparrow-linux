import 'package:flutter/material.dart';
import 'package:rabby/features/home/domain/home_screen_enum.dart';
import 'package:rabby/features/home/domain/wallet_type_enum.dart';
import 'package:rabby/features/home/widget/crypt_tab.dart';
import 'package:rabby/features/home/widget/home_button.dart';
import 'package:rabby/features/widgets/home_bottom.dart';
import 'package:rabby/features/widgets/icon_button.dart';
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
                    HomeButton(
                      selectedIndex: HomeScreenEnum.wallet,
                      icon: AppData.assets.svg.wallet(
                        color: selectedScreen.value == HomeScreenEnum.wallet
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                      ),
                      text: "Wallet",
                      selectedScreen: selectedScreen,
                    ),
                    const SizedBox(width: 6),
                    HomeButton(
                      selectedIndex: HomeScreenEnum.activity,
                      icon: Icon(
                        Icons.query_builder,
                        color: selectedScreen.value == HomeScreenEnum.activity
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                      ),
                      text: "Activity",
                      selectedScreen: selectedScreen,
                    ),
                  ],
                ),
                HomeButton(
                  selectedIndex: HomeScreenEnum.settings,
                  icon: AppData.assets.svg.settings(
                    color: selectedScreen.value == HomeScreenEnum.settings
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                  padding: const EdgeInsets.all(8),
                  selectedScreen: selectedScreen,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget get walletBody {
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
                    CryptTab(
                      selectWallet: WalletTypeEnum.send,
                      icon: AppData.assets.svg.vector,
                      text: "Send",
                      selectedWalletType: selectedWalletType,
                      borderRadiusGeometry: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    CryptTab(
                      selectWallet: WalletTypeEnum.resive,
                      icon: AppData.assets.svg.recive,
                      text: "Resive",
                      selectedWalletType: selectedWalletType,
                      borderRadiusGeometry: const BorderRadius.only(
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          cryptsWidget,
        ],
      ),
    );
  }

  Widget get cryptsWidget {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
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
          return HomeBottomDialog(
            selectedWalletType: selectedWalletType,
            crypt: crypts[index],
          );
          // return Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Container(
          //         margin: const EdgeInsets.symmetric(vertical: 16),
          //         width: 32,
          //         height: 4,
          //         decoration: BoxDecoration(
          //           color: AppData.colors.middlePurple.withOpacity(0.5),
          //           borderRadius: BorderRadius.circular(
          //             5,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(height: 16),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Container(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 20, vertical: 8),
          //             decoration: BoxDecoration(
          //               border: Border.all(
          //                 color: AppData.colors.middlePurple.withOpacity(0.2),
          //                 width: 1,
          //               ),
          //               borderRadius: BorderRadius.circular(4),
          //             ),
          //             child: Row(
          //               children: [
          //                 AppData.assets.image.crypto(
          //                   value: crypts[index].iconName,
          //                   width: 30,
          //                   height: 30,
          //                 ),
          //                 const SizedBox(width: 16),
          //                 Expanded(
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(crypts[index].name),
          //                       Text(
          //                         crypts[index].shortName,
          //                         style: TextStyle(
          //                           fontSize: 14,
          //                           color: AppData.colors.middlePurple
          //                               .withOpacity(0.6),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 const SizedBox(width: 16),
          //                 CustomIconButton(
          //                   onPressed: () {},
          //                   isPressed: false,
          //                   child: const Icon(
          //                     Icons.add,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           const SizedBox(height: 22),
          //           cryptDiagram,
          //           const SizedBox(height: 26),
          //           const Text(
          //             'Balance',
          //             style: TextStyle(
          //               fontSize: 18,
          //             ),
          //           ),
          //           const SizedBox(height: 16),
          //           Container(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 20, vertical: 13),
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               border: Border.all(
          //                 color: AppData.colors.middlePurple.withOpacity(0.2),
          //                 width: 1,
          //               ),
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             child: Row(
          //               children: [
          //                 AppData.assets.svg.walletPlus,
          //                 const SizedBox(width: 16),
          //                 Expanded(
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       const Text(
          //                         "Available",
          //                       ),
          //                       Row(
          //                         children: [
          //                           Text(
          //                             "${crypts[index].amount} ${crypts[index].shortName}",
          //                             style: TextStyle(
          //                               fontSize: 14,
          //                               color: AppData.colors.middlePurple
          //                                   .withOpacity(0.6),
          //                             ),
          //                           ),
          //                         ],
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //                 const SizedBox(width: 16),
          //                 const Text(
          //                   "\$0,0",
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(height: 20),
          //     ],
          //   ),
          // );
        });
  }

  // Widget get cryptDiagram {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Text(
  //                 'Price',
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //               const SizedBox(height: 5),
  //               Row(
  //                 children: [
  //                   const Text(
  //                     '\$10,945.00 ',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                   Text(
  //                     '+7.5%',
  //                     style: TextStyle(
  //                       fontSize: 10,
  //                       color: AppData.colors.middlePurple,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           Obs(
  //             rvList: [selectedWalletType],
  //             builder: () => Row(
  //               children: [
  //                 CryptTab(
  //                   selectWallet: WalletTypeEnum.send,
  //                   icon: AppData.assets.svg.vector,
  //                   text: "Send",
  //                   selectedWalletType: selectedWalletType,
  //                   borderRadiusGeometry: const BorderRadius.only(
  //                     topLeft: Radius.circular(12),
  //                   ),
  //                 ),
  //                 CryptTab(
  //                   selectWallet: WalletTypeEnum.resive,
  //                   icon: AppData.assets.svg.recive,
  //                   text: "Resive",
  //                   selectedWalletType: selectedWalletType,
  //                   borderRadiusGeometry: const BorderRadius.only(
  //                     topRight: Radius.circular(12),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //       Container(
  //         height: 300,
  //         color: Colors.white,
  //       ),
  //     ],
  //   );
  // }

  Widget get activityBody {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: transactionsLength == 0
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child: const Text(
                "Your activity will appear here!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomIconButton(
                  onPressed: () {},
                  isPressed: false,
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AppData.assets.svg.vector,
                            const SizedBox(width: 16),
                            Column(
                              children: [
                                const Text("Send"),
                                Text(
                                  AppData.utils
                                      .formatText("0xDAdawdawdadadadad6B4"),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppData.colors.middlePurple
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("+0.0800 BTC"),
                            Text(
                              '4 days ago',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppData.colors.middlePurple
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget body(HomeScreenEnum homeScreenEnum) {
    switch (homeScreenEnum) {
      case HomeScreenEnum.wallet:
        return walletBody;

      case HomeScreenEnum.settings:
      case HomeScreenEnum.activity:
        return activityBody;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            topImage,
            const SizedBox(height: 27),
            Obs(
              rvList: [selectedScreen],
              builder: () => body(selectedScreen.value),
            ),
            const SizedBox(height: 27),
          ],
        ),
      ),
    );
  }
}
