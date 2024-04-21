import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:another_flushbar/flushbar.dart';

class CustomSnackBar {
  static error({required List<String> errorList, int duration = 3}) {
    String message = '';
    if (errorList.isEmpty) {
      message = MyStrings.somethingWentWrong.tr;
    } else {
      for (var element in errorList) {
        String tempMessage = element.tr;
        message = message.isEmpty ? tempMessage : "$message\n$tempMessage";
      }
    }
    message = Converter.removeQuotationAndSpecialCharacterFromString(message);
    if (Get.context == null) {
      Get.rawSnackbar(
        progressIndicatorBackgroundColor: MyColor.transparentColor,
        progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(Colors.transparent),
        messageText: Text(message, style: regularLarge.copyWith(color: MyColor.colorWhite)),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: MyColor.colorRed,
        borderRadius: 4,
        margin: const EdgeInsets.all(Dimensions.space8),
        padding: const EdgeInsets.all(Dimensions.space8),
        duration: Duration(seconds: duration),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeIn,
        showProgressIndicator: true,
        leftBarIndicatorColor: MyColor.transparentColor,
        animationDuration: const Duration(seconds: 1),
        borderColor: MyColor.transparentColor,
        reverseAnimationCurve: Curves.easeOut,
        borderWidth: 2,
      );
    } else {
      Flushbar(
        message: message,
        margin: const EdgeInsets.all(Dimensions.space10),
        borderRadius: BorderRadius.circular(Dimensions.cardRadius),
        backgroundColor: MyColor.colorRed,
        duration: Duration(seconds: duration),
        leftBarIndicatorColor: MyColor.colorRed,
      ).show(Get.context!);
    }
  }

  static success({required List<String> successList, int duration = 3, BuildContext? context}) {
    String message = '';
    if (successList.isEmpty) {
      message = MyStrings.somethingWentWrong.tr;
    } else {
      for (var element in successList) {
        String tempMessage = element.tr;
        message = message.isEmpty ? tempMessage : "$message\n$tempMessage";
      }
    }
    message = Converter.removeQuotationAndSpecialCharacterFromString(message);
    Get.rawSnackbar(
      progressIndicatorBackgroundColor: MyColor.colorGreen,
      progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(MyColor.transparentColor),
      messageText: Text(message, style: regularLarge.copyWith(color: MyColor.colorWhite)),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: MyColor.colorGreen,
      borderRadius: 4,
      margin: const EdgeInsets.all(Dimensions.space8),
      padding: const EdgeInsets.all(Dimensions.space8),
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
      showProgressIndicator: true,
      leftBarIndicatorColor: MyColor.transparentColor,
      animationDuration: const Duration(seconds: 2),
      borderColor: MyColor.transparentColor,
      reverseAnimationCurve: Curves.easeOut,
      borderWidth: 2,
    );
    // Flushbar(
    //   message: message,
    //   icon: const Icon(
    //     Icons.info_outline,
    //     size: 28.0,
    //     color: Colors.white,
    //   ),
    //   margin: const EdgeInsets.all(Dimensions.space10),
    //   borderRadius: BorderRadius.circular(Dimensions.cardRadius),
    //   backgroundColor: MyColor.greenSuccessColor,
    //   duration: Duration(seconds: duration),
    //   leftBarIndicatorColor: MyColor.greenSuccessColor,
    // ).show(context ?? Get.context!);
  }
}

// class CustomSnackBar{
//   static  error({required List<String>errorList,int duration=5}){
//     String message='';
//     if(errorList.isEmpty){
//       message = MyStrings.somethingWentWrong.tr;
//     }else{
//       for (var element in errorList) {
//         String tempMessage = element.tr;
//         message = message.isEmpty?tempMessage:"$message\n$tempMessage";
//       }
//     }
//     message = Converter.removeQuotationAndSpecialCharacterFromString(message);
//     Get.rawSnackbar(
//       progressIndicatorBackgroundColor: MyColor.transparentColor,
//       progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(Colors.transparent),
//       messageText: Text(message,style: regularLarge.copyWith(color: MyColor.colorWhite)),
//       dismissDirection: DismissDirection.horizontal,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: MyColor.colorRed,
//       borderRadius: 4,
//       margin: const EdgeInsets.all(Dimensions.space8),
//       padding: const EdgeInsets.all(Dimensions.space8),
//       duration:  Duration(seconds: duration),
//       isDismissible: true,
//       forwardAnimationCurve: Curves.easeIn,
//       showProgressIndicator: true,
//       leftBarIndicatorColor: MyColor.transparentColor,
//       animationDuration: const Duration(seconds: 1),
//       borderColor: MyColor.transparentColor,
//       reverseAnimationCurve:Curves.easeOut,
//       borderWidth: 2,
//     );
//   }


//   static  success({required List<String>successList,int duration=5}){
//     String message='';
//     if(successList.isEmpty){
//       message = MyStrings.somethingWentWrong.tr;
//     }
//     else{
//       for (var element in successList) {
//         String tempMessage = element.tr;
//         message = message.isEmpty?tempMessage:"$message\n$tempMessage";
//       }
//     }
//     message = Converter.removeQuotationAndSpecialCharacterFromString(message);
//     Get.rawSnackbar(
//       progressIndicatorBackgroundColor: MyColor.colorGreen,
//       progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(MyColor.transparentColor),
//       messageText: Text(message, style: regularLarge.copyWith(color: MyColor.colorWhite)),
//       dismissDirection: DismissDirection.horizontal,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: MyColor.colorGreen,
//       borderRadius: 4,
//       margin: const EdgeInsets.all(Dimensions.space8),
//       padding: const EdgeInsets.all(Dimensions.space8),
//       duration:  Duration(seconds: duration),
//       isDismissible: true,
//       forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
//       showProgressIndicator: true,
//       leftBarIndicatorColor: MyColor.transparentColor,
//       animationDuration: const Duration(seconds: 2),
//       borderColor: MyColor.transparentColor,
//       reverseAnimationCurve:Curves.easeOut,
//       borderWidth: 2,
//     );
//   }
// }