import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_icons.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/home/home_controller.dart';
import 'package:viserpay_merchant/view/components/image/circle_shape_image.dart';

class WithdrawSection extends StatelessWidget {
  const WithdrawSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
              decoration: BoxDecoration(color: MyColor.getCardBgColor()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        MyStrings.withdraw.tr,
                        style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                          onTap: () => Get.toNamed(RouteHelper.withdrawHistoryScreen),
                          child: Container(
                            padding: const EdgeInsets.all(Dimensions.space5),
                            alignment: Alignment.center,
                            child: Text(
                              MyStrings.viewHistory.tr,
                              style: regularSmall.copyWith(color: MyColor.primaryColor),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(Dimensions.space15),
                    decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius), border: Border.all(color: MyColor.colorGrey.withOpacity(0.2), width: 0.5)),
                    child: Row(
                      children: [
                        const CircleShapeImage(
                          isSvgImage: true,
                          image: MyIcons.arrowUp,
                        ),
                        const SizedBox(width: Dimensions.space15),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                MyStrings.totalWithdraw.tr,
                                style: regularDefault.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: Dimensions.space12),
                              Text(
                                controller.totalWithdraw,
                                style: regularMediumLarge.copyWith(fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
