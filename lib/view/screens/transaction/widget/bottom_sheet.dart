import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/transaction/transaction_history_controller.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:viserpay_merchant/view/components/card/bottom_sheet_card.dart';

showTrxBottomSheet(List<String>? list, int callFrom, {required BuildContext context}) {
  if (list != null && list.isNotEmpty) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: const BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BottomSheetHeaderRow(header: ''),
                    const SizedBox(height: Dimensions.space15),
                    SizedBox(
                      child: ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  String selectedValue = list[index];
                                  final controller = Get.find<TransactionHistoryController>();
                                  if (callFrom == 1) {
                                    controller.setSelectedTransactionType(selectedValue);
                                    controller.filterData();
                                  } else if (callFrom == 2) {
                                    controller.setSelectedOperationType(selectedValue);
                                    controller.filterData();
                                  } else if (callFrom == 3) {
                                    controller.setSelectedHistoryFrom(selectedValue);
                                    controller.filterData();
                                  } else if (callFrom == 4) {
                                    controller.setSelectedWalletCurrency(selectedValue);
                                    controller.filterData();
                                  }
                                  Navigator.pop(context);

                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                child: BottomSheetCard(
                                  child: Text(
                                    ' ${callFrom == 2 ? Converter.replaceUnderscoreWithSpace(list[index].capitalizeFirst ?? '') : callFrom == 3 ? '${list[index] == MyStrings.allTime ? '' : MyStrings.last} ${list[index]}' : list[index]}',
                                    style: semiBoldSmall,
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )),
          );
        });
  }
}
