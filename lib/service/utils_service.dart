import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class Utils {

  static showToast(String msg, BuildContext context) {
    MotionToast.error(
      title: const Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(msg),
      position: MotionToastPosition.bottom,
      barrierColor: Colors.black.withOpacity(0.3),
      width: double.infinity,
      padding: EdgeInsets.only(left: 30, right: 30),
      height: 80,
      animationDuration: const Duration(milliseconds: 1000),
      dismissable: false,
    ).show(context);
  }
}