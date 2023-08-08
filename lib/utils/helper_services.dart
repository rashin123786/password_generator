import 'dart:math';

import 'package:password_generator/utils/constants.dart';

num a = 10;

String generatePassword(
  int lengths,
  bool hasLetter,
  bool hasNumbers,
  bool hasSpecial,
) {
  final length = lengths;
  const letterLowerCase = 'abcdefghijklmnopqrstuvwxyz';
  const letterUpperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const numbers = '0123456789';
  const special = '!@#?{}\$%^&*()';
  String chars = '';
  if (hasLetter) chars += '$letterLowerCase$letterUpperCase';
  if (hasSpecial) chars += special;

  if (hasNumbers) chars += numbers;
  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(chars.length);
    return chars[indexRandom];
  }).join('');
}

void errorcatch(context, int i) {
  switch (i) {
    case 1:
      scaffoldAlert(context, 'All the below field is empty');
      break;
    case 2:
      scaffoldAlert(context, 'password must between 8 -25');
      break;
    case 3:
      scaffoldAlert(context, 'Already added');
      break;
    case 4:
      scaffoldAlert(context, 'password stored successfully');
      break;
    case 5:
      scaffoldAlert(context, 'length must be 8');
      break;
  }
}
