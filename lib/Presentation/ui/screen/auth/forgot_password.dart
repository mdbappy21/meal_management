import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Presentation/utils/app_constant.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', height: 150),
              const SizedBox(height: 16),
              Text(
                "Enter Email to receive reset Password link",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildEmailField(),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _onTapSendLink,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(250, 50)
                ),
                child: Text('Send Link',style: TextStyle(color: Colors.black),),
              ),
              const Spacer(),
              _buildBottomPart(),
            ],
          ),
        ),
      ),
    );
  }

  //widgets Extractions//

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailTEController,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'Email/phone',
        labelText: 'Email/phone',
      ),
      validator: (String? value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Enter your Email';
        } else if (AppConstants.emailRegExp.hasMatch(value!) ==
            false) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildBottomPart() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: [
          TextSpan(text: 'Remember Password? '),
          TextSpan(
            text: 'Sign In',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
          ),
        ],
      ),
    );
  }

  //Functions//
  void _onTapSignInButton() {
    Get.back();
  }

  void _onTapSendLink() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTEController.text);
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
