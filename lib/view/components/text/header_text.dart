import 'package:flutter/material.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
  const HeaderText({
    super.key,
    required this.text,
    this.textAlign,
    this.textStyle = semiBoldOverLarge
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle.copyWith(color: MyColor.getHeadingTextColor()),
    );
  }
}
