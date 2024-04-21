import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/date_converter.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/core/utils/util.dart';
import 'package:viserpay_merchant/data/controller/transaction/transaction_history_controller.dart';

class TransactionCard extends StatelessWidget {
  final int index;
  final VoidCallback press;
  const TransactionCard({super.key, required this.index, required this.press});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionHistoryController>(
      builder: (controller) => GestureDetector(
          onTap: press,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space10),
            decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius), boxShadow: MyUtils.getCardShadow()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Container(
                        height: 35,
                        width: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: controller.transactionList[index].trxType == "-" ? MyColor.colorRed.withOpacity(0.2) : MyColor.colorGreen.withOpacity(0.2), shape: BoxShape.circle),
                        child: Icon(
                          controller.transactionList[index].trxType == "-" ? Icons.arrow_upward : Icons.arrow_downward,
                          color: controller.transactionList[index].trxType == "-" ? MyColor.colorRed : MyColor.colorGreen,
                          size: 20,
                        )),
                    const SizedBox(width: Dimensions.space10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.transactionList[index].remark}".replaceAll("_", " ").toTitleCase().tr,
                            style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: Dimensions.space10),
                          SizedBox(
                            width: 150,
                            child: Text(
                              (controller.transactionList[index].details ?? "").tr,
                              style: regularSmall.copyWith(color: MyColor.getTextColor().withOpacity(0.5)),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateConverter.convertIsoToString(controller.transactionList[index].createdAt ?? ""),
                      style: dateTextStyle.copyWith(color: MyColor.getTextColor().withOpacity(0.5)),
                    ),
                    const SizedBox(height: Dimensions.space10),
                    Text(
                      "${Converter.formatNumber(controller.transactionList[index].amount ?? "")} ${controller.currency}",
                      textAlign: TextAlign.end,
                      style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600),
                    )
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
