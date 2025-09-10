import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message.toString()),
      backgroundColor: const Color.fromARGB(255, 219, 28, 232),
    ),
  );
}
