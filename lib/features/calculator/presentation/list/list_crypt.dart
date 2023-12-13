import 'package:flutter/material.dart';
import 'package:rabby/app_data/app_data.dart';

import 'list_crypt_bloc.dart';

class ListCryptsScreen extends StatefulWidget {
  const ListCryptsScreen({super.key});

  @override
  State<ListCryptsScreen> createState() => _ListCryptsScreenState();
}

class _ListCryptsScreenState extends ListCryptsBloc {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppData.colors.middlePurple,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              crypts![index].name,
                              style: TextStyle(
                                fontSize: 24,
                                color: AppData.colors.middleDarkPurple,
                              ),
                            ),
                            Text(
                              "${AppData.utils.doubleToTwoValues(crypts![index].price)}  ${crypts![index].shortName}",
                              style: TextStyle(
                                fontSize: 24,
                                color: AppData.colors.middleDarkPurple,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              calculateService.updateChooseCalculateCrypt(
                                crypts![index].name,
                                !crypts![index].isChoose,
                              );
                            });
                          },
                          icon: Icon(
                            crypts![index].isChoose
                                ? Icons.star
                                : Icons.star_border_outlined,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 20),
                itemCount: crypts!.length,
              ),
            ),
    );
  }
}
