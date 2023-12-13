import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';

import '../../main.dart';
import '../settings/domain/settings_service.dart';

class ThemeDialogWidget extends StatefulWidget {
  const ThemeDialogWidget({super.key});

  @override
  State<ThemeDialogWidget> createState() => _ThemeDialogWidgetState();
}

class _ThemeDialogWidgetState extends State<ThemeDialogWidget> {
  final SettingsService settingsService = SettingsService();
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
                Text("light".tr()),
                Checkbox(
                  value: settingsService.getTheme() == true,
                  onChanged: (value) => setState(() {
                    settingsService.putTheme(true);
                    setTheme.add(settingsService.getTheme()!);
                    context.pop();
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("dark".tr()),
                Checkbox(
                  value: settingsService.getTheme() == false,
                  onChanged: (value) => setState(() {
                    settingsService.putTheme(false);
                    setTheme.add(settingsService.getTheme()!);
                    context.pop();
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
