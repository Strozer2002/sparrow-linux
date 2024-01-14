import 'package:flutter/material.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/account/account_bloc.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/account_card/account_card.dart';
import 'package:sparrow/features/txApp/bank_account/presentation/widgets/models/add_account/add_account.dart';
import 'package:reactive_variables/reactive_variables.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends AccountBloc {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Obs(
              rvList: [accounts],
              builder: (BuildContext context) => accounts.value.isEmpty
                  ? const Center(
                      child: Text("У вас нет счетов"),
                    )
                  : Obs(
                      rvList: [accounts],
                      builder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: accounts.value.length,
                          itemBuilder: (context, index) => AccountCard(
                            account: accounts()[index],
                            onDelete: onDeleteAccount,
                            onChange: onChangeAccount,
                            onUpdate: onUpdateAccount,
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                            height: 20,
                          ),
                        ),
                      ),
                    ),
            ),
      floatingActionButton: AddAccount(onAdd: onCreateAccount),
    );
  }
}
