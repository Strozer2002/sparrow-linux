// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_entity.g.dart';

@JsonSerializable(createFactory: true)
class CurrencyEntity implements DTO {
  final String name;

  final String symbol;

  const CurrencyEntity({
    required this.name,
    required this.symbol,
  });

  factory CurrencyEntity.fromJson(Map<String, dynamic> json) =>
      _$CurrencyEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CurrencyEntityToJson(this);
}
