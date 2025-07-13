import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/services/wrapper.dart';
import 'package:meal_management/Presentation/ui/screen/auth/forgot_password.dart';
import 'package:meal_management/Presentation/ui/screen/auth/sign_up.dart';
import 'package:meal_management/Presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:meal_management/Presentation/ui/widgets/social_login_options.dart';
import 'package:meal_management/Presentation/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _showPassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 54
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', height: 150),
                    const SizedBox(height: 16),
                    _buildTextInputField(),
                    _buildSignInAndForgotButton(),
                    const SizedBox(height: 48),
                    SocialLoginOptions(
                      isLoading: _isGoogleLoading,
                      onLoadingChanged: (value) {
                        if (mounted) {
                          setState(() {
                            _isGoogleLoading = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildBottomText(),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isGoogleLoading)
          const CenteredCircularProgressIndicator(),
      ],
    );
  }

  //Widgets Extractions//
  Widget _buildSignInAndForgotButton() {
    return Column(
      children: [
        Visibility(
          visible: !_isLoading,
          replacement: CenteredCircularProgressIndicator(),
          child: ElevatedButton(
            onPressed: _onTapNextButton,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50),
            ),
            child: const Text('Sign In', style: TextStyle(color: Colors.black)),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to(() => ForgotPassword());
          },
          child: const Text(
            "Forgot Password",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomText() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16, color: Colors.black),
        children: [
          const TextSpan(text: 'Not a member? '),
          TextSpan(
            text: 'Register Now',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,
          ),
        ],
      ),
    );
  }

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
            } else if (AppConstants.emailRegExp.hasMatch(value!) == false) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          obscureText: _showPassword,
          controller: _passwordTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            suffixIcon: IconButton(
              onPressed: () {
                _showPassword = !_showPassword;
                if (mounted) {
                  setState(() {});
                }
              },
              icon: Icon(
                _showPassword ? Icons.visibility_off : Icons.visibility,
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
        const SizedBox(height: 24),
      ],
    );
  }

  // Functions //
  void _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _isLoading=true;
    setState(() {});
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTEController.text, password: _passwordTEController.text.trim());
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool('isLoggedIn', true);
      Get.to(() => Wrapper());

    }on FirebaseAuthException catch(e){
      Get.snackbar('Login Failed', e.code);
    } catch(e){
      Get.snackbar('Login Failed', e.toString());
    }
    _isLoading=false;
    setState(() {});
  }

  void _onTapSignUpButton() {
    Get.to(() => SignUp());
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
