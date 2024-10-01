// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/auth/auth_exceptions.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_events.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_2/utilities/dialog/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email already in use');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid Email');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: ' Email'),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: ' Password',
                ),
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  context.read<AuthBloc>().add(
                        AuthEventRegister(email, password),
                      );
                },
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthEventLogOut(),
                      );
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
