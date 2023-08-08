import 'dart:core';

import 'package:hive/hive.dart';
part 'password_model.g.dart';

@HiveType(typeId: 1)
class PasswordModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String password;
  PasswordModel({
    required this.password,
    this.id,
  });
}
