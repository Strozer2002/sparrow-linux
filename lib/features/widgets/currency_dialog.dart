import 'package:flutter/material.dart';
import 'package:rabby/features/auth/domain/auth_service.dart';

class CurrencyDialogWidget extends StatefulWidget {
  const CurrencyDialogWidget({super.key});

  @override
  State<CurrencyDialogWidget> createState() => _CurrencyDialogWidgetState();
}

class _CurrencyDialogWidgetState extends State<CurrencyDialogWidget> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(authService.getCurrencies()[index].name),
              Checkbox(
                value: authService.getCurrencies()[index].isChoose == true,
                onChanged: (value) => setState(() {
                  authService.setSelectCurrency(
                    authService.getCurrencies()[index],
                  );
                }),
              ),
            ],
          ),
        ),
        itemCount: authService.getCurrencies().length,
      ),
    );
  }
}
