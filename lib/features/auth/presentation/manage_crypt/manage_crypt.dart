import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';

import '../../widgets/main_button.dart';
import 'manage_crypt_bloc.dart';

class ManageCrypt extends StatefulWidget {
  const ManageCrypt({super.key});

  @override
  State<ManageCrypt> createState() => _ManageCryptState();
}

class _ManageCryptState extends ManageCryptBloc {
  AppBar get appBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text(
        "Manage cryptos",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget get inputText {
    return Padding(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              inputText,
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: icons.length,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            icons[index].icon,
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${icons[index].name[0].toUpperCase()}${icons[index].name.substring(1)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '0 ${icons[index].shortName.toUpperCase()}',
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
                          value: icons[index].isChoose,
                          onChanged: (value) {
                            setState(() {
                              icons[index].isChoose = value;
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
                ),
              ),
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
