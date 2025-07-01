import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/mess_info_model.dart';
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
  bool _isLoading = true;
  MessInfoModel? messInfoModel;
  final user = FirebaseAuth.instance.currentUser;
  final MessInfoController messInfoController=Get.find<MessInfoController>();


  @override
  void initState() {
    super.initState();
    _checkMessStatus();
  }

  Future<void> _checkMessStatus() async {

    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (!user!.emailVerified) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final token = await user!.getIdToken();
    _isJoinMess = await messInfoController.getMessInfo(token!);
    messInfoModel = messInfoController.messInfoModel;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (user == null) {
      return const SignIn();
    }

    if (!user!.emailVerified) {
      return VerifyEmail();
    }

    if (_isJoinMess) {
      return HomeScreen(messInfoModel: messInfoModel);
    } else {
      return const UserType();
    }
  }
}
