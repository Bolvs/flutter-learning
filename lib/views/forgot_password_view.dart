import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_events.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_2/utilities/dialog/error_dialog.dart';
import 'package:flutter_application_2/utilities/dialog/passwrod_reset_email_sent_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear;
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(context, 'Not a registered user');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Enter the email to reset password'),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: 'Your email adress...'),
              ),
              ElevatedButton(
                onPressed: () {
                  final email = _controller.text;
                  context
                      .read<AuthBloc>()
                      .add(AuthEventForgotPassword(email: email));
                },
                child: const Text('Send reset email'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: const Text('Back to login page'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
