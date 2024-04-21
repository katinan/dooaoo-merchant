import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/date_converter.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/home/home_controller.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';

class LatestTransactionCard extends StatelessWidget {
  final int index;
  final bool isShowDivider;
  final VoidCallback press;
  const LatestTransactionCard({super.key, required this.index, required this.press, this.isShowDivider = true});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return GestureDetector(
          onTap: press,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: MyColor.transparentColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: controller.trxList[index].trxType == "-" ? MyColor.colorRed.withOpacity(0.2) : MyColor.colorGreen.withOpacity(0.2), shape: BoxShape.circle),
                            child: Icon(
                              controller.trxList[index].trxType == "-" ? Icons.arrow_upward : Icons.arrow_downward,
                              color: controller.trxList[index].trxType == "-" ? MyColor.colorRed : MyColor.colorGreen,
                              size: 20,
                            )),
                        const SizedBox(width: Dimensions.space12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.trxList[index].remark}".replaceAll("_", " ").toTitleCase().tr,
                              style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: Dimensions.space10),
                            SizedBox(
                              width: 150,
                              child: Text(
                                controller.trxList[index].details?.tr ?? "",
                                style: regularSmall.copyWith(color: MyColor.getTextColor()),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateConverter.convertIsoToString(controller.trxList[index].createdAt ?? ""),
                          style: regularSmall.copyWith(color: MyColor.getTextColor().withOpacity(0.5)),
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Text("${controller.defaultCurrency} ${Converter.formatNumber(controller.trxList[index].amount ?? "")}", style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600))
                      ],
                    )
                  ],
                ),
                isShowDivider
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
                        child: CustomDivider(space: 20, color: MyColor.colorBlack.withOpacity(0.2)),
                      )
                    : const SizedBox(height: Dimensions.space20)
              ],
            ),
          ));
    });
  }
}
