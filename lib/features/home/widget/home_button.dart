import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';

import '../domain/home_screen_enum.dart';

class HomeButton extends StatefulWidget {
  final HomeScreenEnum selectedIndex;
  final Rv<HomeScreenEnum> selectedScreen;
  final Widget icon;
  final String? text;
  final EdgeInsetsGeometry? padding;
  const HomeButton({
    super.key,
    required this.selectedIndex,
    required this.icon,
    this.text,
    this.padding,
    required this.selectedScreen,
  });

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.selectedScreen.value = widget.selectedIndex,
      child: Container(
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          border: Border.all(
            color: widget.selectedScreen.value == widget.selectedIndex
                ? Colors.white
                : Colors.white.withOpacity(0.4),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            widget.icon,
            widget.text == null
                ? Container()
                : Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        widget.text!,
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.selectedScreen.value ==
                                  widget.selectedIndex
                              ? Colors.white
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
