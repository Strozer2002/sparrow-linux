import 'package:flutter/material.dart';

class ProfileSettingsButton extends StatefulWidget {
  final Widget icon;

  final Widget text;

  final void Function()? onTap;

  const ProfileSettingsButton({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  State<ProfileSettingsButton> createState() => _ProfileSettingsButtonState();
}

class _ProfileSettingsButtonState extends State<ProfileSettingsButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () => print('Tap setting button'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: Colors.white,
        child: Row(
          children: [
            widget.icon,
            const SizedBox(width: 20),
            Expanded(child: widget.text),
          ],
        ),
      ),
    );
  }
}
