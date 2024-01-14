// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_account_entity.g.dart';

@JsonSerializable(createFactory: true)
class BankAccountEntity implements DTO {
  final int id;
  final String name;
  final String currency;
  final int color;
  final int icon;
  final String? description;
  final double amount;

  const BankAccountEntity({
    required this.id,
    required this.name,
    required this.currency,
    required this.color,
    required this.icon,
    this.description,
    required this.amount,
  });

  factory BankAccountEntity.fromJson(Map<String, dynamic> json) =>
      _$BankAccountEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$BankAccountEntityToJson(this);
}
