

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
       body: Column(children: [
          const Text("we've already sent you an email for registration"),
          ElevatedButton(onPressed: () async{
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
            Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
          }, child: const Text('Resend Email Verification')),
          ElevatedButton(onPressed: () async{
           await FirebaseAuth.instance.signOut();
           Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          }, child: const Text('Restart')),
        ]),
     );
  }
}