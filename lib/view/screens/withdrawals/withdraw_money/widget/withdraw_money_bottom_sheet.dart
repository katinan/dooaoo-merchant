import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/withdraw/withdraw_money_controller.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_amount_text_field.dart';
import 'package:viserpay_merchant/view/components/text/bottom_sheet_header_text.dart';

class WithdrawMoneyBottomSheet extends StatelessWidget {
  final int index;

  const WithdrawMoneyBottomSheet({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawMoneyController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [BottomSheetHeaderText(text: MyStrings.withdrawMoney), BottomSheetCloseButton()],
          ),
          const CustomDivider(space: Dimensions.space15),
          CustomAmountTextField(labelText: MyStrings.amount.tr, hintText: MyStrings.amountHint.tr, currency: controller.currency, controller: controller.amountController, onChanged: (value) {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
            child: Row(
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
                        "${Converter.formatNumber(
                          controller.withdrawMoneyList[index].minLimit ?? "",
                        )} ~ "
                        "${Converter.formatNumber(
                          controller.withdrawMoneyList[index].maxLimit ?? "",
                        )} "
                        "${controller.currency}",
                        maxLines: 2,
                        style: regularSmall.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600)),
                  ],
                )),
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
                      "${Converter.formatNumber(controller.withdrawMoneyList[index].withdrawMethod?.fixedCharge ?? "")} "
                      "${controller.currency} + "
                      "${Converter.formatNumber(controller.withdrawMoneyList[index].withdrawMethod?.percentCharge ?? "")}%",
                      maxLines: 2,
                      style: regularSmall.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600),
                    ),
                  ],
                ))
              ],
            ),
          ),
          const SizedBox(height: Dimensions.space25),
          GradientRoundedButton(
            showLoadingIcon: controller.submitLoading,
            text: MyStrings.submit,
            press: () {
              controller.submitData(methodName: controller.withdrawMoneyList[index].name.toString(), methodId: controller.withdrawMoneyList[index].methodId.toString(), userMethodId: controller.withdrawMoneyList[index].id.toString());
            },
          )
        ],
      ),
    );
  }
}
