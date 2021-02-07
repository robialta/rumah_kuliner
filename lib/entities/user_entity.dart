import 'package:flutter/material.dart';

class UserEntity {
  final String id;
  final String name;
  // final String email;
  final String phone;
  final String location;

  UserEntity(
      {@required this.location,
      @required this.id,
      @required this.name,
      // @required this.email,
      @required this.phone});
}
