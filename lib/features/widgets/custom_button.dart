import 'package:flutter/material.dart';
import 'package:sparrow/app_data/app_data.dart';

class CustomIcon extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const CustomIcon({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width = 140,
    this.height = 44.0,
    this.gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white,
        Color.fromARGB(255, 238, 238, 238),
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.white,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(
              color: AppData.colors.backgroundColor.withOpacity(0.7),
              width: 1,
            ),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
