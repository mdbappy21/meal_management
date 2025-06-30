import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Presentation/ui/screen/create_mess.dart';
import 'package:meal_management/Presentation/ui/screen/join_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/sign_in.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Type'),
        leading: Text(''),
        actions: [
          IconButton(onPressed: onTapSignOut, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 160),
            ElevatedButton(onPressed: (){
              Get.to(()=>JoinRequest());
            }, child: Text("Member")),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: (){
              Get.to(()=>CreateMess());
            }, child: Text("Manager")),
          ],
        ),
      ),
    );
  }

  Future<void> onTapSignOut() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.remove('isLoggedIn');
    Get.offAll(SignIn());
  }
}
