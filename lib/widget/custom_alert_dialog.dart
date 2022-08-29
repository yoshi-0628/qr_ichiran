import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  CustomAlertDialog({
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }
}
