import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';

class GradientRoundedButton extends StatelessWidget {
  final String text;
  final bool showLoadingIcon;
  final VoidCallback press;
  final Color? textColor;
  const GradientRoundedButton({
    super.key,
    required this.text,
    required this.press,
    this.textColor = MyColor.colorWhite,
    this.showLoadingIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 7),
              blurRadius: 12,
              color: Color.fromRGBO(29, 111, 251, 0.20),
            ),
          ],
          gradient: const LinearGradient(
            colors: [Color(0xFF2176FF), Color(0xFF0A55EB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showLoadingIcon)
              SizedBox(
                width: Dimensions.fontExtraLarge + 3,
                height: Dimensions.fontExtraLarge + 3,
                child: CircularProgressIndicator(color: textColor, strokeWidth: 2),
              )
            else
              Text(
                text.tr,
                style: regularDefault.copyWith(color: textColor, fontSize: Dimensions.fontMediumLarge),
              ),
            const SizedBox(width: 10),
            // Add any additional child widgets here
          ],
        ),
      ),
    );
  }
}
