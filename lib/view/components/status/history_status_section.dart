import 'package:flutter/material.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

class HistoryStatusSection extends StatelessWidget {
  final String status;
  const HistoryStatusSection({super.key,required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: status == "1" ? MyColor.colorGreen
              : status == "2" ? Colors.orangeAccent
              : status == "3" ? Colors.red : MyColor.colorGreen)
      ),
      child: Text(
        status == "1" ? MyStrings.approved
            : status == "2" ? MyStrings.pending
            : status == "3" ? MyStrings.rejected
            : "",
        textAlign: TextAlign.center,
        style: regularExtraSmall.copyWith(
            color: status == "1" ? MyColor.colorGreen
                : status == "2" ? Colors.orangeAccent
                : status == "3" ? Colors.red : MyColor.colorGreen,
        ),
      ),
    );
  }
}
