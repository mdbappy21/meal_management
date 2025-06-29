import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Presentation/ui/screen/splash_screen.dart';
import 'package:meal_management/controller_binders.dart';

class MealManagement extends StatelessWidget {
  const MealManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.light,
      home: SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData();
  }

  ThemeData _lightTheme() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: _outlineInputBorder(),
        enabledBorder: _outlineInputBorder(Colors.blue),
        focusedBorder: _outlineInputBorder(Colors.teal),
        errorBorder: _outlineInputBorder(Colors.red),
        hintStyle: TextStyle(fontWeight: FontWeight.w400),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade300,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
        ),
      )

    );
  }
  OutlineInputBorder _outlineInputBorder([Color? color]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? Colors.blue, width: 1.2),
      borderRadius: BorderRadius.circular(8),
    );
  }

}
