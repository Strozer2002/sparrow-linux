import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/home/widget/qr_modal.dart';

import '../../../app_data/app_data.dart';
import '../../auth/presentation/manage_crypt/domain/crypt.dart';

class ReceiveShowModal extends StatefulWidget {
  final List<Crypt> crypts;
  const ReceiveShowModal({
    super.key,
    required this.crypts,
  });

  @override
  State<ReceiveShowModal> createState() => _ReceiveShowModalState();
}

class _ReceiveShowModalState extends State<ReceiveShowModal> {
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
        color: Colors.white,
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

              hintText: 'Enter your username',
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
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: true,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                width: 32,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppData.colors.middlePurple
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                              ),
                              const QrCodeModal(),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      );
                    });
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
                              '\$${AppData.utils.doubleToTwoValues(filterCrypts[index].amountInCurrency)}',
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
                    const Text(
                      '\$0',
                      style: TextStyle(
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
