import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginView extends StatefulWidget {
   const LoginView({super.key});
 //const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email=TextEditingController();
  late final TextEditingController _password=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
          
     body: Column(
           children: [
            TextField(
              controller: _email,
              
              enableSuggestions: false,
              autocorrect: false,
              keyboardType:TextInputType.emailAddress ,
              decoration: InputDecoration(
                hintText: ' Email'
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: ' Password',
              ),
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
               
            ),
             ElevatedButton(onPressed: ()async{
               try{
               final email=_email.text;
               final password=_password.text;
               final user_cred=await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email, 
                password: password);
              print(user_cred);
              Navigator.of(context).pushNamedAndRemoveUntil('/notes/', (route) => false);
             }
             on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
                const snackBar = SnackBar(
                          content: Text('No user found'),
                          );
     
     // Find the ScaffoldMessenger in the widget tree
     // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar); 
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              } else if (e.code == 'invalid-email') {
                print('The email address is badly formatted.');
              } else {
                print('Something else happened.');
                print(e);
      }
       }
             
             },
                  child: const Text('Login'),),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/register/',
                     (route) => false
                     );
                  }, 
                  child: const Text('Not registered yet, Register here?')),
           ],
         ),
   );
  }
 
}