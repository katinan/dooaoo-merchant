import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/kyc_controller/kyc_controller.dart';
import 'package:viserpay_merchant/data/model/kyc/kyc_response_model.dart';
import 'package:viserpay_merchant/view/screens/auth/kyc/widget/widget/choose_file_list_item.dart';

class ConfirmWithdrawFileItem extends StatefulWidget {

  final int index;

  const ConfirmWithdrawFileItem({super.key,required this.index});

  @override
  State<ConfirmWithdrawFileItem> createState() => _ConfirmWithdrawFileItemState();
}

class _ConfirmWithdrawFileItemState extends State<ConfirmWithdrawFileItem> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<KycController>(builder: (controller){
      FormModel? model=controller.formList[widget.index];
      return SizedBox(
        child:InkWell(
          onTap: (){
            controller.pickFile(widget.index);
          }, child: ChooseFileItem(fileName: model.selectedValue??MyStrings.chooseFile)),
      );
    });
  }
}
