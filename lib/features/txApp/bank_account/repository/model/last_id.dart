// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_source/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_id.g.dart';

@JsonSerializable(createFactory: true)
class LastIdEntity implements DTO {
  final int id;

  const LastIdEntity({
    required this.id,
  });

  factory LastIdEntity.fromJson(Map<String, dynamic> json) =>
      _$LastIdEntityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LastIdEntityToJson(this);
}
