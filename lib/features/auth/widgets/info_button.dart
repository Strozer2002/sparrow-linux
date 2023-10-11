import 'package:flutter/material.dart';
import 'package:rabby/app_data/app_data.dart';

class InfoButton extends StatefulWidget {
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Widget child;
  final double? height;
  const InfoButton({
    super.key,
    required this.prefixIcon,
    this.suffixIcon,
    this.height = 50,
    required this.child,
  });

  @override
  State<InfoButton> createState() => _InfoButtonState();
}

class _InfoButtonState extends State<InfoButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.prefixIcon,
              const SizedBox(width: 14),
              widget.child,
            ],
          ),
          widget.suffixIcon ?? AppData.assets.svg.chevron,
        ],
      ),
    );
  }
}
