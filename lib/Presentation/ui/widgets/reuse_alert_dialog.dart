import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReuseAlertDialog {
  static Future<void> showAlertDialog({
    required String title,
    required String middleText,
    required VoidCallback onConfirm,
    String cancelText = 'No',
    String confirmText = 'Yes',
  }) async {
    Get.defaultDialog(
      backgroundColor: Colors.grey.shade400,
      buttonColor: Colors.red,
      title: title,
      middleText: middleText,
      textCancel: cancelText,
      textConfirm: confirmText,
      barrierDismissible: false,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        onConfirm();
      },
    );
  }
}
