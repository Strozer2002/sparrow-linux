import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../app_data/app_data.dart';
import '../auth/presentation/manage_crypt/domain/crypt.dart';
import '../home/domain/wallet_type_enum.dart';
import '../home/widget/crypt_tab.dart';
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
              rvList: [widget.selectedWalletType],
              builder: () => Row(
                children: [
                  CryptTab(
                    selectWallet: WalletTypeEnum.send,
                    icon: AppData.assets.svg.vector,
                    text: "Send",
                    selectedWalletType: widget.selectedWalletType,
                    borderRadiusGeometry: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                    ),
                  ),
                  CryptTab(
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
          height: 300,
          color: Colors.white,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
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
                                "${widget.crypt.amount} ${widget.crypt.shortName}",
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
  }
}
