import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/home/domain/home_screen_enum.dart';
import 'package:rabby/features/home/domain/wallet_type_enum.dart';
import 'package:rabby/features/home/widget/crypt_tab.dart';
import 'package:rabby/features/home/widget/home_button.dart';
import 'package:rabby/features/home/widget/receive_modal.dart';
import 'package:rabby/features/home/widget/send_modal.dart';
import 'package:rabby/features/widgets/home_bottom.dart';
import 'package:rabby/features/widgets/icon_button.dart';
import 'package:rabby/features/widgets/loading_widget.dart';
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
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            AppData.colors.topImageColor,
            BlendMode.darken,
          ),
          image: const AssetImage(
            "assets/layouts/BG2.png",
          ),
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
                  color: authService.getChangesAbsoluteWallet()! < 0
                      ? Colors.red.withOpacity(0.2)
                      : Colors.white.withOpacity(0.2),
                  border: Border.all(
                    color: authService.getChangesAbsoluteWallet()! < 0
                        ? Colors.red.withOpacity(0.4)
                        : Colors.white.withOpacity(0.4),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    AppData.assets.svg.upper(
                      color: authService.getChangesAbsoluteWallet()! < 0
                          ? Colors.red
                          : Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${AppData.utils.doubleToTwoValues(authService.getChangesAbsoluteWallet()!)} %",
                      style: TextStyle(
                        fontSize: 10,
                        color: authService.getChangesAbsoluteWallet()! < 0
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "today_profit".tr(),
                      style: TextStyle(
                        fontSize: 12,
                        color: authService.getChangesAbsoluteWallet()! < 0
                            ? Colors.red.withOpacity(0.8)
                            : Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onReload,
                child: const Icon(
                  Icons.replay_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            "${authService.getSelectCurrency()!.symbol} ${AppData.utils.doubleToTwoValues(authService.getSelectCurrency()!.rate * authService.getWallet()!)}",
            style: const TextStyle(
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
                      text: "wallet".tr(),
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
                      text: "activity".tr(),
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

  Widget get walletHead {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'wallet'.tr(),
                style: const TextStyle(
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
                      text: "send".tr(),
                      selectedWalletType: selectedWalletType,
                      borderRadiusGeometry: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                      ),
                      onTap: () => showSendBottomDialog(),
                    ),
                    CryptTab(
                      onTap: () => showReceiveBottomDialog(),
                      selectWallet: WalletTypeEnum.receive,
                      icon: AppData.assets.svg.recive,
                      text: "receive".tr(),
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
        color: AppData.colors.nightBottomNavColor,
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
                      Text(AppData.utils
                          .doubleToFourthValues(crypts[index].amount)),
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
                    Text(
                        "${authService.getSelectCurrency()!.symbol}${AppData.utils.doubleToTwoValues(crypts[index].amountInCurrency * authService.getSelectCurrency()!.rate)}"),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: crypts[index].changesCrypt.absoluteId! < 0
                            ? Colors.red.withOpacity(0.2)
                            : AppData.colors.middlePurple.withOpacity(0.2),
                      ),
                      child: Text(
                        "${AppData.utils.doubleToTwoValues(crypts[index].changesCrypt.absoluteId!)}%",
                        style: TextStyle(
                          fontSize: 10,
                          color: crypts[index].changesCrypt.absoluteId! < 0
                              ? Colors.red.withOpacity(0.6)
                              : AppData.colors.middlePurple.withOpacity(0.6),
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
        backgroundColor: AppData.colors.nightBgColor,
        isDismissible: true,
        builder: (BuildContext context) {
          return HomeBottomDialog(
            selectedWalletType: selectedWalletType,
            crypt: crypts[index],
          );
        });
  }

  Future<dynamic> showReceiveBottomDialog() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppData.colors.nightBgColor,
        isDismissible: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        'choose_receive'.tr(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ReceiveShowModal(crypts: crypts),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> showSendBottomDialog() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppData.colors.nightBgColor,
        isDismissible: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        'choose_send'.tr(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SendShowModal(crypts: crypts),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        });
  }

  Widget get activityBody {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: transactionsLength == 0
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppData.colors.nightBottomNavColor,
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child: Text(
                "yout_activity".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                  itemCount: authService.getTransactions()!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            operationType(
                              transaction:
                                  authService.getTransactions()![index],
                              send: AppData.assets.svg.send(),
                              receive: AppData.assets.svg.receive(),
                              swap: AppData.assets.svg.swap(),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                operationType(
                                  transaction:
                                      authService.getTransactions()![index],
                                  send: Text("send".tr()),
                                  receive: Text("receive".tr()),
                                  swap: Text("swap".tr()),
                                ),
                                Text(
                                  AppData.utils.formatAddressWallet(
                                    operationTypeString(
                                      transaction:
                                          authService.getTransactions()![index],
                                      send: authService
                                          .getTransactions()![index]
                                          .sentTo,
                                      receive: authService
                                          .getTransactions()![index]
                                          .sentFrom,
                                      swap: authService
                                          .getTransactions()![index]
                                          .sentTo,
                                    ),
                                  ),
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              operationTypeString(
                                transaction:
                                    authService.getTransactions()![index],
                                send:
                                    "-${AppData.utils.doubleToFourthValues(authService.getTransactions()![index].price)} ${authService.getTransactions()![index].cryptSymbol}",
                                receive:
                                    "+${AppData.utils.doubleToFourthValues(authService.getTransactions()![index].price)} ${authService.getTransactions()![index].cryptSymbol}",
                                swap:
                                    "+${AppData.utils.doubleToFourthValues(authService.getTransactions()![index].price)} ${authService.getTransactions()![index].cryptSymbol}",
                              ),
                            ),
                            Text(
                              AppData.utils.formatDateTime(
                                authService.getTransactions()![index].minedAt,
                              ),
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
        return walletHead;

      case HomeScreenEnum.settings:
      case HomeScreenEnum.activity:
        return activityBody;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: isReload
          ? const LoadingWidget()
          : Scaffold(
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
            ),
    );
  }
}
