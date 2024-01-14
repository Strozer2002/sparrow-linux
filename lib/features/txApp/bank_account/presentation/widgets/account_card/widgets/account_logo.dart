import 'package:flutter/material.dart';
import 'package:sparrow/features/txApp/bank_account/domain/models/bank_account.dart';

class AccountLogo extends StatefulWidget {
  final BankAccount account;
  const AccountLogo({
    super.key,
    required this.account,
  });

  @override
  State<AccountLogo> createState() => _AccountLogoState();
}

class _AccountLogoState extends State<AccountLogo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(widget.account.color),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Icon(
          IconData(
            widget.account.icon,
            fontFamily: 'MaterialIcons',
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
