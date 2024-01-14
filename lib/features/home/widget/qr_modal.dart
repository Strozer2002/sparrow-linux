import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/auth/domain/auth_service.dart';

class QrCodeModal extends StatefulWidget {
  const QrCodeModal({super.key});

  @override
  State<QrCodeModal> createState() => _QrCodeModalState();
}

class _QrCodeModalState extends State<QrCodeModal> {
  final AuthService authService = AuthService();
  bool isCopy = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                Text(
                  'receive'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            isCopy
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 41, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppData.colors.middlePurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppData.colors.middlePurple.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "Address copied",
                      style: TextStyle(
                        color: AppData.colors.middlePurple.withOpacity(0.8),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          decoration: BoxDecoration(
            color: AppData.colors.nightBottomNavColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppData.colors.middlePurple,
                    ),
                    child: AppData.assets.svg.rabbit(size: 35),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "my_token_address".tr(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "${authService.getAddress()}",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppData.colors.middlePurple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              QrImageView(
                data: authService.getAddress().toString(),
                size: 180,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: authService.getAddress()!),
                ).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("address_was_copied".tr()),
                    ),
                  );
                });
                setState(() {
                  isCopy = true;
                });
              },
              icon: Row(
                children: [
                  Icon(
                    isCopy ? Icons.file_copy_rounded : Icons.file_copy_outlined,
                    color: AppData.colors.middlePurple,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "copy_address".tr(),
                    style: TextStyle(
                      color: AppData.colors.middlePurple.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: authService.getAddress()!),
                );
              },
              icon: Row(
                children: [
                  Icon(
                    Icons.share,
                    color: AppData.colors.middlePurple,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "share_address".tr(),
                    style: TextStyle(
                      color: AppData.colors.middlePurple.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
