// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser()
  ..id = json['id'] as int?
  ..userId = json['userId'] as String?
  ..password = json['password'] as String?
  ..email = json['email'] as String?;

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'password': instance.password,
      'email': instance.email,
    };
