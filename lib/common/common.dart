import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lionsbotremotecontroller/repository/error_controller.dart';

Future errorDialog(BuildContext context, ErrorController error) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(error.error),
          content: Text('${error.plugin}\n\n${error.message}'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Unsuccessful login'),
          content: Text('${error.error}\n\n${error.message}'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  }
}

Future passwordResetLinkSend(
  BuildContext context,
) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Link send successfully'),
          content: const Text('Password reset link send! check you mail'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Link send successfully'),
          content: const Text('Password reset link send! check you mail'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  }
}

Future accountCreatedSuccessfully(
  BuildContext context,
) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: const Text('New account was created successfully'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('New account was created successfully'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(
                context,
              ),
            ),
          ],
        );
      },
    );
  }
}
