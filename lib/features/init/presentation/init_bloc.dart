import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/app_data/app_data.dart';
import 'package:rabby/features/settings/domain/settings_service.dart';

import 'init.dart';

abstract class InitBloc extends State<InitPage>
    with SingleTickerProviderStateMixin {
  final SettingsService _settingsService = SettingsService();
  AnimationController? _controller;
  Animation<double>? animation;
  Animation<double>? animationBg;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    );
    // _controllerBg = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 200),
    // );

    animationBg = Tween<double>(begin: 5.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    );
    _controller!.repeat(reverse: true);
    // _controllerBg!.repeat(reverse: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      syncData();
    });
  }

  void onImageClicked() {
    print('Картинка нажата!');
  }

  Future<void> syncData() async {
    if (_settingsService.getMnemonicSentence() != null &&
        _settingsService.getPrivateKey() == null) {
      await AppData.utils
          .getPrivateKey(_settingsService.getMnemonicSentence()!);
      await AppData.utils.importData(
        public: _settingsService.getMnemonicSentence()!,
        isNew: false,
      );
    } else if (_settingsService.getPrivateKey() != null) {
      await AppData.utils.importData(
        public: _settingsService.getPrivateKey()!,
        isNew: false,
      );
      await AppData.utils.web3(_settingsService.getPrivateKey()!);
    }

    relocate();
  }

  Future<void> relocate() async {
    if (mounted) {
      if (_settingsService.getPassCode() == null) {
        context.push(AppData.routes.welcomeScreen);
      } else {
        final result = await context.push<bool?>(AppData.routes.setCode);
        if (result == true && mounted) {
          context.go(AppData.routes.homeScreen);
        }
      }
    }
  }
}
