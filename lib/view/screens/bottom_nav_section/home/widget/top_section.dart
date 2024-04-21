import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/home/home_controller.dart';
import 'package:viserpay_merchant/view/components/circle_image_button.dart';

class TopSection extends StatefulWidget {
  final GlobalKey<ScaffoldState> bootomNavscaffoldKey;

  const TopSection({super.key, required this.bootomNavscaffoldKey});

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
        decoration: BoxDecoration(color: MyColor.getPrimaryColor()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Hero(
                tag: "profile_tag",
                child: CircleImageWidget(
                    height: 40,
                    width: 40,
                    isProfile: true,
                    isAsset: false,
                    imagePath: controller.imagePath,
                    press: () {
                      Get.toNamed(RouteHelper.profileScreen);
                    }),
              ),
              const SizedBox(width: Dimensions.space10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.username, // dynamic
                      style: regularDefault.copyWith(color: MyColor.colorWhite, fontWeight: FontWeight.w500)),
                  const SizedBox(height: Dimensions.space5),
                  BalanceCard(controller: controller)
                ],
              )
            ]),
            const SizedBox(width: Dimensions.space15),
          ],
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  HomeController controller;
  BalanceCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///Button
                Material(
                  type: MaterialType.canvas,
                  color: MyColor.borderColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      controller.changeState();
                    },
                    child: Obx(
                      () => Container(
                        width: 160,
                        height: 28,
                        decoration: BoxDecoration(color: MyColor.transparentColor, borderRadius: BorderRadius.circular(50)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedOpacity(
                              opacity: controller.isBalanceShown.value ? 1 : 0,
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                "${Converter.formatNumber(controller.userBalance)} ${controller.defaultCurrency}",
                                style: const TextStyle(color: MyColor.colorWhite, fontSize: 14),
                              ),
                            ),

                            /// tapForBalance
                            AnimatedOpacity(
                              opacity: controller.isBalance.value ? 1 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                MyStrings.tapForBalance,
                                style: TextStyle(color: MyColor.colorWhite.withOpacity(0.8), fontSize: 14),
                              ),
                            ),

                            /// Circle
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 1100),
                              left: controller.isAnimation.value == false ? 5 : 135,
                              curve: Curves.fastOutSlowIn,
                              child: Container(
                                height: 20,
                                width: 20,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(color: MyColor.primaryColor.withOpacity(0.9), borderRadius: BorderRadius.circular(50)),
                                child: FittedBox(
                                  child: Text(
                                    controller.defaultCurrencySymbol,
                                    style: const TextStyle(color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
