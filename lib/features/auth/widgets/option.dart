import 'package:flutter/material.dart';

import '../../../app_data/app_data.dart';

class Option extends StatelessWidget {
  final Color? bgColor;
  final Color? borderColor;
  final Widget child;
  final Gradient? gradient;
  const Option({
    super.key,
    this.bgColor = Colors.white,
    required this.child,
    this.borderColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          width: 1,
          color: borderColor ?? AppData.colors.middlePurple.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(13),
        gradient: gradient,
      ),
      child: Row(
        children: [
          Expanded(
            child: child,
          ),
          const SizedBox(width: 36),
          AppData.assets.svg.star(color: borderColor)
        ],
      ),
    );
  }
}
