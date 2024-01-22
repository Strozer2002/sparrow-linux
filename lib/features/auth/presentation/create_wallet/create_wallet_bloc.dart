import 'package:bip39_mnemonic/bip39_mnemonic.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/currency/domain/custom_currency.dart';
import 'package:sparrow/features/settings/domain/settings_service.dart';

import 'create_wallet.dart';

abstract class CreateWalletBloc extends State<CreateWalletScreen> {
  final SettingsService _settingsService = SettingsService();
  bool isLoading = false;
  bool isGeneral = true;
  Mnemonic? mnemonic;
  bool isCorrectMnemonic = true;

  String r = '';

  String displayUnit = 'Auto';
  List<String> displayUnitItems = [
    'Auto',
    'mempool.space',
    'oxt.me',
  ];

  String feeRates = 'mempool.space';
  List<String> feeRatesItems = [
    'mempool.space',
    'blockstream.info',
    'None',
  ];

  CustomCurrency? currency;
  List<CustomCurrency> currencyItems = [];

  String exchange = 'Coingecko';
  List<String> exchangeItems = [
    'Coingecko',
    'Coinbase',
    'None',
  ];

  bool isWalletLoad = true;
  bool isWalletValidate = true;
  bool isCoinGroup = true;
  bool isCoinAllow = true;
  bool isNewTx = true;
  bool isSoftware = true;

  bool? isPublic;

  String url = 'bitcoin.lukechilds.co';
  List<String> urlItems = [
    'bitcoin.lukechilds.co',
    'electrum.blockstream.info',
  ];
  bool useProxy = false;

  int mnemonicCount = 12;
  List<String> mnemonicList = List.filled(12, "");
  List<TextEditingController> controllers = List.generate(
    12,
    (index) => TextEditingController(),
  );
  List<bool> isError = List.generate(
    12,
    (index) => false,
  );
  final TextEditingController phraseCtrl = TextEditingController();
  final TextEditingController phraseController = TextEditingController();
  final TextEditingController privateKeyCtrl = TextEditingController();

  List<int> possibleCount = [12, 15, 18, 21, 24];
  bool isViewMnemonic = false;
  bool isViewPrivateKey = false;

  @override
  void initState() {
    initCurrencies();
    super.initState();
  }

  void onClear() {
    setState(() {
      isCorrectMnemonic = true;
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

  Future<void> initCurrencies() async {
    Map<String, dynamic> rates = await AppData.utils.getExchangeRates("USD");
    int rateUSD = rates['rates']["USD"];
    double rateEUR = rates['rates']["EUR"];
    double rateCNY = rates['rates']["CNY"];
    double rateJPY = rates['rates']["JPY"];
    double rateHKD = rates['rates']["HKD"];

    currencyItems.addAll([
      CustomCurrency(
        name: "USD",
        rate: rateUSD.toDouble(),
        symbol: "\$",
        isChoose: true,
      ),
      CustomCurrency(
        name: "EUR",
        rate: rateEUR,
        symbol: "€",
      ),
      CustomCurrency(
        name: "CNY",
        rate: rateCNY,
        symbol: "¥",
      ),
      CustomCurrency(
        name: "JPY",
        rate: rateJPY,
        symbol: "JP¥",
      ),
      CustomCurrency(
        name: "HKD",
        rate: rateHKD,
        symbol: "HK\$",
      ),
    ]);

    setState(() {
      currency = currencyItems[0];
    });
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });

    mnemonic = Mnemonic.generate(
      Language.english,
      passphrase: "Something",
      entropyLength: 128,
    );

    await AppData.utils.importData(
      public: mnemonic!.sentence,
      isNew: true,
    );

    _settingsService.putMnemonicSentence(mnemonic!.sentence);
    print(
        "_settingsService.getMnemonicSentence() ${_settingsService.getMnemonicSentence()}");

    if (mounted) {
      context.go(AppData.routes.homeScreen);
    }
    setState(() {
      isLoading = false;
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
      _settingsService.putMnemonicSentence(phraseController.text);
      if (mounted) {
        context.go(AppData.routes.homeScreen);
      }
      setState(() {
        isLoading = false;
      });
    }
    return false;
  }
}
