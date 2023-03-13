import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:platform_device_id/platform_device_id.dart';

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

  static Future<Map<String, String>> deviceParams() async {
    Map<String, String> params = {};
    var getDeviceId = await PlatformDeviceId.getDeviceId;
    String fcmToken = ""; //await Prefs.loadFCM();

    if (Platform.isIOS) {
      params.addAll({
        'device_id': getDeviceId!,
        'device_type': "I",
        'device_token': fcmToken,
      });
    } else {
      params.addAll({
        'device_id': getDeviceId!,
        'device_type': "A",
        'device_token': fcmToken,
      });
    }
    return params;
  }

  static String currentDate() {
    DateTime now = DateTime.now();

    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString()}:${now.minute.toString()}";
    return convertedDateTime;
  }
}