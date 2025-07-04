import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/mess_info_model.dart';
import 'package:meal_management/Presentation/state_holder/create_mess_controller.dart';
import 'package:meal_management/Presentation/state_holder/mess_info_controller.dart';
import 'package:meal_management/Presentation/ui/screen/home_screen.dart';

class CreateMess extends StatefulWidget {
  const CreateMess({super.key});

  @override
  State<CreateMess> createState() => _CreateMessState();
}

class _CreateMessState extends State<CreateMess> {
  DateTime? selectedDate;
  final TextEditingController _messNameTEController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Image.asset('assets/images/logo.png',height: 120,),
            const SizedBox(height: 24),
            TextFormField(
              controller: _messNameTEController,
              decoration: InputDecoration(
                hintText: 'Mess Name',
                labelText: 'Mess Name'
              ),
            ),
            const SizedBox(height: 16),
            // OutlinedButton(
            //   onPressed: _selectDate,
            //   child: Text(
            //     selectedDate != null
            //         ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
            //         : 'select a date',
            //   ),
            // ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: (){
              _onTapConfirm();
            }, child: Text('Confirm'))
          ],
        ),
      ),
    );
  }
  Future<void>_onTapConfirm()async{
    CreateMessController createMessController=Get.find<CreateMessController>();
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

      String name=_messNameTEController.text;
      Map<String , dynamic>body={
        'name':name
      };

    bool success = await createMessController.createMess(token!,body);
    if (success) {
      Get.snackbar('Success', 'Successfully Create Mess');
      MessInfoController messInfoController=Get.find<MessInfoController>();
      bool messInfoGet=await messInfoController.getMessInfo(token);
      if(messInfoGet){
        MessInfoModel messInfoModel = messInfoController.messInfoModel!;
        Get.offAll(HomeScreen(messInfoModel:messInfoModel));
      }else{
        Get.snackbar('Error', 'Failed to get Mess Information Try login again');
      }
    } else {
      Get.snackbar('Failed',createMessController.errorMessage!);
    }
  }

  // Future<void> _selectDate() async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime(2025, 7, 25),
  //     firstDate: DateTime(2025, 7, 1),
  //     lastDate: DateTime(2025, 7, 30),
  //   );
  //
  //   setState(() {
  //     selectedDate = pickedDate;
  //   });
  // }
}
