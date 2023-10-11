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
      title: const Text(
        "Manage cryptos",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          if (settingsService.getPassCode() != null) {
            context.go(AppData.routes.homeScreen);
          } else {
            context.pop();
          }
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get inputText {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (query) {
          setState(() {
            searchQuery = query;
            filterCrypts = crypts!
                .where((crypt) => crypt.name
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .toList();
          });
        },
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
            color: AppData.colors.nightBottomNavColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              inputText,
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filterCrypts!.length,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AppData.assets.image.crypto(
                              value: filterCrypts![index].iconName,
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filterCrypts![index].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${filterCrypts![index].amount} ${filterCrypts![index].shortName}',
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
                          value: filterCrypts![index].isChoose,
                          onChanged: (value) {
                            setState(() {
                              filterCrypts![index].isChoose = value;
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
          onPressed: onSave,
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
