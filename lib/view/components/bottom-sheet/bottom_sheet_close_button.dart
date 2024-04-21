import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';

class BottomSheetCloseButton extends StatelessWidget {
  const BottomSheetCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        height: 30, width: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimensions.space5),
        decoration: const BoxDecoration(color: MyColor.screenBgColor, shape: BoxShape.circle),
        child: const Icon(Icons.clear, color: MyColor.colorBlack, size: 15),
      ),
    );
  }
}
