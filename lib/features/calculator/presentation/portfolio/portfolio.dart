import 'package:flutter/material.dart';
import 'package:rabby/app_data/app_data.dart';

import 'portfolio_bloc.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends PortfolioBloc {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crypts!.isEmpty
          ? Center(
              child: Text(
                "Your list is empty",
                style:
                    TextStyle(fontSize: 24, color: AppData.colors.middlePurple),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  // Controllers
                  final TextEditingController moneyController =
                      TextEditingController();
                  final TextEditingController cryptController =
                      TextEditingController();
                  return Container(
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
                              const SizedBox(height: 20),
                              Text(
                                crypts![index].name,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: AppData.colors.middleDarkPurple,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: TextField(
                                          onChanged: (value) {
                                            moneyController.text = value;
                                            cryptController.text =
                                                AppData.utils.doubleToTwoValues(
                                              (double.parse(
                                                      moneyController.text) *
                                                  crypts![index].price),
                                            );
                                          },
                                          controller: moneyController,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "\$",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              AppData.colors.middleDarkPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: TextField(
                                          onChanged: (value) {
                                            cryptController.text = value;
                                            moneyController.text =
                                                AppData.utils.doubleToTwoValues(
                                              (double.parse(
                                                      cryptController.text) /
                                                  crypts![index].price),
                                            );
                                          },
                                          controller: cryptController,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        crypts![index].shortName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              AppData.colors.middleDarkPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                calculateService.updateChooseCalculateCrypt(
                                  crypts![index].name,
                                  !crypts![index].isChoose,
                                );
                                crypts = calculateService
                                    .getFavoriteCalculateCrypts()
                                    ?.calculate;
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
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 20),
                itemCount: crypts!.length,
              ),
            ),
    );
  }
}
