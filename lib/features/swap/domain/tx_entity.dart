import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tx_entity.g.dart';

@JsonSerializable(createFactory: true)
class TxEntity implements DTO {
  String from;

  String to;

  String data;

  String value;

  int gas;

  String gasPrice;

  TxEntity({
    required this.data,
    required this.from,
    required this.gas,
    required this.gasPrice,
    required this.to,
    required this.value,
  });

  factory TxEntity.fromJson(Map<String, dynamic> json) =>
      _$TxEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TxEntityToJson(this);
}
