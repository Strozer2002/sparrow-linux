import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'tx_entity.dart';

part 'data_swap_entity.g.dart';

@JsonSerializable(createFactory: true)
class DataSwapEntity implements DTO {
  TxEntity tx;

  String toAmount;

  DataSwapEntity({
    required this.tx,
    required this.toAmount,
  });
  
  factory DataSwapEntity.fromJson(Map<String, dynamic> json) =>
      _$DataSwapEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DataSwapEntityToJson(this);

}


