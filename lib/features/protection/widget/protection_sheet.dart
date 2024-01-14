import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sparrow/app_data/app_data.dart';

import '../../settings/domain/settings_service.dart';

class ProtectionSheetWidget extends StatefulWidget {
  const ProtectionSheetWidget({super.key});

  @override
  State<ProtectionSheetWidget> createState() => _ThemeDialogWidgetState();
}

class _ThemeDialogWidgetState extends State<ProtectionSheetWidget> {
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
                Text("create_transaction".tr()),
                Checkbox(
                  value: settingsService.getConfirmTransaction() == true,
                  onChanged: (value) => setState(() {
                    settingsService.putConfirmTransaction(
                      !settingsService.getConfirmTransaction()!,
                    );
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
