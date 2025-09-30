import 'package:flutter/material.dart';

void showOkSnack(BuildContext context, String msg) {
  _showSnack(
    context,
    msg,
    const Icon(Icons.check_circle, size: 20),
  );
}

void showErrSnack(BuildContext context, String msg) {
  _showSnack(
    context,
    msg,
    const Icon(Icons.error_rounded, size: 20),
  );
}

void _showSnack(BuildContext context, String msg, Icon leading) {
  final snack = SnackBar(
    content: Row(
      children: [
        leading,
        const SizedBox(width: 12),
        Expanded(child: Text(msg)),
      ],
    ),
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
