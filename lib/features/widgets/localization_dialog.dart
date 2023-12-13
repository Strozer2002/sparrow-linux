import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/localization/domain/base/app_locale.dart';
import 'package:rabby/features/localization/domain/localization_extension.dart';
import 'package:reactive_variables/reactive_variables.dart';

class LocalizationDialogWidget extends StatefulWidget {
  const LocalizationDialogWidget({super.key});

  @override
  State<LocalizationDialogWidget> createState() => _ThemeDialogWidgetState();
}

class _ThemeDialogWidgetState extends State<LocalizationDialogWidget> {
  bool value = false;

  late final List<AppLocale> supportedLocaleList = context.supportedAppLocales;

  Rv<int> selectedRadioValue = Rv(1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final currentLocale = context.appLocale;
      selectedRadioValue(supportedLocaleList.indexOf(currentLocale));
    });
  }

  Future<void> onSave(int i) async {
    context.locale;
    selectedRadioValue.value = i;
    await context.setLocale(supportedLocaleList[selectedRadioValue()]);
    if (mounted) {
      context.pop();
    }
  }

  Widget _langCardBuilder({
    required String label,
    required int i,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Checkbox(
              value: supportedLocaleList[selectedRadioValue()].title == label,
              onChanged: (value) => onSave(i),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Obs(
          rvList: [selectedRadioValue],
          builder: () => Theme(
            data: ThemeData(
              unselectedWidgetColor: AppData.colors.gray500,
            ),
            child: Column(
              children: [
                for (var i = 0; i < supportedLocaleList.length; i++)
                  _langCardBuilder(
                    label: supportedLocaleList[i].title,
                    i: i,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
