import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appuser.g.dart';

@JsonSerializable()
class AppUser {
  // 0 = it
  // 1 = owner
  // 2 = bc
  // 3 = admin / cashier
  // 4 = doctor
  // 5 = gm

  int? id = 0;
  dynamic? userData;
  String? userId = "";
  String? password = "";
  String? email = "";

  AppUser();

  AppUser.create(this.id, this.userId, this.password);

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
