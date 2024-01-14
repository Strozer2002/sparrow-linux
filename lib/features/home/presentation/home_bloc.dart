

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/auth/domain/auth_service.dart';
import 'package:sparrow/features/crypt/domain/crypt.dart';
import 'package:sparrow/features/home/domain/home_screen_enum.dart';
import 'package:sparrow/features/home/domain/wallet_type_enum.dart';
import 'package:sparrow/features/settings/domain/settings_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'home_screen.dart';

abstract class HomeBloc extends State<HomeScreen> {
  final AuthService authService = AuthService();
  final SettingsService settingsService = SettingsService();
  Rv<HomeScreenEnum> selectedScreen = Rv(HomeScreenEnum.wallet);
  Rv<WalletTypeEnum> selectedWalletType = Rv(WalletTypeEnum.send);
  List<Crypt> crypts = [];
  bool isReload = false;
  int transactionsLength = 0;

  int currentScreen = 0;
  bool isSwitch = false;

  String policyType = 'Single Signature';
  List<String> policyTypeItems = [
    'Single Signature',
    'Option 2',
    'Option 3',
  ];

  String scriptType = 'Native Segwit (P2WPKH)';
  List<String> scriptTypeItems = [
    'Native Segwit (P2WPKH)',
    'Option 2',
    'Option 3',
  ];

  String? address;
  String? balance;
  String? mem;
  String? txCount;

  int mnemonicCount = 12;
  List<String> mnemonicList = List.filled(12, "");
  List<TextEditingController> controllers = List.generate(
    12,
    (index) => TextEditingController(),
  );
  final TextEditingController phraseCtrl = TextEditingController();
  final TextEditingController phraseController = TextEditingController();
  final TextEditingController privateKeyCtrl = TextEditingController();
  List<int> possibleCount = [12, 15, 18, 21, 24];
  bool isViewMnemonic = false;
  bool isViewPrivateKey = false;
  bool isLoading = false;

  ConnectivityResult? connectivityResult;

  final TextEditingController payToCtrl = TextEditingController();
  final TextEditingController labelToCtrl = TextEditingController();
  final TextEditingController amountToCtrl = TextEditingController();
  final TextEditingController feeToCtrl = TextEditingController();

  String amountType = 'sats';
  List<String> amountTypeItems = [
    'sats',
    'USD',
    'BTC',
  ];

  String feeType = 'sats';
  List<String> feeTypeItems = [
    'sats',
    'USD',
    'BTC',
  ];

  bool isFee = true;
  bool isOptimize = true;
  bool isCreateTx = false;

  double sliderValue = 569.0;
  final double minValue = 1.0;
  final double maxValue = 1024.0;

  String calculateLabel(double value) {
    // Функция для расчета отметки на основе значения слайдера
    List<int> labels = [1, 2, 4, 8, 16, 32, 64, 128, 256, 1024];
    int index = (value / (maxValue - minValue) * (labels.length - 1)).round();
    return labels[index].toString();
  }

  Future<void> initConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  @override
  void initState() {
    initConnectivity();
    connectivityResult == ConnectivityResult.none
        ? isSwitch = false
        : isSwitch = true;
    setState(() {
      address = authService.getAddress();
      balance = authService.getBalance().toString();
      mem = authService.getMem().toString();
      txCount = authService.getTxCount().toString();
    });
    super.initState();
  }

  void onClear() {
    setState(() {
      payToCtrl.text = "";
      amountToCtrl.text = "";
      labelToCtrl.text = "";
      feeToCtrl.text = "";
      privateKeyCtrl.text = "";
      phraseCtrl.text = "";
      phraseController.text = "";
      mnemonicList = List.filled(mnemonicCount, "");
      controllers = List.generate(
        mnemonicCount,
        (index) => TextEditingController(),
      );
    });
  }

  int get counts {
    switch (mnemonicCount) {
      case 12:
        return 128;
      case 15:
        return 160;
      case 18:
        return 192;
      case 21:
        return 224;
      case 24:
        return 256;
      default:
        return 128;
    }
  }

  void generateNew() {
    setState(() {
      Mnemonic mnemonic = Mnemonic.generate(
        Language.english,
        passphrase: "Something",
        entropyLength: counts,
      );

      mnemonicList = mnemonic.sentence.split(' ');
      for (int i = 0; i < mnemonicList.length; i++) {
        controllers[i].text = mnemonicList[i];
      }
    });
  }

  Future<void> import() async {
    setState(() {
      if (phraseCtrl.text.isEmpty) {
        for (int i = 0; i < controllers.length; i++) {
          if (controllers[i].text.isEmpty) {
            return;
          }
        }
        phraseController.text = mnemonicList.join(' ');
      } else {
        phraseController.text = phraseCtrl.text;
      }
      context.pop();
      isLoading = true;
      print(phraseController.text);
    });
    await AppData.utils.importData(
      public: phraseController.text,
      isNew: false,
    );
    settingsService.putMnemonicSentence(phraseController.text);
    if (mounted) {
      onClear();
      context.go(AppData.routes.homeScreen);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> importKey() async {
    setState(() {
      if (privateKeyCtrl.text.isEmpty) {
        return;
      } else {
        context.pop();
        isLoading = true;
        print(privateKeyCtrl.text);
      }
    });
    await AppData.utils.importData(
      public: privateKeyCtrl.text,
      isNew: false,
    );
    if (mounted) {
      onClear();
      context.go(AppData.routes.homeScreen);
    }
    setState(() {
      isLoading = false;
    });
  }
}
