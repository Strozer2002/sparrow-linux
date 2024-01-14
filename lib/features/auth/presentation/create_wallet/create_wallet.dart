import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/currency/domain/custom_currency.dart';
import 'package:sparrow/features/widgets/custom_button.dart';
import 'package:sparrow/features/widgets/loading_widget.dart';
import 'create_wallet_bloc.dart';

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({super.key});

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends CreateWalletBloc {
  Widget get buttons {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isGeneral = true;
              });
            },
            child: Container(
              width: 160,
              color: isGeneral ? Colors.blue.shade700 : Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppData.assets.svg.tools,
                  const Text(
                    "General",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isGeneral = false;
              });
            },
            child: Container(
              width: 160,
              height: 250,
              color: !isGeneral ? Colors.blue.shade700 : Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppData.assets.svg.server,
                  const Text(
                    "Server",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get body {
    return Row(
      children: [
        buttons,
        buttonsBody,
      ],
    );
  }

  Widget get buttonsBody {
    switch (isGeneral) {
      case true:
        return Container(
          width: 700,
          padding: const EdgeInsets.all(26),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bitcoin",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text("Display unit:"),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white,
                                            AppData.colors.gray200,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        border: Border.all(
                                          color: AppData.colors.gray200,
                                        )),
                                    child: DropdownButton<String>(
                                      iconSize: 24,
                                      elevation: 16,
                                      underline: const SizedBox(),
                                      dropdownColor:
                                          AppData.colors.backgroundColor,
                                      value: displayUnit,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          displayUnit = newValue!;
                                        });
                                      },
                                      items:
                                          displayUnitItems.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("Fee rates source: ")),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white,
                                            AppData.colors.gray200,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        border: Border.all(
                                          color: AppData.colors.gray200,
                                        )),
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(),
                                      dropdownColor:
                                          AppData.colors.backgroundColor,
                                      value: feeRates,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          feeRates = newValue!;
                                        });
                                      },
                                      items: feeRatesItems.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fiat",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("Currency:")),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white,
                                            AppData.colors.gray200,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        border: Border.all(
                                          color: AppData.colors.gray200,
                                        )),
                                    child: DropdownButton<CustomCurrency>(
                                      iconSize: 24,
                                      elevation: 16,
                                      underline: const SizedBox(),
                                      dropdownColor:
                                          AppData.colors.backgroundColor,
                                      value: currency,
                                      onChanged: (CustomCurrency? newValue) {
                                        setState(() {
                                          currency = newValue!;
                                        });
                                      },
                                      items: currencyItems
                                          .map((CustomCurrency value) {
                                        return DropdownMenuItem<CustomCurrency>(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                child: Text("Exchange rate source:")),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white,
                                            AppData.colors.gray200,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        border: Border.all(
                                          color: AppData.colors.gray200,
                                        )),
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(),
                                      dropdownColor:
                                          AppData.colors.backgroundColor,
                                      value: exchange,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          exchange = newValue!;
                                        });
                                      },
                                      items: exchangeItems.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Wallet",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("Load recent wallets:")),
                            Expanded(
                              child: Row(
                                children: [
                                  Switch(
                                    value: isWalletLoad,
                                    onChanged: (bool change) => setState(() {
                                      isWalletLoad = !isWalletLoad;
                                    }),
                                    inactiveThumbColor: AppData.colors.gray300,
                                    trackOutlineColor:
                                        MaterialStateProperty.resolveWith(
                                      (final Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return null;
                                        }
                                        return AppData.colors.gray300;
                                      },
                                    ),
                                  ),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                child: Text("Validate derivations:")),
                            Expanded(
                              child: Row(
                                children: [
                                  Switch(
                                    value: isWalletValidate,
                                    onChanged: (bool change) => setState(() {
                                      isWalletValidate = !isWalletValidate;
                                    }),
                                    inactiveThumbColor: AppData.colors.gray300,
                                    trackOutlineColor:
                                        MaterialStateProperty.resolveWith(
                                      (final Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return null;
                                        }
                                        return AppData.colors.gray300;
                                      },
                                    ),
                                  ),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Coin Selection",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("Group by address:")),
                            Expanded(
                              child: Row(
                                children: [
                                  Switch(
                                    value: isCoinGroup,
                                    onChanged: (bool change) => setState(() {
                                      isCoinGroup = !isCoinGroup;
                                    }),
                                    inactiveThumbColor: AppData.colors.gray300,
                                    trackOutlineColor:
                                        MaterialStateProperty.resolveWith(
                                      (final Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return null;
                                        }
                                        return AppData.colors.gray300;
                                      },
                                    ),
                                  ),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("Allow unconfirmed:")),
                            Expanded(
                              child: Row(
                                children: [
                                  Switch(
                                    value: isCoinAllow,
                                    onChanged: (bool change) => setState(() {
                                      isCoinAllow = !isCoinAllow;
                                    }),
                                    inactiveThumbColor: AppData.colors.gray300,
                                    trackOutlineColor:
                                        MaterialStateProperty.resolveWith(
                                      (final Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return null;
                                        }
                                        return AppData.colors.gray300;
                                      },
                                    ),
                                  ),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("New transactions:")),
                            Expanded(
                              child: Row(
                                children: [
                                  Switch(
                                    value: isNewTx,
                                    onChanged: (bool change) => setState(() {
                                      isNewTx = !isNewTx;
                                    }),
                                    inactiveThumbColor: AppData.colors.gray300,
                                    trackOutlineColor:
                                        MaterialStateProperty.resolveWith(
                                      (final Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return null;
                                        }
                                        return AppData.colors.gray300;
                                      },
                                    ),
                                  ),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("Software updates:")),
                            Expanded(
                              child: Row(
                                children: [
                                  Switch(
                                    value: isSoftware,
                                    onChanged: (bool change) => setState(() {
                                      isSoftware = !isSoftware;
                                    }),
                                    inactiveThumbColor: AppData.colors.gray300,
                                    trackOutlineColor:
                                        MaterialStateProperty.resolveWith(
                                      (final Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return null;
                                        }
                                        return AppData.colors.gray300;
                                      },
                                    ),
                                  ),
                                  const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      case false:
        return Container(
          width: 700,
          padding: const EdgeInsets.all(26),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Server",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Type:"),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {
                                isPublic = null;
                              }),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      isPublic == null
                                          ? AppData.colors.gray400
                                          : AppData.colors.gray200,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  border: Border.all(
                                    color: AppData.colors.gray200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                      child: AppData.assets.svg.switch_yellow,
                                    ),
                                    const Text("Public Server"),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                isPublic = true;
                              }),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      isPublic == true
                                          ? AppData.colors.gray400
                                          : AppData.colors.gray200,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  border: Border.all(
                                    color: AppData.colors.gray200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                      child: AppData.assets.svg.switch_green,
                                    ),
                                    const Text("Bitcoin Core"),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                isPublic = false;
                              }),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      isPublic == false
                                          ? AppData.colors.gray400
                                          : AppData.colors.gray200,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  border: Border.all(
                                    color: AppData.colors.gray200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                      child: AppData.assets.svg.switch_blue,
                                    ),
                                    const Text("Private Electrum"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Public Server",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.yellow,
                                  ),
                                  Text("Warning!"),
                                ],
                              ),
                              Text(
                                  "Using a public server means it can see your transactions."),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("URL:"),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      AppData.colors.gray200,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  border: Border.all(
                                    color: AppData.colors.gray200,
                                  )),
                              child: DropdownButton<String>(
                                iconSize: 24,
                                elevation: 16,
                                underline: const SizedBox(),
                                dropdownColor: AppData.colors.backgroundColor,
                                value: url,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    url = newValue!;
                                  });
                                },
                                items: urlItems.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Use Proxy:"),
                            Switch(
                              value: useProxy,
                              onChanged: (bool change) => setState(() {
                                useProxy = !useProxy;
                              }),
                              inactiveThumbColor: AppData.colors.gray300,
                              trackOutlineColor:
                                  MaterialStateProperty.resolveWith(
                                (final Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return null;
                                  }
                                  return AppData.colors.gray300;
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      default:
        return const Column();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 53),
        color: Colors.white,
        child: isLoading
            ? const SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadingWidget(),
                    Text("Loading wallet"),
                  ],
                ),
              )
            : Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppData.colors.backgroundColor),
                        ),
                        child: body,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomIcon(
                          onPressed: () => context.pop(),
                          child: const Text("Close"),
                        ),
                        const SizedBox(width: 10),
                        CustomIcon(
                          onPressed: init,
                          child: const Text("Create New Wallet"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
