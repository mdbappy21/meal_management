import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_management/Presentation/ui/screen/auth/sign_in.dart';
import 'package:meal_management/Presentation/ui/screen/auth/verify_email.dart';
import 'package:meal_management/Presentation/ui/screen/home_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!.emailVerified){
              return HomeScreen();
            }else{
              return VerifyEmail();
            }
          }
          else{
            return SignIn();
          }
        },
      ),
    );
  }
}
