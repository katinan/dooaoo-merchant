import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/withdraw/withdraw_history_controller.dart';

class WithdrawLogTop extends StatelessWidget {
  const WithdrawLogTop({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawHistoryController>(
      builder: (controller) =>Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
          color: MyColor.getCardBgColor(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(MyStrings.transactionNo.tr, style: regularSmall.copyWith(color: MyColor.labelTextColor, fontWeight: FontWeight.w500)),
                  const SizedBox(height: Dimensions.space5),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      cursorColor: MyColor.primaryColor,
                      style: regularSmall.copyWith(color: MyColor.colorBlack),
                      keyboardType: TextInputType.text,
                      controller: controller.searchController,
                      decoration: InputDecoration(
                          hintText: MyStrings.searchByTrxId.tr,
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          hintStyle: regularSmall.copyWith(color: MyColor.hintTextColor),
                          filled: true,
                          fillColor: MyColor.transparentColor,
                          border: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.colorGrey, width: 0.5)),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.colorGrey, width: 0.5)),
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.primaryColor, width: 0.5))
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: Dimensions.space10),

            InkWell(
              onTap: () {
                controller.filterData();
              },
              child: Container(
                height: 45,
                width: 45,
                padding:
                const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.primaryColor,),
                child: const Icon(
                    Icons.search_outlined,
                    color: MyColor.colorWhite,
                    size: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
