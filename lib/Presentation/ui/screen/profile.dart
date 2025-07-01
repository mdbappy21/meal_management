import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Presentation/state_holder/leave_mess_controller.dart';
import 'package:meal_management/Presentation/ui/screen/user_type.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final LeaveMessController leaveMessController=Get.find<LeaveMessController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Information')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Phone No',
                  labelText: 'Phone No',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'City Name',
                  labelText: 'City Name',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Mess Name',
                  labelText: 'Mess Name',
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  _leaveMess();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Leave Mess'),
                    Icon(Icons.logout),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: () {}, child: Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
  Future<void>_leaveMess()async{
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool success = await Get.find<LeaveMessController>().leaveMess(token!);
    if (success) {
      Get.snackbar('Success', 'Successfully Leave Mess');
      Get.offAll(()=>UserType());
    } else {
      Get.snackbar('Failed to Fetch data', leaveMessController.errorMessage!);
    }
  }
}
