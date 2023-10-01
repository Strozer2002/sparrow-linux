// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_reset_entity.g.dart';

@JsonSerializable()
class UserResetEntity implements DTO {
  final String? hash;

  const UserResetEntity({
    this.hash,
  });

  factory UserResetEntity.fromJson(Map<String, dynamic> json) =>
      _$UserResetEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserResetEntityToJson(this);
}
