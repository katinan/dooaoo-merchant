import 'package:flutter/material.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';

class RoundedLoadingBtn extends StatelessWidget {
  final Color? textColor;
  final Color? bg;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;

  const RoundedLoadingBtn({
    super.key,
    this.width = 1,
    this.cornerRadius = 8,
    this.horizontalPadding = 35,
    this.verticalPadding = 18,
    this.textColor = MyColor.colorWhite,
    this.bg = MyColor.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadius),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: bg, shadowColor: MyColor.transparentColor, padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding - 3), textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
            child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: textColor, strokeWidth: 2)),
          )),
    );
  }
}
