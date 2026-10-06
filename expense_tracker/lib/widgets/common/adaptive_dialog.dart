import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// iOS-style dialog on iPhones, Material dialog on other platforms.
Future<void> showAdaptiveMessageDialog({
  required BuildContext context,
  required String title,
  required String message,
}) {
  final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

  if (isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Okay'),
        ),
      ],
    ),
  );
}