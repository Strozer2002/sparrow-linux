import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';
import 'package:rabby/features/auth/repository/auth_repository.dart';
import 'package:rabby/features/diagrammes/domain/model/diagram_model.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../app_data/app_data.dart';
import '../auth/presentation/manage_crypt/domain/crypt.dart';
import '../home/domain/wallet_type_enum.dart';
import '../home/widget/crypt_tab.dart';
import '../home/widget/qr_modal.dart';
import 'icon_button.dart';

class HomeBottomDialog extends StatefulWidget {
  final Rv<WalletTypeEnum> selectedWalletType;
  final Crypt crypt;
  const HomeBottomDialog({
    super.key,
    required this.selectedWalletType,
    required this.crypt,
  });

  @override
  State<HomeBottomDialog> createState() => _HomeBottomDialogState();
}

class _HomeBottomDialogState extends State<HomeBottomDialog> {
  final AuthService authService = AuthService();
  final AuthRepository authRepository = AuthRepository();
  DiagramModel? diagramModel;
  int numberToShow = 0;
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init({String period = "day"}) async {
    final response = await authRepository.periods(
      widget.crypt.tokenAddress,
      period,
    );
    if (response.isSuccess) {
      setState(() {
        diagramModel = DiagramModel(
          last: response.data!.attributes.stats.last,
          max: response.data!.attributes.stats.max,
          min: response.data!.attributes.stats.min,
          points: response.data!.attributes.points,
        );
      });
    }
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
                    Text(
                      '${authService.getSelectCurrency()!.symbol}${diagramModel != null ? AppData.utils.doubleToTwoValues(diagramModel!.last * authService.getSelectCurrency()!.rate) : "0"}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${AppData.utils.doubleToTwoValues(widget.crypt.changesCrypt.absoluteId!)}%',
                      style: TextStyle(
                        fontSize: 10,
                        color: widget.crypt.changesCrypt.absoluteId! < 0
                            ? Colors.red
                            : AppData.colors.middlePurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Obs(
              rvList: [widget.selectedWalletType],
              builder: () => Row(
                children: [
                  CryptTab(
                    onTap: () => log("HI"),
                    selectWallet: WalletTypeEnum.send,
                    icon: AppData.assets.svg.vector,
                    text: "Send",
                    selectedWalletType: widget.selectedWalletType,
                    borderRadiusGeometry: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                  ),
                  CryptTab(
                    onTap: () {
                      context.pop();
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: AppData.colors.nightBgColor,
                          isDismissible: true,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      width: 32,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: AppData.colors.middlePurple
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                    ),
                                    const QrCodeModal(),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    selectWallet: WalletTypeEnum.resive,
                    icon: AppData.assets.svg.recive,
                    text: "Resive",
                    selectedWalletType: widget.selectedWalletType,
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
          color: AppData.colors.nightBottomNavColor,
          child: Column(
            children: [
              diagramModel == null
                  ? Container()
                  : Container(
                      height: 300,
                      padding:
                          const EdgeInsets.only(left: 14, right: 14, top: 16),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          print(diagramModel!.points[index][1] /
                              diagramModel!.max);
                          return Container(
                            margin: EdgeInsets.only(
                              top: 290 *
                                  (1.01 -
                                      (diagramModel!.points[index][1] /
                                          diagramModel!.max)),
                            ),
                            width: 8,
                            color: AppData.colors.middlePurple.withOpacity(0.4),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 4),
                        itemCount: diagramModel!.points.length,
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        numberToShow = 0;
                      });
                      init(period: "day");
                    },
                    icon: Text(
                      "1D",
                      style: TextStyle(
                        color: numberToShow == 0
                            ? AppData.colors.middlePurple
                            : null,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        numberToShow = 1;
                      });
                      init(period: "week");
                    },
                    icon: Text(
                      "1W",
                      style: TextStyle(
                        color: numberToShow == 1
                            ? AppData.colors.middlePurple
                            : null,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        numberToShow = 2;
                      });
                      init(period: "month");
                    },
                    icon: Text(
                      "1M",
                      style: TextStyle(
                        color: numberToShow == 2
                            ? AppData.colors.middlePurple
                            : null,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        numberToShow = 3;
                      });
                      init(period: "year");
                    },
                    icon: Text(
                      "1Y",
                      style: TextStyle(
                        color: numberToShow == 3
                            ? AppData.colors.middlePurple
                            : null,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                      value: widget.crypt.iconName,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.crypt.name),
                          Text(
                            widget.crypt.shortName,
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  AppData.colors.middlePurple.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    CustomIconButton(
                      onPressed: () => context.go(AppData.routes.buyCashScreen),
                      isPressed: false,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                decoration: BoxDecoration(
                  color: AppData.colors.nightBottomNavColor,
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
                                "${AppData.utils.doubleToFourthValues(widget.crypt.amount)} ${widget.crypt.shortName}",
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
                    Text(
                      "${authService.getSelectCurrency()!.symbol}${AppData.utils.doubleToTwoValues(widget.crypt.amountInCurrency * authService.getSelectCurrency()!.rate)}",
                      style: const TextStyle(
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
  }
}
