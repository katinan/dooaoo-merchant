import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/date_converter.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/transaction/transaction_history_controller.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:viserpay_merchant/view/components/column_widget/card_column.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';
import 'package:viserpay_merchant/view/components/text/bottom_sheet_header_text.dart';

class TransactionHistoryBottomSheet extends StatelessWidget {
  final int index;
  const TransactionHistoryBottomSheet({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionHistoryController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeaderRow(header: MyStrings.details),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CardColumn(
                  header: MyStrings.transactionId.tr,
                  body: controller.transactionList[index].trx ?? "",
                ),
              ),
              Expanded(
                child: CardColumn(
                  alignmentEnd: true,
                  header: MyStrings.date.tr,
                  body: "${DateConverter.convertIsoToString(controller.transactionList[index].createdAt ?? "")}",

                  // body: "${Converter.formatNumber(controller.transactionList[index].amount ?? "")} "
                  //     "${controller.currencySym}",
                ),
              )
            ],
          ),
          const SizedBox(height: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header: MyStrings.amount.tr,
                body: "${controller.currencySym}${Converter.formatNumber(controller.transactionList[index].beforeCharge ?? "")}",
              ),
              CardColumn(
                alignmentEnd: true,
                header: MyStrings.charge.tr,
                body: "${controller.currencySym}${Converter.formatNumber(controller.transactionList[index].charge ?? "")}",
              ),
            ],
          ),
          const SizedBox(height: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header: MyStrings.finalAmount.tr,
                body: "${controller.currencySym}${Converter.formatNumber(controller.transactionList[index].amount ?? "")}",
              ),
              CardColumn(
                alignmentEnd: true,
                header: MyStrings.remainingBalance.tr,
                body: "${controller.currencySym}${Converter.formatNumber(controller.transactionList[index].postBalance ?? "")}",
              ),
            ],
          ),
          const SizedBox(height: Dimensions.space15),
          CardColumn(
            alignmentEnd: false,
            header: MyStrings.details.tr,
            body: "${controller.transactionList[index].details}",
            bodyMaxLine: 80,
          )
          // const SizedBox(height: Dimensions.space15),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     CardColumn(
          //       header: MyStrings.remainingBalance.tr,
          //       body: "${controller.currencySym} ${Converter.formatNumber(controller.transactionList[index].postBalance ?? "")}",
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
