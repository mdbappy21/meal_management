import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/services/wrapper.dart';
import 'package:meal_management/Presentation/ui/screen/auth/sign_in.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 8),
            Text(
              'A verification link has been sent to your email. Verify to continue. Verification Link Send to : ${FirebaseAuth.instance.currentUser!.email}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            ElevatedButton(
              onPressed: () {
                sendVerifyLink();
              },
              child: Text("Send link again"),
            ),

            ElevatedButton(
              onPressed: () {
                Get.offAll(SignIn());
              },
              child: Text("Wrong Email Enter?"),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  //Functions//
  @override
  void initState() {
    super.initState();
    sendVerifyLink();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
          (_) => checkEmailVerified(),
    );
  }

  Future<void> sendVerifyLink() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Get.snackbar('Verification Link Sent', 'Check your email inbox.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> checkEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      _timer?.cancel();
      Get.offAll(() => const Wrapper());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
