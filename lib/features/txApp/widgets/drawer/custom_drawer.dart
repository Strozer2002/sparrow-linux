import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/screen_name_enum.dart';
import 'package:sparrow/features/txApp/settings/domain/models/enums/week_day_enum.dart';
import 'package:sparrow/features/txApp/widgets/drawer/custom_drawer_bloc.dart';
import 'package:reactive_variables/reactive_variables.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends CustomDrawerBloc {
  Widget get getMainCurrencyWidget {
    return Obs(
      rvList: [currencies, mainCurrency],
      builder: (BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: AppData.theme.button.whiteElevatedButton,
          onPressed: () {
            (() async {
              currencies.value = await getCurrencyList();
            })();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Выберете основную валюту",
                    style: AppData.theme.text.s18w700,
                  ),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: currencies.value!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          style: AppData.theme.button.whiteElevatedButton,
                          onPressed: () {
                            setState(() {
                              updateMainCurrency(
                                currencies.value![index],
                              );
                              (() async {
                                mainCurrency.value = await getMainCurrency();
                              })();
                              context.pop();
                            });
                          },
                          child: Text(
                            currencies.value![index].name,
                            style: AppData.theme.text.s14w500,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    ),
                  ),
                );
              },
            );
          },
          child: Column(
            children: [
              Text(
                "Основная валюта",
                style: AppData.theme.text.s14w500,
              ),
              Text(
                mainCurrency.value ?? "",
                style: AppData.theme.text.s18w700
                    .copyWith(color: AppData.colors.sky700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get getMainScreenWidget {
    return Obs(
      rvList: [mainScreenName],
      builder: (BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: AppData.theme.button.whiteElevatedButton,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Выберете основной экран",
                    style: AppData.theme.text.s18w700,
                  ),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: ScreensName.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          style: AppData.theme.button.whiteElevatedButton,
                          onPressed: () {
                            setState(() {
                              updateMainScreen(
                                ScreensName.values[index],
                              );
                              (() async {
                                mainScreenName.value = await getMainScreen();
                              })();
                              context.pop();
                            });
                          },
                          child: Text(
                            ScreensName.values[index].name,
                            style: AppData.theme.text.s14w500,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    ),
                  ),
                );
              },
            );
          },
          child: Column(
            children: [
              Text(
                "Начальный экран",
                style: AppData.theme.text.s14w500,
              ),
              Text(
                mainScreenName.value != null ? mainScreenName.value!.name : "",
                style: AppData.theme.text.s18w700
                    .copyWith(color: AppData.colors.sky700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get getPassword {
    return Obs(
      rvList: [isPassword],
      builder: (BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: AppData.theme.button.whiteElevatedButton,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Напишите пароль",
                    style: AppData.theme.text.s18w700,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: passwordController,
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: AppData.theme.button.deleteElevatedButton,
                            onPressed: () {
                              setState(() {
                                deletePassword();
                                (() async {
                                  isPassword.value = await isActivatePassword();
                                })();
                                context.pop();
                              });
                            },
                            child: const Text(
                              "Удалить",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ElevatedButton(
                            style: AppData.theme.button.acceptElevatedButton,
                            onPressed: () {
                              if (passwordController.text.isNotEmpty) {
                                setState(() {
                                  addPassword(passwordController.text);
                                  (() async {
                                    isPassword.value =
                                        await isActivatePassword();
                                  })();
                                  context.pop();
                                });
                              }
                            },
                            child: const Text("Установить"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Column(
            children: [
              Text(
                "Наличие пароля",
                style: AppData.theme.text.s14w500,
              ),
              Text(
                isPassword.value ? "Есть пароль" : "Нет пароля",
                style: AppData.theme.text.s18w700
                    .copyWith(color: AppData.colors.sky700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get mainDay {
    return Obs(
      rvList: [mainWeekDay],
      builder: (BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: AppData.theme.button.whiteElevatedButton,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Выберете первый день недели",
                    style: AppData.theme.text.s18w700,
                  ),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: WeekDay.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          style: AppData.theme.button.whiteElevatedButton,
                          onPressed: () {
                            setState(() {
                              updateMainDay(
                                WeekDay.values[index],
                              );
                              (() async {
                                mainWeekDay.value = await getMainDay();
                              })();
                              context.pop();
                            });
                          },
                          child: Text(
                            WeekDay.values[index].name,
                            style: AppData.theme.text.s14w500,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    ),
                  ),
                );
              },
            );
          },
          child: Column(
            children: [
              Text(
                "Первый день недели",
                style: AppData.theme.text.s14w500,
              ),
              Text(
                mainWeekDay.value ?? "",
                style: AppData.theme.text.s18w700
                    .copyWith(color: AppData.colors.sky700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get import {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: AppData.theme.button.whiteElevatedButton,
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Точно импортировать данные?",
                    style: AppData.theme.text.s18w700,
                    textAlign: TextAlign.center,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Ваши локальные данные будут удалены",
                        style: AppData.theme.text.s16w500,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: AppData.theme.button.acceptElevatedButton,
                            onPressed: () async {
                              final Services services = Services();
                              await services.importFromDb();

                              context.pop();
                              if (mounted) {
                                context.go(AppData.routes.bankAccountScreen);
                              }
                            },
                            child: const Text("Да"),
                          ),
                          ElevatedButton(
                            style: AppData.theme.button.deleteElevatedButton,
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text("Нет"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        child: Text(
          "Импортировать данные",
          style:
              AppData.theme.text.s18w700.copyWith(color: AppData.colors.sky700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1money",
                style: AppData.theme.text.s28w700,
              ),
              const SizedBox(height: 50),
              Text(
                "Настройки",
                style: AppData.theme.text.s18w700,
              ),
              const SizedBox(height: 25),
              getMainCurrencyWidget,
              const SizedBox(height: 25),
              getMainScreenWidget,
              const SizedBox(height: 25),
              getPassword,
              const SizedBox(height: 25),
              mainDay,
              const SizedBox(height: 25),
              Container(height: 1, color: AppData.colors.gray300),
              const SizedBox(height: 25),
              Text(
                "Данные",
                style: AppData.theme.text.s18w700,
              ),
              const SizedBox(height: 25),
              import,
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
