import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/view/components/buttons/rounded_button.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

showExitDialog(BuildContext context) {
  AwesomeDialog(
    padding: const EdgeInsets.symmetric(vertical: Dimensions.space10),
    context: context,
    dialogType: DialogType.noHeader,
    dialogBackgroundColor: MyColor.getCardBgColor(),
    width: MediaQuery.of(context).size.width,
    buttonsBorderRadius: BorderRadius.circular(Dimensions.defaultRadius),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    onDismissCallback: (type) {},
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: MyStrings.exitTitle.tr,
    titleTextStyle: regularLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w600),
    showCloseIcon: false,
    btnCancel: RoundedButton(
      text: MyStrings.no.tr,
      press: () {
        Navigator.pop(context);
      },
      horizontalPadding: 3,
      verticalPadding: 5,
      color: MyColor.getHintTextColor(),
      isColorChange: true,
    ),
    btnOk: RoundedButton(
      text: MyStrings.yes.tr,
      press: () {
        FlutterExitApp.exitApp();

        SystemNavigator.pop();
      },
      horizontalPadding: 3,
      verticalPadding: 5,
      color: MyColor.colorRed,
      textColor: MyColor.colorWhite,
      isColorChange: true,
    ),
    btnCancelOnPress: () {},
    btnOkOnPress: () {
                      FlutterExitApp.exitApp();

      SystemNavigator.pop();
    },
  ).show();
}
