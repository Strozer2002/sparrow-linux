import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/widgets/duartion.dart';

import '../../../app_data/app_data.dart';
import '../../widgets/currency_dialog.dart';
import 'settings_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends SettingsBloc {
  AppBar get appBar {
    return AppBar(
      title: const Text("Settings"),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.key),
                SizedBox(width: 12),
                Text("Lock now"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () => settingsService.relocateChild(),
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.qr_code_scanner),
                SizedBox(width: 12),
                Text("Scan QR"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {},
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.link),
                SizedBox(width: 12),
                Text("Connected Sites"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget get generalSettings {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.key),
                SizedBox(width: 12),
                Text("RPC Node"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {},
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.wb_sunny),
                SizedBox(width: 12),
                Text("Theme"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {},
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.translate),
                SizedBox(width: 12),
                Text("Language"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {},
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.attach_money),
                SizedBox(width: 12),
                Text("Default Currency"),
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
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.volume_down),
                SizedBox(width: 12),
                Text("Sound & Vibration"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget get securitySettings {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.pin_outlined),
                SizedBox(width: 12),
                Text("Change Passcode"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () =>
                context.push(AppData.routes.newPassScreen, extra: true),
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.touch_app_outlined),
                SizedBox(width: 12),
                Text("Touch ID"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {},
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.lock_reset_outlined),
                SizedBox(width: 12),
                Text("App Auto-lock"),
              ],
            ),
            rightPart: Switch(
              value: settingsService.getAutoLock()!,
              onChanged: (value) {
                setState(() {
                  settingsService.putAutoLock(value);
                });
              },
              activeColor: Colors.white,
              inactiveThumbColor: AppData.colors.middlePurple.withOpacity(0.5),
              activeTrackColor: AppData.colors.middlePurple,
              inactiveTrackColor: AppData.colors.middlePurple.withOpacity(0.2),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.timelapse_rounded),
                SizedBox(width: 12),
                Text("Auto-Lock Timer"),
              ],
            ),
            rightPart: Row(
              children: [
                Text(
                  settingsService.getDuration()! > 59
                      ? "${settingsService.getDuration()! ~/ 60} Hours"
                      : "${settingsService.getDuration()} Minutes",
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
            leftPart: const Row(
              children: [
                Icon(Icons.security),
                SizedBox(width: 12),
                Text("Protection"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {},
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.restart_alt),
                SizedBox(width: 12),
                Text("Reset App"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () {
              appService.clearAllBox();
              context.go(AppData.routes.welcomeScreen);
            },
          ),
        ],
      ),
    );
  }

  Widget get alertSettings {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: settingField(
        leftPart: const Row(
          children: [
            Icon(Icons.notifications_outlined),
            SizedBox(width: 12),
            Text("Notification"),
          ],
        ),
        rightPart: AppData.assets.svg.chevron,
        onTap: () => settingsService.relocate(),
      ),
    );
  }

  Widget get aboutSettings {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 12),
                Text("Version"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () => settingsService.relocate(),
          ),
          settingField(
            leftPart: const Row(
              children: [
                Icon(Icons.edit_document),
                SizedBox(width: 12),
                Text("State Logs"),
              ],
            ),
            rightPart: AppData.assets.svg.chevron,
            onTap: () => settingsService.relocate(),
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
          text:
              'This will help support debug any issue you might encounter. Please send to',
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' support@rabby.com',
              style: TextStyle(
                color: AppData.colors.middlePurple,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            const TextSpan(
              text: ' or support only.',
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showCurrencyDialog(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context,
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
                        const Text("Default Currency"),
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
                        const Text("Auto-Lock Timer"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topSettings,
              const SizedBox(height: 24),
              const Text(
                "General",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 18),
              generalSettings,
              const SizedBox(height: 24),
              const Text(
                "Security",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 18),
              securitySettings,
              const SizedBox(height: 24),
              const Text(
                "Alert",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 18),
              alertSettings,
              const SizedBox(height: 24),
              const Text(
                "About",
                style: TextStyle(
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
    );
  }
}
