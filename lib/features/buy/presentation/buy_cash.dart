import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rabby/features/buy/presentation/buy_bloc.dart';

import '../../../app_data/app_data.dart';
import '../../auth/widgets/main_button.dart';

class BuyCashScreen extends StatefulWidget {
  const BuyCashScreen({super.key});

  @override
  State<BuyCashScreen> createState() => _BuyCashScreenState();
}

class _BuyCashScreenState extends BuyCashBloc {
  AppBar get appBar {
    return AppBar(
      title: const Text("Add Cash"),
      leading: IconButton(
        onPressed: () => context.go(AppData.routes.homeScreen),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get child {
    return const Column(
      children: [],
    );
  }

  Widget get bottomButton {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 82, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppData.colors.middlePurple.withOpacity(0.5),
          ),
        ),
      ),
      child: MainButton(
        onPressed: () => context.push(AppData.routes.seedPhraseScreen),
        child: const Text("Show Seed Phrase"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(top: 36, right: 20, left: 20),
        child: child,
      ),
      bottomSheet: bottomButton,
    );
  }
}
