import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/LoginView.dart';
//import 'package:flutter_application_2/views/RegisterView.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    title: 'first app',
    home: LoginView(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 44, 137, 244),
      ),
     body:FutureBuilder(
      future:  Firebase.initializeApp(
               options: DefaultFirebaseOptions.currentPlatform,
             ),
       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState){
          
          case ConnectionState.done:
           final user = FirebaseAuth.instance.currentUser;
           if(user?.emailVerified ?? false){
            print('user is verified');
           }
           else{
            print('not verified');
           }
           return Text('Done');
          default:
           return Text('...Loading...');   // TODO: Handle this case.
        }
        
        }, 
      
     ),
    );
  }
 
}
