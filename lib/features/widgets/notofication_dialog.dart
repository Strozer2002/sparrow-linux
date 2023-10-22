import 'package:flutter/material.dart';
import 'package:rabby/app_data/app_data.dart';

class NotificationDialogWidget extends StatefulWidget {
  const NotificationDialogWidget({super.key});

  @override
  State<NotificationDialogWidget> createState() => _ThemeDialogWidgetState();
}

class _ThemeDialogWidgetState extends State<NotificationDialogWidget> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notification"),
                Checkbox(
                  value: value,
                  onChanged: (value) => setState(() {
                    this.value = value!;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
