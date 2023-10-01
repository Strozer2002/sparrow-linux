// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_auth_entity.g.dart';

@JsonSerializable()
class UserAuthEntity implements DTO {
  final String address;

  const UserAuthEntity({
    required this.address,
  });

  factory UserAuthEntity.fromJson(Map<String, dynamic> json) =>
      _$UserAuthEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserAuthEntityToJson(this);
}
