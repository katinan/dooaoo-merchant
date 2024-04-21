import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/home/home_controller.dart';

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
                                MyStrings.tapForBalance.tr,
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
