import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/RegisterView.dart';
import 'package:flutter_application_2/views/login_view.dart';
import 'package:flutter_application_2/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
    title: 'first app',
    home: const HomePage(),
    routes:{
      '/login/': (context) => const LoginView(),
      '/register/':(context) => const RegisterView(),
      '/notes/':(context) => const NotesView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:  Firebase.initializeApp(
               options: DefaultFirebaseOptions.currentPlatform,
             ),
       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState){
          
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if(user!=null){
              if(user.emailVerified){
                return const NotesView();

              }
              else{
                return const VerifyEmailView();
              }
            }
            else{
              return const LoginView();
            }
           
          //  if(user?.emailVerified ?? false){
          //   print('user is verified');
          //  }
          //  else{
          //   return const verifyEmailView();
          //  }
         
          default:
           return const CircularProgressIndicator(); 
        }
        
        }, 
      
     );
  }
 
}

enum MenuAction{
  logout
}
class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton(onSelected:(value)async{
            switch(value){
              
              case MenuAction.logout:
                final shouldLogOut= await showLogOutDialog(context);
                if(shouldLogOut){
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login/', (_) => false);
                }
                break;
            }
          },
          itemBuilder:(context) {
            return const[
              PopupMenuItem<MenuAction>(
              value: MenuAction.logout,
              child : Text('Logout'),
              )
              ];
            
          }, )
        ],
      ),
      body: const Text('hello world'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
 return showDialog<bool>(context: context, builder: (context){
    return  AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure, wanna sign out'),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, 
        child: const Text('cancel')
        ),
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop(true);
        }, 
        child: const Text('log out')
        )
      ],
    );
  },
  ).then((value) => value ?? false);
}