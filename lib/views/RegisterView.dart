import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';

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
        title: Text('Registration'),
        backgroundColor: Colors.amber,
      ),
     body:FutureBuilder(
      future:  Firebase.initializeApp(
               options: DefaultFirebaseOptions.currentPlatform,
             ),
       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState){
          
          case ConnectionState.done:
          return Column(
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
         ],
       );
         default:
         return Text('...Loading...');   // TODO: Handle this case.
        }
        
        }, 
      
     ),
    );
  }
}