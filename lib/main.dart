import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routes.dart';
import 'package:flutter_application_2/helpers/loading/loading_screen.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_events.dart';
import 'package:flutter_application_2/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_2/services/auth/firebase_auth_provider.dart';
import 'package:flutter_application_2/views/forgot_password_view.dart';
import 'package:flutter_application_2/views/notes/create_update_note_view.dart';
import 'package:flutter_application_2/views/notes/notes_view.dart';
import 'package:flutter_application_2/views/login_view.dart';
import 'package:flutter_application_2/views/register_view.dart';
import 'package:flutter_application_2/views/verify_email_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'first app',
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FireBaseAuthProvider()),
      child: const HomePage(),
    ),
    routes: {
      createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.isLoading) {
        LoadingScreen()
            .show(context: context, text: state.loadingText ?? 'Please wait');
      } else {
        LoadingScreen().hide();
      }
    }, builder: (context, state) {
      if (state is AuthStateLoggedIn) {
        return const NotesView();
      } else if (state is AuthStateLoggedOut) {
        return const LoginView();
      } else if (state is AuthStateNeedsVerification) {
        return const VerifyEmailView();
        // while (state is AuthStateNeedsVerification) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     showVerifyEmailDialog(context);
        //   });
        // }
        // return const Scaffold(
        //   body: CircularProgressIndicator(),
        // );
      } else if (state is AuthStateForgotPassword) {
        return const ForgotPasswordView();
      } else if (state is AuthStateRegistering) {
        return const RegisterView();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });
  }
}
