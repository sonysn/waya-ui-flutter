import 'package:flutter/material.dart';

String capitalizeFirstLetter(String? text) {
  if (text!.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}

void showSnackBar({required String message, required BuildContext context}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
