// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFcab2ff),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              heightFactor: 0.5,
              widthFactor: 0.5,
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(200.0)),
                color: const Color.fromRGBO(255, 255, 255, 0.4),
                child: Container(
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: 385,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Material(
                      elevation: 10.0,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      // child: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Image.asset(
                      //     "images/flutter-logo.png",
                      //     width: 80,
                      //     height: 80,
                      //   ),
                      // )
                    ),
                    Column(
                      children: [
                        const Text(
                            "We've already sent you an email for registration"),
                        Container(
                          width: 240,
                          child: ElevatedButton(
                            onPressed: () async {
                              context.read<AuthBloc>().add(
                                    const AuthEventSendEmailVerification(),
                                  );
                            },
                            child: const Text('Resend Email Verification'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            context.read<AuthBloc>().add(
                                  const AuthEventLogOut(),
                                );
                          },
                          child: const Text('Back to Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
