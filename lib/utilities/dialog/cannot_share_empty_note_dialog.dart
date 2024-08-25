import 'package:flutter/material.dart';
import 'package:flutter_application_2/utilities/dialog/generic_dialog.dart';

Future<void> showCannotShareEmptyNotesDialog(BuildContext context) {
  return showGenericDialog<void>(
      context: context,
      title: 'Sharing',
      content: 'You cannot share an empty note!',
      optionsBuilder: () => {
            'OK': null,
          });
}
