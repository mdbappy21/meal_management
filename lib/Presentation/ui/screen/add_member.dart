import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Presentation/state_holder/add_member_controller.dart';
import 'package:meal_management/Presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:meal_management/Presentation/utils/app_constant.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final TextEditingController _emailTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  AddMemberController addMemberController=Get.find<AddMemberController>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add Member'),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildEmailField(),
              const SizedBox(height: 16),
              GetBuilder<AddMemberController>(
                builder: (addMemberController) {
                  return Visibility(
                    visible: !addMemberController.inProgress,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapAddMember, child: Text('Add'),
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  //Widgets //

  Widget _buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailTEController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          hintText: 'Enter Member Email',
          labelText: 'Enter Email/Phone'
      ),
      validator: (String? value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Enter your Email';
        } else if (AppConstants.emailRegExp.hasMatch(value!) == false) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }

  //Functions //

  Future<void>_onTapAddMember()async{
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool success = await addMemberController.addMember(token!, _emailTEController.text);
    if (success) {
      _emailTEController.clear();
      if(mounted){
        FocusScope.of(context).unfocus();
      }
      Get.snackbar('Success', 'Successfully Added Member');
    } else {
      Get.snackbar('Failed to Fetch data', addMemberController.errorMessage!);
      _emailTEController.clear();
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
