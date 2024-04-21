import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';
import 'package:viserpay_merchant/view/components/image/circle_shape_image.dart';

class InsightMoneyInSheetWidget extends StatefulWidget {
  const InsightMoneyInSheetWidget({super.key});

  @override
  State<InsightMoneyInSheetWidget> createState() => _InsightMoneyInSheetWidgetState();
}

class _InsightMoneyInSheetWidgetState extends State<InsightMoneyInSheetWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 5, width: 60,
            decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: Dimensions.space15),
        GestureDetector(
          onTap: () => Get.toNamed(RouteHelper.transactionHistoryScreen, arguments: MyStrings.plus),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space12, horizontal: Dimensions.space15),
            decoration: BoxDecoration(color: MyColor.transparentColor, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
            child: Row(
              children: [
                const CircleShapeImage(
                  image: MyImages.totalReceive,
                  imageColor: MyColor.colorBlack,
                ),
                const SizedBox(width: Dimensions.space12),
                Text(MyStrings.totalReceived.tr, style: regularDefault.copyWith(color: MyColor.colorBlack))
              ],
            ),
          ),
        ),
        const CustomDivider(space: Dimensions.space5),
        GestureDetector(
          onTap: () => Get.toNamed(RouteHelper.transactionHistoryScreen, arguments: ""),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space12, horizontal: Dimensions.space15),
            decoration: BoxDecoration(color: MyColor.transparentColor, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
            child: Row(
              children: [
                const CircleShapeImage(
                  image: MyImages.viewTransaction,
                  imageColor: MyColor.colorBlack,
                ),
                const SizedBox(width: Dimensions.space12),
                Text(MyStrings.viewTransactions.tr, style: regularDefault.copyWith(color: MyColor.colorBlack))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
