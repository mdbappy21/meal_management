import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';
import 'package:meal_management/Presentation/state_holder/join_request_controller.dart';

class JoinRequest extends StatefulWidget {
  const JoinRequest({super.key});

  @override
  State<JoinRequest> createState() => _JoinRequestState();
}

class _JoinRequestState extends State<JoinRequest> {
  final TextEditingController _messNameTEController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Mess'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _messNameTEController,
                decoration: InputDecoration(
                  hintText: 'Enter your Mess Name',
                  labelText: 'Mess Name'
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _onTapRequestSent, child: Text('Join request Sent'))
            ],
          ),
        ),
      ),
    );
  }
  Future<void>_onTapRequestSent()async{
    JoinRequestController joinRequestController=Get.find<JoinRequestController>();
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool isSuccess= await joinRequestController.sentJoinRequest(token!, _messNameTEController.text.trim());
    if(isSuccess){
      // Get.offAll(()=>HomeScreen());
      Get.snackbar('success', 'Join request Sent');
    }else{
      // Get.offAll(() => const UserType());
      Get.snackbar('failed', '${joinRequestController.errorMassage}');
    }
  }
}
