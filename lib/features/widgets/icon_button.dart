import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sparrow/app_data/app_data.dart';

class CustomIconButton extends StatefulWidget {
  final Function()? onPressed;
  final bool isPressed;
  final Widget child;
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.isPressed,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.isPressed
              ? AppData.colors.middlePurple.withOpacity(0.2)
              : AppData.colors.middlePurple,
          borderRadius: BorderRadius.circular(8),
          boxShadow: widget.isPressed
              ? null
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Color of the shadow
                    spreadRadius: 4, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // Offset in the x, y axis
                  ),
                ],
        ),
        child: widget.child,
      ),
    );
  }
}
