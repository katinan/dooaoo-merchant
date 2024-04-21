import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({super.key, required this.name, required this.hasError});

  final String name;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          avatar: Icon(
            hasError ? Icons.cancel : Icons.check_circle,
            color: hasError ? Colors.red : Colors.green,
            size: 15,
          ),
          label: Text(
            name.tr,
            style: regularSmall.copyWith(
              fontSize: Dimensions.fontExtraSmall,
              color: hasError ? Colors.red : Colors.green,
            ),
          ),
          backgroundColor: MyColor.colorWhite,
          surfaceTintColor: MyColor.transparentColor,
          side: const BorderSide(color: MyColor.borderColor, width: .5),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}