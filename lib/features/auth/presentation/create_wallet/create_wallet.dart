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
        Expanded(child: buttonsBody),
      ],
    );
  }

  Widget get buttonsBody {
    switch (isGeneral) {
      case true:
        return SingleChildScrollView(
          child: Container(
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
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
                                        items: displayUnitItems
                                            .map((String value) {
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        underline: const SizedBox(),
                                        dropdownColor:
                                            AppData.colors.backgroundColor,
                                        value: feeRates,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            feeRates = newValue!;
                                          });
                                        },
                                        items:
                                            feeRatesItems.map((String value) {
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
                const SizedBox(height: 10),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
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
                                          return DropdownMenuItem<
                                              CustomCurrency>(
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        underline: const SizedBox(),
                                        dropdownColor:
                                            AppData.colors.backgroundColor,
                                        value: exchange,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            exchange = newValue!;
                                          });
                                        },
                                        items:
                                            exchangeItems.map((String value) {
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
                const SizedBox(height: 10),
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
                              const Expanded(
                                  child: Text("Load recent wallets:")),
                              Expanded(
                                child: Row(
                                  children: [
                                    Switch(
                                      value: isWalletLoad,
                                      onChanged: (bool change) => setState(() {
                                        isWalletLoad = !isWalletLoad;
                                      }),
                                      inactiveThumbColor:
                                          AppData.colors.gray300,
                                      trackOutlineColor:
                                          MaterialStateProperty.resolveWith(
                                        (final Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
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
                                      inactiveThumbColor:
                                          AppData.colors.gray300,
                                      trackOutlineColor:
                                          MaterialStateProperty.resolveWith(
                                        (final Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
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
                const SizedBox(height: 10),
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
                                      inactiveThumbColor:
                                          AppData.colors.gray300,
                                      trackOutlineColor:
                                          MaterialStateProperty.resolveWith(
                                        (final Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
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
                                      inactiveThumbColor:
                                          AppData.colors.gray300,
                                      trackOutlineColor:
                                          MaterialStateProperty.resolveWith(
                                        (final Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
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
                const SizedBox(height: 10),
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
                                      inactiveThumbColor:
                                          AppData.colors.gray300,
                                      trackOutlineColor:
                                          MaterialStateProperty.resolveWith(
                                        (final Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
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
                                      inactiveThumbColor:
                                          AppData.colors.gray300,
                                      trackOutlineColor:
                                          MaterialStateProperty.resolveWith(
                                        (final Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
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

  Widget get phrases {
    return Container(
      padding: const EdgeInsets.only(top: 2, right: 5),
      child: Column(
        children: [
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 25,
              mainAxisSpacing: 10,
              childAspectRatio: 5 / 1,
            ),
            itemBuilder: (context, index) => Row(
              children: [
                Text(
                  index < 9 ? "   ${index + 1}." : "${index + 1}.",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          controllers[index].text = value;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          mnemonicList[index] = value;
                          controllers[index].text = '';
                        });
                      },
                      controller: controllers[index],
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        label: Text(
                          " ${mnemonicList.length <= index ? "" : mnemonicList[index]}",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppData.colors.backgroundColor, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            itemCount: mnemonicCount,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text("Passphrase:"),
              const SizedBox(width: 5),
              SizedBox(
                width: 300,
                height: 30,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      phraseCtrl.text = value;
                    });
                  },
                  controller: phraseCtrl,
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppData.colors.backgroundColor, width: 1),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIcon(
                onPressed: () => generateNew(),
                child: const Text("General New"),
              ),
              CustomIcon(
                onPressed: () => import(),
                child: const Text("Create Keystore"),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            height: 1,
            color: AppData.colors.backgroundColor,
          ),
        ],
      ),
    );
  }

  Future<dynamic> showBottomDialog() {
    return showDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.5),
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          content: Container(
            height: 600,
            decoration: BoxDecoration(
              border: Border.all(color: AppData.colors.backgroundColor),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 172,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppData.assets.svg.import(color: Colors.white),
                      const Text(
                        "Software Wallet",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 600,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => setState(() {
                                isViewMnemonic = !isViewMnemonic;
                                context.pop();
                                showBottomDialog();
                              }),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppData.assets.svg.key,
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Mnemonic Words (BIP39)"),
                                        Row(
                                          children: [
                                            Text(
                                              "Create or enter seed",
                                              style: TextStyle(
                                                color: AppData
                                                    .colors.backgroundColor,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () => setState(() {
                                                isViewMnemonic =
                                                    !isViewMnemonic;
                                                context.pop();
                                                showBottomDialog();
                                              }),
                                              child: const Text("Details"),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
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
                                    child: DropdownButton<int>(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      iconSize: 24,
                                      elevation: 16,
                                      underline: const SizedBox(),
                                      dropdownColor:
                                          AppData.colors.backgroundColor,
                                      value: mnemonicCount,
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          isViewMnemonic = true;
                                          mnemonicCount = newValue!;
                                          mnemonicList =
                                              List.filled(mnemonicCount, "");
                                          controllers = List.generate(
                                            mnemonicCount,
                                            (index) => TextEditingController(),
                                          );

                                          context.pop();
                                          showBottomDialog();
                                        });
                                      },
                                      items: possibleCount.map((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text("Use $value words"),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: AppData.colors.backgroundColor,
                          ),
                          isViewMnemonic ? phrases : Container(),
                          const SizedBox(height: 20),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => setState(() {
                                isViewPrivateKey = !isViewPrivateKey;
                                context.pop();
                                showBottomDialog();
                              }),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppData.assets.svg.key,
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                            "Master Private Key (BIP32)"),
                                        Row(
                                          children: [
                                            Text(
                                              "Extended key import",
                                              style: TextStyle(
                                                color: AppData
                                                    .colors.backgroundColor,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () => setState(() {
                                                isViewPrivateKey =
                                                    !isViewPrivateKey;

                                                context.pop();
                                                showBottomDialog();
                                              }),
                                              child: const Text("Details"),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  CustomIcon(
                                    onPressed: () => setState(() {
                                      isViewPrivateKey = !isViewPrivateKey;

                                      context.pop();
                                      showBottomDialog();
                                    }),
                                    child: const Text("Enter Private Key"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: AppData.colors.backgroundColor,
                          ),
                          const SizedBox(height: 20),
                          isViewPrivateKey
                              ? Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: TextField(
                                            maxLines: 5,
                                            style:
                                                const TextStyle(fontSize: 12),
                                            onChanged: (value) {
                                              setState(() {
                                                privateKeyCtrl.text = value;
                                              });
                                            },
                                            controller: privateKeyCtrl,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1),
                                              ),
                                              disabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppData
                                                        .colors.backgroundColor,
                                                    width: 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        CustomIcon(
                                          onPressed: () => import(),
                                          child: const Text("Import Keystore"),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: AppData.colors.backgroundColor,
                                    ),
                                  ],
                                )
                              : Container(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            CustomIcon(
              onPressed: () => context.pop(),
              child: const Text("Cancel"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomIcon(
                          onPressed: () => context.pop(),
                          child: const Text("Close"),
                        ),
                        const SizedBox(width: 10),
                        CustomIcon(
                          onPressed: () => showBottomDialog(),
                          child: const Text("Import Exist Wallet"),
                        ),
                        const SizedBox(width: 10),
                        CustomIcon(
                          onPressed: init,
                          child: const Text("Create New Wallet"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}
