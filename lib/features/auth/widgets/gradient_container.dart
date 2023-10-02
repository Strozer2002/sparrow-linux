import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  const GradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 136, 171, 255),
            Color.fromARGB(255, 121, 131, 255),
            Color.fromARGB(255, 121, 131, 255)
          ],
        ),
      ),
      child: child,
    );
  }
}
