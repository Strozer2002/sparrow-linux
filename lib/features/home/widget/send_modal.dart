import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';

import '../../../app_data/app_data.dart';
import '../../auth/presentation/manage_crypt/domain/crypt.dart';

class SendShowModal extends StatefulWidget {
  final List<Crypt> crypts;
  const SendShowModal({
    super.key,
    required this.crypts,
  });

  @override
  State<SendShowModal> createState() => _ReceiveShowModalState();
}

class _ReceiveShowModalState extends State<SendShowModal> {
  final AuthService authService = AuthService();
  List<Crypt> filterCrypts = [];
  String searchQuery = '';

  @override
  void initState() {
    filterCrypts = widget.crypts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppData.colors.nightBottomNavColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          TextField(
            onChanged: (query) {
              setState(() {
                searchQuery = query;
                filterCrypts = widget.crypts
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

              hintText: 'Enter crypt username',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: filterCrypts.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                context.pop();
                context.go(
                  AppData.routes.sendScreen,
                  extra: filterCrypts[index].name,
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AppData.assets.image.crypto(
                          value: filterCrypts[index].iconName,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filterCrypts[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${authService.getSelectCurrency()!.symbol}${AppData.utils.doubleToTwoValues(filterCrypts[index].amountInCurrency * authService.getSelectCurrency()!.rate)}',
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
                    Text(
                      '${authService.getSelectCurrency()!.symbol}0',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
