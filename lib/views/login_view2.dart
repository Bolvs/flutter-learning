import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/auth/auth_exceptions.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_events.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_2/utilities/dialog/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

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
          // TODO: implement listener
          if (state is AuthStateLoggedOut) {
            if (state.exception is UserNotFoundAuthException) {
              await showErrorDialog(
                  context, 'Cannot find user with entered credentials');
            } else if (state.exception is WrongPasswordAuthException) {
              await showErrorDialog(context, 'Wrong credentials');
            } else if (state.exception is GenericAuthException) {
              await showErrorDialog(context, 'Authentication error');
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
                    borderRadius:
                        const BorderRadius.all(Radius.circular(200.0)),
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
                    height: 300,
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
                        Form(
                            child: Container(
                          width: 250,
                          child: Material(
                            elevation: 5.0,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                                    padding: const EdgeInsets.all(8.0),
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
                                BorderRadius.all(Radius.circular(10.0)),
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
                                    padding: const EdgeInsets.all(8.0),
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
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final email = _email.text;
                                    final password = _password.text;
                                    context.read<AuthBloc>().add(
                                          AuthEventRegister(email, password),
                                        );
                                  },
                                  child: const Text('Sign Up'),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final email = _email.text;
                                      final password = _password.text;
                                      context.read<AuthBloc>().add(
                                            AuthEventLogIn(
                                              email,
                                              password,
                                            ),
                                          );
                                    },
                                    child: const Text('Login'),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () async {
                                context.read<AuthBloc>().add(
                                      const AuthEventForgotPassword(),
                                    );
                              },
                              child: const Text('Forgot password'),
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
        ));
  }
}
