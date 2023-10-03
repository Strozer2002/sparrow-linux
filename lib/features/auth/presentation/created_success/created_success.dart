import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_data/app_data.dart';
import '../../widgets/main_button.dart';
import 'created_succes_bloc.dart';

class CreatedSuccess extends StatefulWidget {
  const CreatedSuccess({super.key});

  @override
  State<CreatedSuccess> createState() => _CreatedSuccessState();
}

class _CreatedSuccessState extends CreatedSuccessBloc {
  Widget get topImage {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/layouts/BG2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 75),
          AppData.assets.image.party(),
          const SizedBox(height: 12),
          const Text(
            "Created Successfully",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 49),
        ],
      ),
    );
  }

  Widget get bottomButton {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 82, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppData.colors.middlePurple.withOpacity(0.5),
          ),
        ),
      ),
      child: MainButton(
        onPressed: () => context.push(AppData.routes.createWalletScreenScreen),
        child: const Text("Done"),
      ),
    );
  }

  Widget get phrase {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Seed phrase 1",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppData.utils.formatText(authService.getUser()!.address),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppData.colors.middlePurple,
                      ),
                    ),
                    const SizedBox(width: 6),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                                text: authService.getUser()!.address))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Address was copied"),
                            ),
                          );
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.copy_rounded,
                            color: AppData.colors.middlePurple,
                            size: 15,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: AppData.assets.image.pen()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topImage,
          const SizedBox(height: 34),
          phrase,
        ],
      ),
      bottomSheet: bottomButton,
    );
  }
}
