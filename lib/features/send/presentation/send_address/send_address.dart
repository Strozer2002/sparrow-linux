import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';
import '../../../auth/widgets/main_button.dart';
import 'send_bloc.dart';

class SendAddressScreen extends StatefulWidget {
  final String crypt;
  const SendAddressScreen({
    super.key,
    required this.crypt,
  });

  @override
  State<SendAddressScreen> createState() => _SendAddressScreenState();
}

class _SendAddressScreenState extends SendBloc {
  AppBar get appBar {
    return AppBar(
      title: Text("send_to_address".tr()),
      leading: IconButton(
        onPressed: () => context.go(AppData.routes.homeScreen),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get bottomButton {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 82, vertical: 20),
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppData.colors.middlePurple.withOpacity(0.5),
          ),
        ),
      ),
      child: MainButton(
        gradient: addressCtrl.text.isEmpty
            ? LinearGradient(colors: [
                AppData.colors.middlePurple.withOpacity(0.5),
                AppData.colors.middlePurple.withOpacity(0.5)
              ])
            : LinearGradient(colors: [
                AppData.colors.middlePurple,
                AppData.colors.middlePurple,
              ]),
        onPressed: addressCtrl.text.isEmpty
            ? null
            : () => context.push(
                  AppData.routes.transactionScreen,
                  extra: [addressCtrl.text, widget.crypt],
                ),
        child: Text(
          "preview_transaction".tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  controller: addressCtrl,
                  onChanged: (value) => setState(() {
                    addressCtrl.text = value;
                  }),
                  onSubmitted: (value) {},
                  decoration: InputDecoration(
                    hintText: 'address'.tr(),
                    labelText: 'address'.tr(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppData.colors.middlePurple,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppData.colors.middlePurple,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                IconButton(
                  onPressed: () async {
                    ClipboardData? data = await Clipboard.getData('text/plain');
                    setState(() {
                      addressCtrl.text = data!.text!;
                    });
                  },
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.content_paste_go,
                        color: AppData.colors.middlePurple,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "paste_from_clipboard".tr(),
                        style: TextStyle(
                          color: AppData.colors.middlePurple.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            addressCtrl.text.isEmpty
                ? Container()
                : Text(
                    "check_the_address".tr(),
                    style: TextStyle(
                      color: AppData.colors.middlePurple.withOpacity(0.8),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: bottomButton,
    );
  }
}
