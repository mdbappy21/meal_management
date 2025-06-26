import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/services/wrapper.dart';
import 'package:meal_management/Presentation/utils/app_constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final TextEditingController _confirmPasswordTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool _showPassword1=false;
  bool _showPassword2=false;
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
              _buildTextInputField(),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: _onTapNextButton,
                  child: Text('Sign Up',style: TextStyle(color: Colors.black),),
              ),
              const Spacer(),
              _buildBottomPart(),
            ],
          ),
        ),
      ),
    );
  }
  
//Widgets//
  Widget _buildTextInputField() {
    return Column(
      children: [
        TextFormField(
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
        ),
        const SizedBox(height: 16),
        TextFormField(
          obscureText: _showPassword1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _passwordTEController,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            suffixIcon: IconButton(
              onPressed: () {
                _showPassword1 = !_showPassword1;
                if (mounted) {
                  setState(() {});
                }
              },
              icon: Icon(
                _showPassword1 ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Enter Your password';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          obscureText: _showPassword2,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _confirmPasswordTEController,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            labelText: 'Confirm Password',
            suffixIcon: IconButton(
              onPressed: () {
                _showPassword2 = !_showPassword2;
                if (mounted) {
                  setState(() {});
                }
              },
              icon: Icon(
                _showPassword2 ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          validator: (String? value) {
            if (value?.trim().isEmpty ?? true ) {
              return 'Enter Your password';
            }else if (value != _passwordTEController.text) {
              return 'Password does not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignInMethod() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 4,
            color: Colors.white,
            child: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/images/googleIcon.png'),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 4,
            color: Colors.white,
            child: SizedBox(
              height: 40,
              width: 40,
              child: Icon(Icons.abc),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPart() {
    return Column(
      children: [
        Text('--------- Or Continue with --------'),
        const SizedBox(height: 24),
        _buildSignInMethod(),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(text: 'Already Have Account? '),
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = _onTapSignInButton,
              ),
            ],
          ),
        ),
      ],
    );
  }

//functions//
  void _onTapSignInButton() {
    Get.back();
  }
  void _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if(_passwordTEController.text.trim()==_confirmPasswordTEController.text.trim()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTEController.text, password: _passwordTEController.text);
      Get.offAll(Wrapper());
    }else {
      return;
    }

  }

  //functions//

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
