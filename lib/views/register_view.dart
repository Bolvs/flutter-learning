import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/routes.dart';
import 'package:flutter_application_2/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
          title: const Text('Register'),
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
                 final user_cred=await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email, 
                  password: password);
                   final user = FirebaseAuth.instance.currentUser;
                   await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verify );
              }
              on FirebaseAuthException catch(e){
                  
                  if(e.code=='email-already-in-use'){
                    showErrorDialog(context, 'email-already-in-use');
                  }
                  else if(e.code=='invalid-email'){
                    showErrorDialog(context, 'invalid-email');
                  }
                  else if(e.code=="weak-password"){
                    showErrorDialog(context, "weak-password");
                  }
                  
                  else{
                   showErrorDialog(context, e.toString());
                  }
              }
              catch(e){
                showErrorDialog(context, e.toString());
              }
               },
                    child: Text('Register'),),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                       (route) => false
                       );
                    }, child: const Text('Already have an account? Login'),),
             ],
           ),
      
    );
  }
}