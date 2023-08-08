import 'package:flutter/material.dart';

String? inputPassword;
List<String> userSpecificPassword = ['Letter', 'Numbers', 'special character'];
ScaffoldFeatureController scaffoldAlert(context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 200),
      backgroundColor: Colors.purple[200],
      content: Text(text)));
}
