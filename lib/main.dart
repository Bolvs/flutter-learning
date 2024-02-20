import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/RegisterView.dart';
import 'package:flutter_application_2/views/login_view.dart';

//import 'package:flutter_application_2/views/RegisterView.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
    title: 'first app',
    home: const HomePage(),
    routes:{
      '/login/': (context) => const LoginView(),
      '/register/':(context) => const RegisterView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color.fromARGB(255, 44, 137, 244),
      ),
      
     body:FutureBuilder(
      future:  Firebase.initializeApp(
               options: DefaultFirebaseOptions.currentPlatform,
             ),
       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState){
          
          case ConnectionState.done:
          //  final user = FirebaseAuth.instance.currentUser;
          //  if(user?.emailVerified ?? false){
          //   print('user is verified');
          //  }
          //  else{
          //   return const verifyEmailView();
          //  }
           return const LoginView();
          default:
           return const Text('...Loading...'); 
        }
        
        }, 
      
     ),
    );
  }
 
}
class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
     return Column(children: [
        const Text('Please verify your email address:'),
        ElevatedButton(onPressed: () async{
          final user = FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();
        }, child: const Text('Send Email Verification'))
      ]);
  }
}
