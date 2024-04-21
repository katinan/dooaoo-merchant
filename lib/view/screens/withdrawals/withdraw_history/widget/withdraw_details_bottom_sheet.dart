import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/date_converter.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/withdraw/withdraw_history_controller.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:viserpay_merchant/view/components/card/bottom_sheet_card.dart';
import 'package:viserpay_merchant/view/components/column_widget/card_column.dart';
import 'package:viserpay_merchant/view/components/text/bottom_sheet_header_text.dart';

class WithdrawDetailsBottomSheet extends StatelessWidget {
  final int index;
  const WithdrawDetailsBottomSheet({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawHistoryController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetHeaderRow(header: MyStrings.withdrawInfo),
          const SizedBox(height: Dimensions.space15),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CardColumn(header: MyStrings.trxId, body: controller.withdrawList[index].trx ?? ""),
            CardColumn(alignmentEnd: true, header: MyStrings.gateway, body: controller.withdrawList[index].method?.name ?? "-----"),
          ]),
          const SizedBox(height: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(MyStrings.amount.tr, style: regularSmall.copyWith(color: MyColor.colorBlack.withOpacity(0.6))),
                      const SizedBox(width: Dimensions.space5),
                      Text(
                        "(${Converter.formatNumber(controller.withdrawList[index].amount ?? "")} - ${Converter.formatNumber(controller.withdrawList[index].charge ?? "")} "
                        "${controller.currency})",
                        style: regularSmall.copyWith(color: MyColor.colorRed, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Text(
                      "${Converter.formatNumber(controller.withdrawList[index].finalAmount ?? "")} "
                      "${controller.currency}",
                      style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis)
                ],
              ),
              CardColumn(
                alignmentEnd: true,
                header: MyStrings.date,
                body: DateConverter.isoStringToLocalDateOnly(controller.withdrawList[index].createdAt ?? ""),
              )
            ],
          ),
          const SizedBox(height: Dimensions.space20),
          controller.withdrawList[index].status == "3" && (controller.withdrawList[index].adminFeedback != "" && controller.withdrawList[index].adminFeedback != null)
              ? CardColumn(
                  alignmentEnd: false,
                  header: MyStrings.details,
                  body: controller.withdrawList[index].adminFeedback ?? "--",
                  bodyMaxLine: 80,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
