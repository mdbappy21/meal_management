import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/mess_info_model.dart';
import 'package:meal_management/Data/models/network_response.dart';
import 'package:meal_management/Data/services/network_caller.dart';
import 'package:meal_management/Data/utils/urls.dart';
import 'package:meal_management/Presentation/state_holder/mess_info_controller.dart';
import 'package:meal_management/Presentation/ui/screen/auth/sign_in.dart';
import 'package:meal_management/Presentation/ui/screen/auth/verify_email.dart';
import 'package:meal_management/Presentation/ui/screen/home_screen.dart';
import 'package:meal_management/Presentation/ui/screen/user_type.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _isJoinMess = false;
  MessInfoModel? messInfoModel;
  final user = FirebaseAuth.instance.currentUser;
  final MessInfoController messInfoController=Get.find<MessInfoController>();


  @override
  void initState() {
    super.initState();
    _checkMessStatus();
  }

  void _checkMessStatus() async {
    if (user != null && user!.emailVerified) {
      _isJoinMess = await _getMessData();
      print(_isJoinMess);
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!.emailVerified){
              if(_isJoinMess){
                return HomeScreen(messInfoModel: messInfoModel,);
              }else{
                return UserType();
              }
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
  Future<bool> _getMessData() async {
    try{
      final token = await user!.getIdToken();
      bool isSuccess= await messInfoController.getMessInfo('$token');
      messInfoModel=messInfoController.messInfoModel;
      print(messInfoModel);
      if(isSuccess){
        return true;
      }else{
        return false;
      }
    }catch(e){
      Get.snackbar('Failed', 'Something Went Wrong');
      return false;
    }
  }
}
