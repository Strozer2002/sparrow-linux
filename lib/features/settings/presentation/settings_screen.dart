import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/localization/domain/localization_extension.dart';
import 'package:rabby/features/widgets/duartion.dart';
import 'package:rabby/features/widgets/localization_dialog.dart';

import '../../../app_data/app_data.dart';
import '../../protection/widget/protection_sheet.dart';
import '../../widgets/currency_dialog.dart';
import '../../widgets/notofication_dialog.dart';
import '../../widgets/theme_dialog.dart';
import 'settings_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends SettingsBloc {
  AppBar get appBar {
    return AppBar(
      title: Text("settings".tr()),
      leading: IconButton(
        onPressed: () {
          context.go(AppData.routes.homeScreen);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget settingField({
    required Widget leftPart,
    required Widget rightPart,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftPart,
            rightPart,
          ],
        ),
      ),
    );
  }

  Widget get topSettings {
    return Container(
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.key),
                const SizedBox(width: 12),
                Text("lock_now".tr()),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () => settingsService.relocateChild(),
          ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.qr_code_scanner),
                const SizedBox(width: 12),
                Text("scan_qr".tr()),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () => context.push(AppData.routes.qrScanScreen),
          ),
          // settingField(
          //   leftPart: const Row(
          //     children: [
          //       Icon(Icons.link),
          //       SizedBox(width: 12),
          //       Text("Connected Sites"),
          //     ],
          //   ),
          //   rightPart: AppData.assets.svg.chevron,
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Widget get generalSettings {
    return Container(
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          // settingField(
          //   leftPart: const Row(
          //     children: [
          //       Icon(Icons.key),
          //       SizedBox(width: 12),
          //       Text("RPC Node"),
          //     ],
          //   ),
          //   rightPart: AppData.assets.svg.chevron,
          //   onTap: () {},
          // ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.wb_sunny),
                const SizedBox(width: 12),
                Text("theme".tr()),
              ],
            ),
            rightPart: Row(
              children: [
                Text(settingsService.getTheme()! ? "light".tr() : "dark".tr()),
                const SizedBox(width: 8),
                AppData.assets.svg.chevron,
              ],
            ),
            onTap: () => showThemeDialog(context),
          ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.translate),
                const SizedBox(width: 12),
                Text("language".tr()),
              ],
            ),
            rightPart: Row(
              children: [
                Text(context.appLocale.title),
                AppData.assets.svg.chevron,
              ],
            ),
            onTap: () => showLocalizationDialog(context),
          ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.attach_money),
                const SizedBox(width: 12),
                Text("default_currency".tr()),
              ],
            ),
            rightPart: Row(
              children: [
                Text(authService.getSelectCurrency()!.name),
                const SizedBox(width: 8),
                AppData.assets.svg.chevron,
              ],
            ),
            onTap: () => showCurrencyDialog(context),
          ),
          // settingField(
          //   leftPart: const Row(
          //     children: [
          //       Icon(Icons.volume_down),
          //       SizedBox(width: 12),
          //       Text("Sound & Vibration"),
          //     ],
          //   ),
          //   rightPart: AppData.assets.svg.chevron,
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Widget get securitySettings {
    return Container(
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.pin_outlined),
                const SizedBox(width: 12),
                Text("change_passcode".tr()),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () =>
                context.push(AppData.routes.newPassScreen, extra: true),
          ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.touch_app_outlined),
                const SizedBox(width: 12),
                Text("touch_id".tr()),
              ],
            ),
            rightPart: SizedBox(
              height: 32,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  value: settingsService.getTouchId()!,
                  onChanged: (value) {
                    setState(() {
                      settingsService.putTouchId(value);
                    });
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor:
                      AppData.colors.middlePurple.withOpacity(0.5),
                  activeTrackColor: AppData.colors.middlePurple,
                  inactiveTrackColor:
                      AppData.colors.middlePurple.withOpacity(0.2),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.lock_reset_outlined),
                const SizedBox(width: 12),
                Text("app_auto-lock".tr()),
              ],
            ),
            rightPart: SizedBox(
              height: 32,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  value: settingsService.getAutoLock()!,
                  onChanged: (value) {
                    setState(() {
                      settingsService.putAutoLock(value);
                    });
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor:
                      AppData.colors.middlePurple.withOpacity(0.5),
                  activeTrackColor: AppData.colors.middlePurple,
                  inactiveTrackColor:
                      AppData.colors.middlePurple.withOpacity(0.2),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.timelapse_rounded),
                const SizedBox(width: 12),
                Text("auto-lock_timer".tr()),
              ],
            ),
            rightPart: Row(
              children: [
                Text(
                  settingsService.getDuration()! > 59
                      ? "${settingsService.getDuration()! ~/ 60} ${"hours".tr()}"
                      : "${settingsService.getDuration()} ${"minutes".tr()}",
                  style: TextStyle(
                    color: AppData.colors.middlePurple,
                  ),
                ),
                const SizedBox(width: 12),
                AppData.assets.svg.chevron,
              ],
            ),
            onTap: () => showAutoLockDialog(context),
          ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.security),
                const SizedBox(width: 12),
                Text("protection".tr()),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () => showProtectionDialog(context),
          ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.restart_alt),
                const SizedBox(width: 12),
                Text("reset_app".tr()),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {
              showAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget get alertSettings {
    return Container(
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: settingField(
        leftPart: Row(
          children: [
            const Icon(Icons.notifications_outlined),
            const SizedBox(width: 12),
            Text("notification".tr()),
          ],
        ),
        rightPart: AppData.assets.svg.chevron,
        onTap: () => showNotificationDialog(context),
      ),
    );
  }

  Widget get aboutSettings {
    return Container(
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.settings),
                const SizedBox(width: 12),
                Text("version".tr()),
              ],
            ),
            rightPart: Text(
              "1.0.0-2022010100",
              style: TextStyle(
                color: AppData.colors.middlePurple,
              ),
            ),
          ),
          settingField(
            leftPart: Row(
              children: [
                const Icon(Icons.edit_document),
                const SizedBox(width: 12),
                Text("state_logs".tr()),
              ],
            ),
            rightPart: Text(
              "export".tr(),
              style: TextStyle(
                color: AppData.colors.middlePurple,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget get text {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'this_will_hope'.tr(),
          style: TextStyle(
            fontSize: 10,
            color: AppData.colors.textColor,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' support@rabby.com',
              style: TextStyle(
                color: AppData.colors.middlePurple,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(
              text: ' ${'or_support_only'.tr()}',
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showCurrencyDialog(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context,
        backgroundColor: AppData.colors.nightBgColor,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppData.colors.middlePurple.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {});
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text("default_currency".tr()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const CurrencyDialogWidget(),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          );
        });

    if (result == null && mounted) {
      setState(() {});
    }
  }

  Future<dynamic> showAutoLockDialog(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context,
        backgroundColor: AppData.colors.nightBgColor,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppData.colors.middlePurple.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text("auto-lock_timer".tr()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const DurationWidget(),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          );
        });

    if (result == null) {
      setState(() {});
    }
  }

  Future<dynamic> showThemeDialog(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context,
        backgroundColor: AppData.colors.nightBgColor,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppData.colors.middlePurple.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text("theme".tr()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const ThemeDialogWidget(),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          );
        });

    if (result == null) {
      setState(() {});
    }
  }

  Future<dynamic> showProtectionDialog(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context,
        backgroundColor: AppData.colors.nightBgColor,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppData.colors.middlePurple.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text("protection".tr()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const ProtectionSheetWidget(),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          );
        });

    if (result == null) {
      setState(() {});
    }
  }

  Future<dynamic> showNotificationDialog(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context,
        backgroundColor: AppData.colors.nightBgColor,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppData.colors.middlePurple.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text("notification".tr()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const NotificationDialogWidget(),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          );
        });

    if (result == null) {
      setState(() {});
    }
  }

  Future<dynamic> showLocalizationDialog(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context,
        backgroundColor: AppData.colors.nightBgColor,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppData.colors.middlePurple.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text("language".tr()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const LocalizationDialogWidget(),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          );
        });

    if (result == null) {
      setState(() {});
    }
  }

  void showAlertDialog(BuildContext context) {
    final TextEditingController resetCtrl = TextEditingController();
    Widget cancelButton = TextButton(
      child: Text(
        "cancel".tr(),
        style: TextStyle(
          color: AppData.colors.middlePurple,
        ),
      ),
      onPressed: () {
        context.pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "continue".tr(),
        style: TextStyle(
          color: AppData.colors.middlePurple,
        ),
      ),
      onPressed: () {
        if (resetCtrl.text.toLowerCase() == "reset") {
          context.pop();
          appService.clearAllBox();
          context.go(AppData.routes.welcomeScreen);
        } else {
          context.pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: AppData.colors.nightBgColor,
      title: Center(
        child: Column(
          children: [
            const Icon(Icons.restart_alt),
            Text("reset_app".tr()),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("reset_wallet_description".tr()),
          const SizedBox(height: 10),
          TextField(
            controller: resetCtrl,
            onChanged: (value) => setState(() {
              resetCtrl.text = value;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topSettings,
                const SizedBox(height: 24),
                Text(
                  "general".tr(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 18),
                generalSettings,
                const SizedBox(height: 24),
                Text(
                  "security".tr(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 18),
                securitySettings,
                const SizedBox(height: 24),
                Text(
                  "alert".tr(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 18),
                alertSettings,
                const SizedBox(height: 24),
                Text(
                  "about".tr(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 18),
                aboutSettings,
                const SizedBox(height: 34),
                text,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
