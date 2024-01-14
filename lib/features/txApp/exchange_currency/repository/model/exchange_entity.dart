// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchange_entity.g.dart';

@JsonSerializable(createFactory: true)
class ExchangeEntity implements DTO {
  final int id;
  @JsonKey(name: 'currency_from')
  final String currencyFrom;

  @JsonKey(name: 'currency_into')
  final String currencyInto;

  @JsonKey(name: 'amount_from')
  final double amountFrom;

  @JsonKey(name: 'amount_into')
  final double amountInto;

  const ExchangeEntity({
    required this.id,
    required this.amountFrom,
    required this.amountInto,
    required this.currencyFrom,
    required this.currencyInto,
  });

  factory ExchangeEntity.fromJson(Map<String, dynamic> json) =>
      _$ExchangeEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ExchangeEntityToJson(this);
}
