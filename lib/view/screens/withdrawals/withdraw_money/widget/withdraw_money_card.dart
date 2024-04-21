import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/withdraw/withdraw_money_controller.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_history/widget/status_widget.dart';

class WithdrawMoneyCard extends StatelessWidget {
  final int index;
  final VoidCallback press;

  const WithdrawMoneyCard({super.key, required this.index, required this.press});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawMoneyController>(
      builder: (controller) => GestureDetector(
        onTap: press,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
          decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: MyColor.getSymbolColor(index), shape: BoxShape.circle),
                        child: Text(
                          controller.currencySym,
                          style: regularDefault.copyWith(color: MyColor.colorWhite),
                        ),
                      ),
                      const SizedBox(width: Dimensions.space15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.withdrawMoneyList[index].name ?? "", style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600)),
                          const SizedBox(height: Dimensions.space5),
                          Text("${controller.withdrawMoneyList[index].withdrawMethod?.name ?? ""} - ${controller.currency}", style: regularSmall.copyWith(color: MyColor.getPrimaryColor())),
                          const SizedBox(height: Dimensions.space10),
                        ],
                      )
                    ],
                  ),
                  StatusWidget(status: controller.getStatusOrColor(index), color: controller.getStatusOrColor(index, isStatus: false))
                ],
              ),
              const CustomDivider(space: Dimensions.space10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MyStrings.limit.tr,
                          style: regularSmall.copyWith(color: MyColor.getTextColor().withOpacity(0.6)),
                        ),
                        const SizedBox(height: Dimensions.space5),
                        Text(
                            "${Converter.formatNumber(controller.withdrawMoneyList[index].minLimit ?? "")} ~ "
                            "${Converter.formatNumber(controller.withdrawMoneyList[index].maxLimit ?? "")} "
                            "${controller.currency}",
                            style: regularSmall.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimensions.space10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        MyStrings.charge.tr,
                        style: regularSmall.copyWith(color: MyColor.getTextColor().withOpacity(0.6)),
                      ),
                      const SizedBox(height: Dimensions.space5),
                      Text(
                          "${Converter.calculateRate(controller.withdrawMoneyList[index].withdrawMethod?.fixedCharge ?? '0', controller.withdrawMoneyList[index].withdrawMethod?.rate ?? '0')} "
                          "${controller.currency} + "
                          "${Converter.formatNumber(controller.withdrawMoneyList[index].withdrawMethod?.percentCharge ?? "")}%",
                          maxLines: 2,
                          style: regularSmall.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600)),
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
