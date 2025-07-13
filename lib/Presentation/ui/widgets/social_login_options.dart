import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_management/Data/services/wrapper.dart';

class SocialLoginOptions extends StatelessWidget {
  final bool isLoading;
  final Function(bool) onLoadingChanged;

  const SocialLoginOptions({
    super.key,
    required this.isLoading,
    required this.onLoadingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('--------- Or Continue with --------'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSignInOptions(
              onTap: _handleGoogleSignIn,
              iconImage: Image.asset('assets/images/googleIcon.png'),
            ),
            const SizedBox(width: 16),
            _buildSignInOptions(onTap: () {}, iconImage: Icon(Icons.phone)),
          ],
        ),
      ],
    );
  }

  //Widgets //

  Widget _buildSignInOptions({required VoidCallback onTap, required Widget iconImage,}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: SizedBox(height: 40, width: 40, child: iconImage),
      ),
    );
  }

  //Functions //

  Future<void> _handleGoogleSignIn() async {
    onLoadingChanged(true);
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut(); // Clear any previous session
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        onLoadingChanged(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setBool('isLoggedIn', true);

      onLoadingChanged(false);
      Get.offAll(() => Wrapper());
    } on FirebaseException catch (e) {
      onLoadingChanged(false);
      Get.snackbar('Firebase Error', e.message ?? 'Something went wrong.');
    } catch (e) {
      onLoadingChanged(false);
      Get.snackbar('Google Sign-In Error', e.toString());
    }
  }
}
