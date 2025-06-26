import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_management/Data/services/wrapper.dart';
import 'package:meal_management/Presentation/ui/screen/auth/forgot_password.dart';
import 'package:meal_management/Presentation/ui/screen/auth/sign_up.dart';
import 'package:meal_management/Presentation/ui/widgets/centered_circular_progress_indicator.dart';
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
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const SizedBox(height: 48),
                const Text('--------- Or Continue with --------'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _onTapGoogleSignIn,
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
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: (){},
                      child: Card(
                        elevation: 4,
                        color: Colors.white,
                        child: const SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(Icons.phone),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                RichText(
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
                        recognizer: TapGestureRecognizer()
                          ..onTap = _onTapSignUpButton,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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

  void _onTapNextButton() async {
    _isLoading=true;
    setState(() {});
    if (!_formKey.currentState!.validate()) {
      return;
    }
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

  Future<void> _onTapGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
     final GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();

     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );
     await FirebaseAuth.instance.signInWithCredential(credential);
     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     await sharedPreferences.setBool('isLoggedIn', true);
     Get.to(() => Wrapper());
    } catch (e) {
      print(e);
      Get.snackbar('Google Sign-In Error', e.toString());
    }
  }




  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
