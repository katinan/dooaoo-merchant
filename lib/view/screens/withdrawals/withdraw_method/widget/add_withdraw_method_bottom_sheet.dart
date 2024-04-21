import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/withdraw/add_withdraw_method_controller.dart';
import 'package:viserpay_merchant/data/model/withdraw/add_withdraw_method_response_model.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:viserpay_merchant/view/components/card/bottom_sheet_card.dart';

class AddWithdrawMethodBottomSheet extends StatelessWidget {
  const AddWithdrawMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddWithdrawMethodController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 5,
              width: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyColor.colorGrey.withOpacity(0.1),
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [BottomSheetCloseButton()],
          ),
          const SizedBox(height: Dimensions.space15),
          ListView.builder(
              itemCount: controller.methodList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    WithdrawMethod selectedValue = controller.methodList[index];
                    controller.setSelectedMethod(selectedValue);
                    Navigator.pop(context);

                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: BottomSheetCard(
                    child: Text(
                      controller.methodList[index].name ?? "",
                      style: regularDefault,
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
