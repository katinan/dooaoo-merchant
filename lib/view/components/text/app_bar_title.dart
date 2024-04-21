import 'package:flutter/material.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

class AppBarTitle extends StatelessWidget {
  final String text;
  final Color textColor;
  const AppBarTitle({
    super.key,
    required this.text,
    this.textColor = MyColor.primaryTextColor
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: regularLarge.copyWith(color: textColor, fontWeight: FontWeight.w500),
    );
  }
}
