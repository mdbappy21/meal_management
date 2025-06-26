import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Presentation/ui/screen/create_mess.dart';
import 'package:meal_management/Presentation/ui/screen/join_request.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Get.to(()=>JoinRequest());
            }, child: Text("Member")),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: (){
              Get.to(()=>CreateMess());
            }, child: Text("Manager")),
          ],
        ),
      ),
    );
  }
}
