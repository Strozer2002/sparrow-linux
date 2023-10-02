import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';

import '../../widgets/gradient_container.dart';
import '../../widgets/main_button.dart';
import 'manage_crypt_bloc.dart';

class ManageCrypt extends StatefulWidget {
  const ManageCrypt({super.key});

  @override
  State<ManageCrypt> createState() => _ManageCryptState();
}

class _ManageCryptState extends ManageCryptBloc {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Manage cryptos",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ), // Prefix icon
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                    ), // Suffix icon

                    hintText: 'Enter your username',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.man),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppData.colors.middlePurple
                                    .withOpacity(0.5),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Switch(
                      value: switchValue,
                      onChanged: (value) {
                        setState(() {
                          switchValue = value;
                        });
                      },
                      activeColor: Colors.white,
                      inactiveThumbColor:
                          AppData.colors.middlePurple.withOpacity(0.5),
                      activeTrackColor: AppData.colors.middlePurple,
                      inactiveTrackColor:
                          AppData.colors.middlePurple.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: MainButton(
          height: 48,
          width: double.infinity,
          onPressed: () => context.go(AppData.routes.setCodeScreen),
          child: const Text(
            "Save",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
