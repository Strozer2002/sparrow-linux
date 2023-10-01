import 'package:flutter/material.dart';

import '../../../app_data/app_data.dart';

class Option extends StatelessWidget {
  final String text;
  const Option({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: AppData.colors.middlePurple.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(width: 36),
          AppData.assets.svg.star()
        ],
      ),
    );
  }
}
