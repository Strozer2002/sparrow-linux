// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operation_entity.g.dart';

@JsonSerializable(createFactory: true)
class OperationEntity implements DTO {
  final int id;
  final DateTime date;

  @JsonKey(name: 'category')
  final String categoryType;

  @JsonKey(name: 'bank_account')
  final int bankAccount;

  final double amount;

  const OperationEntity({
    required this.id,
    required this.date,
    required this.bankAccount,
    required this.amount,
    required this.categoryType,
  });

  factory OperationEntity.fromJson(Map<String, dynamic> json) =>
      _$OperationEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OperationEntityToJson(this);
}
