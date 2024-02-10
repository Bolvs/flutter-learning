import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    title: 'first app',
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final TextEditingController _email=TextEditingController();
  late final TextEditingController _password=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
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
             
             final email=_email.text;
             final password=_password.text;
             final user_cred=await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email, 
              password: password);
            print(user_cred);
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
