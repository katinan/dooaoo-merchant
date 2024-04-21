import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/date_converter.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/home/home_controller.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:viserpay_merchant/view/components/column_widget/card_column.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';
import 'package:viserpay_merchant/view/components/text/bottom_sheet_header_text.dart';

class LatestTransactionBottomSheet extends StatelessWidget {
  final int index;
  const LatestTransactionBottomSheet({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetHeaderRow(header: MyStrings.details),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header: MyStrings.transactionId,
                body: controller.trxList[index].trx ?? "",
              ),
              CardColumn(
                alignmentEnd: true,
                header: MyStrings.date,
                body: "${DateConverter.convertIsoToString(controller.trxList[index].createdAt ?? "")} ",
              )
            ],
          ),
          const SizedBox(height: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                alignmentEnd: true,
                header: MyStrings.amount,
                body: "${controller.defaultCurrencySymbol}${Converter.formatNumber(controller.trxList[index].beforeCharge ?? "")} ",
              ),
              CardColumn(
                alignmentEnd: true,
                header: MyStrings.charge,
                body: "${controller.defaultCurrencySymbol}${Converter.formatNumber(controller.trxList[index].charge ?? "")}",
              ),
            ],
          ),
          const SizedBox(height: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header: MyStrings.finalAmount,
                body: "${controller.defaultCurrencySymbol}${Converter.formatNumber(controller.trxList[index].amount ?? "")}",
              ),
              CardColumn(
                alignmentEnd: true,
                header: MyStrings.remainingBalance,
                body: "${controller.defaultCurrencySymbol}${Converter.formatNumber(controller.trxList[index].postBalance ?? "")}",
              ),
            ],
          ),
          const SizedBox(height: Dimensions.space15),
          CardColumn(
            header: MyStrings.details,
            body: controller.trxList[index].details ?? "",
            bodyMaxLine: 40,
          ),
        ],
      ),
    );
  }
}
