// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthEntity _$UserAuthEntityFromJson(Map<String, dynamic> json) =>
    UserAuthEntity(
      token: json['token'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserAuthEntityToJson(UserAuthEntity instance) =>
    <String, dynamic>{
      'token': instance.token,
      'avatar': instance.avatar,
    };
