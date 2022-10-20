import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import 'package:notes_app/services/auth/auth_user.dart';
import 'package:notes_app/services/auth/bloc/auth_event.dart';

import '../services/auth/bloc/auth_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
                'We\'ve sent you an email verification, please verify your email address'),
            const Text(
                'If you haven\'t received a verification email yet, please click this button'),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventSendEmailVerification(),
                      );
                },
                child: const Text('Send Email verification')),
            TextButton(
              child: const Text('Restart'),
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventLogout(),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
