import 'package:rabby/features/swap/domain/model/tx.dart';

class SwapModel {
  Tx tx;

  String toAmount;

  SwapModel({
    required this.toAmount,
    required this.tx,
  });
}
