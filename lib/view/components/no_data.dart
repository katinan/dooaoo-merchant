import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

class NoDataWidget extends StatelessWidget {
  final double margin;
  final String? noDataText;
  final String? subText;
  bool? hideBtn;
  NoDataWidget({
    super.key,
    this.margin = 4,
    this.noDataText,
    this.subText,
    this.hideBtn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            MyImages.noData,
            height: 120,
            width: 120,
            repeat: false,
          ),
          const SizedBox(height: Dimensions.space3),
          Text(
            noDataText ?? MyStrings.noDataFound.tr,
            style: regularLarge.copyWith(color: MyColor.getTextColor()),
          ),
          const SizedBox(height: Dimensions.space3),
          Text(
            subText ?? ''.tr,
            style: regularLarge.copyWith(color: MyColor.getTextColor()),
            textAlign: TextAlign.center,
          ),
          hideBtn! ? const SizedBox.shrink() : const SizedBox(height: Dimensions.space50),
          hideBtn!
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space35, vertical: Dimensions.space10),
                    decoration: BoxDecoration(
                      color: MyColor.primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 7),
                          blurRadius: 12,
                          color: Color.fromRGBO(29, 111, 251, 0.20),
                        ),
                        BoxShadow(
                          offset: Offset(0, -5),
                          blurRadius: 12,
                          color: Color.fromRGBO(29, 111, 251, 0.20),
                        ),
                      ],
                    ),
                    child: Text(
                      MyStrings.goBack.tr,
                      style: regularDefault.copyWith(color: MyColor.colorWhite),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
