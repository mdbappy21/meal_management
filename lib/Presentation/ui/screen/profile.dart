import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/my_info_model.dart';
import 'package:meal_management/Presentation/state_holder/leave_mess_controller.dart';
import 'package:meal_management/Presentation/state_holder/update_info_controller.dart';
import 'package:meal_management/Presentation/ui/screen/user_type.dart';
import 'package:meal_management/Presentation/utils/app_constant.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.myInfoModel});
  final MyInfoModel myInfoModel;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameTEController=TextEditingController();
  final TextEditingController _phoneNoTEController=TextEditingController();
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _cityNameTEController=TextEditingController();
  final TextEditingController _messNameTEController=TextEditingController();
  final LeaveMessController leaveMessController=Get.find<LeaveMessController>();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameTEController.text=widget.myInfoModel.name??'N/A';
    _phoneNoTEController.text=widget.myInfoModel.phone??'N/A';
    _emailTEController.text=widget.myInfoModel.email ?? 'N/A';
    _cityNameTEController.text=widget.myInfoModel.city ?? 'N/A';
    _messNameTEController.text=widget.myInfoModel.messName ?? 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Information')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameTEController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneNoTEController,
                  decoration: InputDecoration(
                    hintText: 'Phone No',
                    labelText: 'Phone No',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your phone Number';
                    } else if (AppConstants.numberRegExp.hasMatch(value!) == false) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailTEController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email'
                    // labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cityNameTEController,
                  decoration: InputDecoration(
                    hintText: 'City Name',
                    labelText: 'City Name',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _messNameTEController,
                  readOnly: true,
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
                ElevatedButton(onPressed: _onTapUpdateButton, child: Text('Update')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Functions //
  Future<void>_onTapUpdateButton()async{
    if(!_formKey.currentState!.validate()){
      return;
    }
    String name=_nameTEController.text.trim();
    String phone=_phoneNoTEController.text;
    String city=_cityNameTEController.text.trim();
    Map<String,dynamic>body={
      'name': name,
      'phone': phone,
      'city': city,
    };
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    UpdateInfoController updateInfoController=Get.find<UpdateInfoController>();
    bool success = await updateInfoController.updateInfo(token!,body);
    if(success){
      Get.snackbar('Success', 'Successfully Update Info');
      if(mounted){
        FocusScope.of(context).unfocus();
      }
    }
    else{
      Get.snackbar('Failed',updateInfoController.errorMessage! );
    }
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

  @override
  void dispose() {
    _nameTEController.dispose();
    _phoneNoTEController.dispose();
    _emailTEController.dispose();
    _cityNameTEController.dispose();
    _messNameTEController.dispose();
    super.dispose();
  }
}
