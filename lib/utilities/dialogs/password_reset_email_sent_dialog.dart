import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dialogs/show_generic_dialog.dart';

Future<void> showPasswordResetDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content: 'We have sent you a password reset email.',
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
