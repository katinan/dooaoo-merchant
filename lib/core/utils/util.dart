import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';

class MyUtils {
  static int otpTime = 60;

  static splashScreen() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: MyColor.getPrimaryColor(), statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.getPrimaryColor(), systemNavigationBarIconBrightness: Brightness.light));
  }

  static homescreen() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MyColor.colorWhite,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: MyColor.colorWhite,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static allScreen() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColor.colorWhite,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: MyColor.colorWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  static dynamic getBottomSheetShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ];
  }

  static dynamic getCardShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }
}
