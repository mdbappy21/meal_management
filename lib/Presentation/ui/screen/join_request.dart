import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Presentation/state_holder/cancel_request_controller.dart';
import 'package:meal_management/Presentation/state_holder/join_request_controller.dart';
import 'package:meal_management/Presentation/ui/widgets/reuse_alert_dialog.dart';

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
              ElevatedButton(onPressed: _onTapRequestSent, child: Text('Sent Join request')),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: (){
                ReuseAlertDialog.showAlertDialog(title: 'Cancel Join request', middleText: 'Are you sure you cancel the join request', onConfirm: _onTapCancelRequest);
              }, child: Text('Cancel Join request')),
            ],
          ),
        ),
      ),
    );
  }
  Future<void>_onTapRequestSent()async{
    FocusScope.of(context).unfocus();
    JoinRequestController joinRequestController=Get.find<JoinRequestController>();
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    String name=_messNameTEController.text.trim();
    Map<String , dynamic>body={
      'mess_name':name
    };
    _messNameTEController.clear();
    bool isSuccess= await joinRequestController.sentJoinRequest(token!, body);
    if(isSuccess){
      Get.snackbar('success', 'Join request Sent');
    }else{
      Get.snackbar('Failed', '${joinRequestController.errorMassage}');
    }
  }
  Future<void>_onTapCancelRequest()async{
    CancelRequestController cancelRequestController=Get.find<CancelRequestController>();
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    bool isSuccess= await cancelRequestController.cancelJoinRequest(token!);
    if(isSuccess){
      Get.snackbar('Success', 'Join request cancel');
      Get.close(1);
    }else{
      Get.snackbar('Failed', '${cancelRequestController.errorMessage}');
      Get.close(1);
    }
  }
}
