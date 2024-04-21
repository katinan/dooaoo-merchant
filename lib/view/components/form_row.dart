import 'package:flutter/material.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

class FormRow extends StatelessWidget {

  final String label;
  final bool isRequired;

  const FormRow({super.key,
    required this.label,
    required this.isRequired
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: regularDefault.copyWith(color: MyColor.getLabelTextColor()),),
        Text(isRequired?' *':'',style: boldDefault.copyWith(color: Colors.red))
      ],
    );
  }
}
