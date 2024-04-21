import 'package:flutter/material.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

class ExtraSmallText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
  const ExtraSmallText({
    super.key,
    required this.text,
    this.textAlign,
    this.textStyle = lightExtraSmall
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
    );
  }
}
