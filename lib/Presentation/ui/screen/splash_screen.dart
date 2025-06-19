import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_management/Presentation/ui/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32,right:32,top: 32),
              child: Image.asset('assets/images/logo.png'),
            ),
            CupertinoActivityIndicator(
              radius: 20,
              animating: true,
            ),
            Text('Version 1.0.0'),
          ],
        ),
      ),
    );
  }

  Future<void>_moveToNextScreen()async{
    await Future.delayed(const Duration(seconds: 2));
    if(mounted){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }
}
