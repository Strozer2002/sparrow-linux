import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../../../app_data/app_data.dart';
import '../domain/wallet_type_enum.dart';

class CryptTab extends StatefulWidget {
  final WalletTypeEnum selectWallet;
  final Widget icon;
  final String text;
  final Function onTap;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final Rv<WalletTypeEnum> selectedWalletType;
  const CryptTab({
    super.key,
    required this.selectWallet,
    required this.icon,
    required this.text,
    this.borderRadiusGeometry,
    required this.selectedWalletType,
    required this.onTap,
  });

  @override
  State<CryptTab> createState() => _CryptTabState();
}

class _CryptTabState extends State<CryptTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectedWalletType.value = widget.selectWallet;
        widget.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.selectedWalletType.value == widget.selectWallet
              ? AppData.colors.nightBottomNavColor
              : null,
          border: widget.selectedWalletType.value == widget.selectWallet
              ? null
              : Border.all(
                  color: AppData.colors.middlePurple.withOpacity(0.4),
                  width: 1,
                ),
          borderRadius: widget.borderRadiusGeometry,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: widget.selectedWalletType.value == widget.selectWallet
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
              widget.icon,
              const SizedBox(width: 8),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 14,
                  color: widget.selectedWalletType.value == widget.selectWallet
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
}
