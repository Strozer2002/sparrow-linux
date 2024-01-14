import 'package:flutter/material.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/txApp/operation/presentation/operation_page/operation_bloc.dart';
import 'package:sparrow/features/txApp/operation/presentation/widget/add_operation/add_operation.dart';
import 'package:sparrow/features/txApp/operation/presentation/widget/operation_card.dart';
import 'package:reactive_variables/reactive_variables.dart';

class OperationPage extends StatefulWidget {
  const OperationPage({super.key});

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends OperationBloc {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obs(
        rvList: [
          tempOperation,
          currentType,
        ],
        builder: (BuildContext context) => Column(
          children: [
            Container(
              color: AppData.colors.sky600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: ElevatedButton(
                      onPressed: onExpense,
                      child: const Text("Расходы"),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: ElevatedButton(
                      onPressed: onIncome,
                      child: const Text("Доходы"),
                    ),
                  ),
                ],
              ),
            ),
            tempOperation.value.isEmpty
                ? Text(isEmptyList)
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: tempOperation.value.length,
                    itemBuilder: (context, index) => OperationCard(
                      operation: tempOperation()[index],
                      onDelete: deleteOperation,
                      onChange: updateOperation,
                      onUpdate: onUpdateCategory,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
          ],
        ),
      ),
      floatingActionButton: AddOperation(onAdd: createOperation),
    );
  }
}
