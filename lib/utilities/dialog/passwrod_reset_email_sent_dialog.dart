import 'package:flutter/material.dart';
import 'package:flutter_application_2/utilities/dialog/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'Passwrd reset email sent',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
