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
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        // child: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Image.asset(
                        //     "images/flutter-logo.png",
                        //     width: 80,
                        //     height: 80,
                        //   ),
                        // )
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                          child: Container(
                        width: 250,
                        child: Material(
                          elevation: 5.0,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: const Color(0xFFa28ecc),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(13.0),
                                child: Center(child: Icon(Icons.person)),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0)),
                                ),
                                width: 200,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Form(
                                    child: TextField(
                                      //TestField
                                      controller: _email,

                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      Form(
                          child: Container(
                        width: 250,
                        child: Material(
                          elevation: 5.0,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: const Color(0xFFa28ecc),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(13.0),
                                child: Center(child: Icon(Icons.lock)),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0)),
                                ),
                                width: 200,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Form(
                                    child: TextField(
                                      //TestField
                                      controller: _password,

                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 240,
                            child: ElevatedButton(
                              onPressed: () async {
                                final email = _email.text;
                                final password = _password.text;
                                context.read<AuthBloc>().add(
                                      AuthEventRegister(email, password),
                                    );
                              },
                              child: const Text('Sign In'),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              context.read<AuthBloc>().add(
                                    AuthEventLogOut(),
                                  );
                            },
                            child: const Text('Already have an account? Login'),
                          ),
                          // TextButton(
                          //   onPressed: () async {
                          //     context.read<AuthBloc>().add(
                          //           AuthEventLogOut(),
                          //         );
                          //   },
                          //   child: const Text('Already have an account? Login'),
                          // ),
                          const SizedBox(
                            height: 48,
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
      ),
    );
  }
}
