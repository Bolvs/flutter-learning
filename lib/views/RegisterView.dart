import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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
                print(user_cred);
              }
              on FirebaseAuthException catch(e){
                  
                  if(e.code=='email-already-in-use'){
                    print("email already in use");
                    const snackBar = SnackBar(
                    content: Text('Email already in use'),
                    );
        
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar); 
                  }
                  else if(e.code=='invalid-email'){
                    print('invalid-email');
                  }
                  else if(e.code=="weak-password"){
                    print("weak password");
                  }
                  
                  else{
                    print(e.code);
                  }
              }
               },
                    child: Text('Register'),),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login/',
                       (route) => false
                       );
                    }, child: const Text('Already have an account? Login'),),
             ],
           ),
      
    );
  }
}