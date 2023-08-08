import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:password_generator/model/password_model.dart';

class PasswordController with ChangeNotifier {
  final passwordDb = Hive.box<PasswordModel>('passwordbox');
  List<PasswordModel> passwordList = [];
  Future<void> addPassword(PasswordModel value) async {
    final passwordDb = Hive.box<PasswordModel>('passwordbox');
    await passwordDb.add(value);
    passwordList.add(value);

    notifyListeners();
  }

  Future<void> getAllPassword() async {
    final passwordDb = Hive.box<PasswordModel>('passwordbox');
    passwordList.clear();
    passwordList.addAll(passwordDb.values);
    notifyListeners();
  }

  Future<void> deletePassword(int index) async {
    final passwordDb = Hive.box<PasswordModel>('passwordbox');
    await passwordDb.deleteAt(index);
    getAllPassword();
    notifyListeners();
  }
}
